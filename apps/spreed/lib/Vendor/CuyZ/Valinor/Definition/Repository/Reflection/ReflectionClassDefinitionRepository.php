<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository\Reflection;

use OCA\Talk\Vendor\CuyZ\Valinor\Definition\ClassDefinition;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Exception\ClassTypeAliasesDuplication;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Exception\InvalidTypeAliasImportClass;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Exception\InvalidTypeAliasImportClassType;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Exception\UnknownTypeAliasImport;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\MethodDefinition;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Methods;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Properties;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\PropertyDefinition;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository\AttributesRepository;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository\ClassDefinitionRepository;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\ClassType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\GenericType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\InvalidType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Factory\Specifications\AliasSpecification;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Factory\Specifications\ClassContextSpecification;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Factory\Specifications\TypeAliasAssignerSpecification;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Factory\TypeParserFactory;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\TypeParser;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Type;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Types\UnresolvableType;
use OCA\Talk\Vendor\CuyZ\Valinor\Utility\Reflection\Reflection;
use ReflectionClass;
use ReflectionMethod;
use ReflectionProperty;
use OCA\Talk\Vendor\CuyZ\Valinor\Utility\Reflection\DocParser;

use function array_filter;
use function array_keys;
use function array_map;

/** @internal */
final class ReflectionClassDefinitionRepository implements ClassDefinitionRepository
{
    private TypeParserFactory $typeParserFactory;

    private AttributesRepository $attributesFactory;

    private ReflectionPropertyDefinitionBuilder $propertyBuilder;

    private ReflectionMethodDefinitionBuilder $methodBuilder;

    /** @var array<string, ReflectionTypeResolver> */
    private array $typeResolver = [];

    public function __construct(TypeParserFactory $typeParserFactory, AttributesRepository $attributesFactory)
    {
        $this->typeParserFactory = $typeParserFactory;
        $this->attributesFactory = $attributesFactory;
        $this->propertyBuilder = new ReflectionPropertyDefinitionBuilder($attributesFactory);
        $this->methodBuilder = new ReflectionMethodDefinitionBuilder($attributesFactory);
    }

    public function for(ClassType $type): ClassDefinition
    {
        $reflection = Reflection::class($type->className());

        return new ClassDefinition(
            $type,
            $this->attributesFactory->for($reflection),
            new Properties(...$this->properties($type)),
            new Methods(...$this->methods($type)),
            $reflection->isFinal(),
            $reflection->isAbstract(),
        );
    }

    /**
     * @return list<PropertyDefinition>
     */
    private function properties(ClassType $type): array
    {
        return array_map(
            function (ReflectionProperty $property) use ($type) {
                $typeResolver = $this->typeResolver($type, $property->getDeclaringClass());

                return $this->propertyBuilder->for($property, $typeResolver);
            },
            Reflection::class($type->className())->getProperties()
        );
    }

    /**
     * @return list<MethodDefinition>
     */
    private function methods(ClassType $type): array
    {
        $reflection = Reflection::class($type->className());
        $methods = $reflection->getMethods();

        // Because `ReflectionMethod::getMethods()` wont list the constructor if
        // it comes from a parent class AND is not public, we need to manually
        // fetch it and add it to the list.
        if ($reflection->hasMethod('__construct')) {
            $methods[] = $reflection->getMethod('__construct');
        }

        return array_map(function (ReflectionMethod $method) use ($type) {
            $typeResolver = $this->typeResolver($type, $method->getDeclaringClass());

            return $this->methodBuilder->for($method, $typeResolver);
        }, $methods);
    }

    /**
     * @param ReflectionClass<object> $target
     */
    private function typeResolver(ClassType $type, ReflectionClass $target): ReflectionTypeResolver
    {
        $typeKey = $target->isInterface()
            ? "{$type->toString()}/{$type->className()}"
            : "{$type->toString()}/$target->name";

        if (isset($this->typeResolver[$typeKey])) {
            return $this->typeResolver[$typeKey];
        }

        while ($type->className() !== $target->name) {
            $type = $type->parent();
        }

        $generics = $type instanceof GenericType ? $type->generics() : [];
        $localAliases = $this->localTypeAliases($type);
        $importedAliases = $this->importedTypeAliases($type);

        $duplicates = [];
        $keys = [...array_keys($generics), ...array_keys($localAliases), ...array_keys($importedAliases)];

        foreach ($keys as $key) {
            $sameKeys = array_filter($keys, fn ($value) => $value === $key);

            if (count($sameKeys) > 1) {
                $duplicates[$key] = null;
            }
        }

        if (count($duplicates) > 0) {
            throw new ClassTypeAliasesDuplication($type->className(), ...array_keys($duplicates));
        }

        $advancedParser = $this->typeParserFactory->get(
            new ClassContextSpecification($type->className()),
            new AliasSpecification(Reflection::class($type->className())),
            new TypeAliasAssignerSpecification($generics + $localAliases + $importedAliases)
        );

        $nativeParser = $this->typeParserFactory->get(
            new ClassContextSpecification($type->className())
        );

        return $this->typeResolver[$typeKey] = new ReflectionTypeResolver($nativeParser, $advancedParser);
    }

    /**
     * @return array<string, Type>
     */
    private function localTypeAliases(ClassType $type): array
    {
        $reflection = Reflection::class($type->className());
        $rawTypes = DocParser::localTypeAliases($reflection);

        $typeParser = $this->typeParser($type);

        $types = [];

        foreach ($rawTypes as $name => $raw) {
            try {
                $types[$name] = $typeParser->parse($raw);
            } catch (InvalidType $exception) {
                $raw = trim($raw);

                $types[$name] = UnresolvableType::forLocalAlias($raw, $name, $type, $exception);
            }
        }

        return $types;
    }

    /**
     * @return array<string, Type>
     */
    private function importedTypeAliases(ClassType $type): array
    {
        $reflection = Reflection::class($type->className());
        $importedTypesRaw = DocParser::importedTypeAliases($reflection);

        $typeParser = $this->typeParser($type);

        $importedTypes = [];

        foreach ($importedTypesRaw as $class => $types) {
            try {
                $classType = $typeParser->parse($class);
            } catch (InvalidType) {
                throw new InvalidTypeAliasImportClass($type, $class);
            }

            if (! $classType instanceof ClassType) {
                throw new InvalidTypeAliasImportClassType($type, $classType);
            }

            $localTypes = $this->localTypeAliases($classType);

            foreach ($types as $importedType) {
                if (! isset($localTypes[$importedType])) {
                    throw new UnknownTypeAliasImport($type, $classType->className(), $importedType);
                }

                $importedTypes[$importedType] = $localTypes[$importedType];
            }
        }

        return $importedTypes;
    }

    private function typeParser(ClassType $type): TypeParser
    {
        $specs = [
            new ClassContextSpecification($type->className()),
            new AliasSpecification(Reflection::class($type->className())),
        ];

        if ($type instanceof GenericType) {
            $specs[] = new TypeAliasAssignerSpecification($type->generics());
        }

        return $this->typeParserFactory->get(...$specs);
    }
}
