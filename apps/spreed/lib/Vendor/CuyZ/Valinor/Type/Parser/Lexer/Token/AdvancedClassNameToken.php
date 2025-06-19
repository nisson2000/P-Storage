<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token;

use OCA\Talk\Vendor\CuyZ\Valinor\Type\IntegerType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\Generic\AssignedGenericNotFound;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\Generic\CannotAssignGeneric;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\Generic\GenericClosingBracketMissing;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\Generic\GenericCommaMissing;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\Generic\InvalidAssignedGeneric;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\Generic\InvalidExtendTagClassName;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\Generic\InvalidExtendTagType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\Generic\MissingGenerics;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\Generic\ExtendTagTypeError;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\Generic\SeveralExtendTagsFound;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\InvalidType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\Template\InvalidClassTemplate;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Factory\Specifications\AliasSpecification;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Factory\Specifications\ClassContextSpecification;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Factory\Specifications\TypeAliasAssignerSpecification;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Factory\Specifications\TypeParserSpecification;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Factory\TypeParserFactory;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\TokenStream;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\TypeParser;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\StringType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Type;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Types\ArrayKeyType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\ClassType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Types\MixedType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Types\NativeClassType;
use OCA\Talk\Vendor\CuyZ\Valinor\Utility\Reflection\DocParser;
use OCA\Talk\Vendor\CuyZ\Valinor\Utility\Reflection\Reflection;
use ReflectionClass;

use function array_keys;
use function array_shift;
use function array_slice;
use function count;

/** @internal */
final class AdvancedClassNameToken implements TraversingToken
{
    public function __construct(
        private ClassNameToken $delegate,
        private TypeParserFactory $typeParserFactory,
    ) {}

    public function traverse(TokenStream $stream): Type
    {
        $type = $this->delegate->traverse($stream);

        if (! $type instanceof ClassType) {
            return $type;
        }

        $className = $type->className();
        $reflection = Reflection::class($className);
        $parentReflection = $reflection->getParentClass();

        $specifications = [
            new ClassContextSpecification($className),
            new AliasSpecification($reflection),
        ];

        $templates = $this->templatesTypes($reflection, ...$specifications);

        $generics = $this->generics($stream, $className, $templates);
        $generics = $this->assignGenerics($className, $templates, $generics);

        if ($parentReflection) {
            $parserWithGenerics = $this->typeParserFactory->get(new TypeAliasAssignerSpecification($generics), ...$specifications);

            $parentType = $this->parentType($reflection, $parentReflection, $parserWithGenerics);
        }

        return new NativeClassType($className, $generics, $parentType ?? null);
    }

    public function symbol(): string
    {
        return $this->delegate->symbol();
    }

    /**
     * @param ReflectionClass<object> $reflection
     * @return array<string, Type>
     */
    private function templatesTypes(ReflectionClass $reflection, TypeParserSpecification ...$specifications): array
    {
        $templates = DocParser::classTemplates($reflection);

        if ($templates === []) {
            return [];
        }

        $types = [];

        foreach ($templates as $templateName => $type) {
            try {
                if ($type === '') {
                    $types[$templateName] = MixedType::get();
                } else {
                    /** @infection-ignore-all */
                    $parser ??= $this->typeParserFactory->get(...$specifications);

                    $types[$templateName] = $parser->parse($type);
                }
            } catch (InvalidType $invalidType) {
                throw new InvalidClassTemplate($reflection->name, $templateName, $invalidType);
            }
        }

        return $types;
    }

    /**
     * @param array<string, Type> $templates
     * @param class-string $className
     * @return Type[]
     */
    private function generics(TokenStream $stream, string $className, array $templates): array
    {
        if ($stream->done() || ! $stream->next() instanceof OpeningBracketToken) {
            return [];
        }

        $generics = [];

        $stream->forward();

        while (true) {
            if ($stream->done()) {
                throw new MissingGenerics($className, $generics, $templates);
            }

            $generics[] = $stream->read();

            if ($stream->done()) {
                throw new GenericClosingBracketMissing($className, $generics);
            }

            $next = $stream->forward();

            if ($next instanceof ClosingBracketToken) {
                break;
            }

            if (! $next instanceof CommaToken) {
                throw new GenericCommaMissing($className, $generics);
            }
        }

        return $generics;
    }

    /**
     * @param class-string $className
     * @param array<string, Type> $templates
     * @param Type[] $generics
     * @return array<string, Type>
     */
    private function assignGenerics(string $className, array $templates, array $generics): array
    {
        $assignedGenerics = [];

        foreach ($templates as $name => $template) {
            $generic = array_shift($generics);

            if ($generic === null) {
                $remainingTemplates = array_keys(array_slice($templates, count($assignedGenerics)));

                throw new AssignedGenericNotFound($className, ...$remainingTemplates);
            }

            if ($template instanceof ArrayKeyType && $generic instanceof StringType) {
                $generic = ArrayKeyType::string();
            }

            if ($template instanceof ArrayKeyType && $generic instanceof IntegerType) {
                $generic = ArrayKeyType::integer();
            }

            if (! $generic->matches($template)) {
                throw new InvalidAssignedGeneric($generic, $template, $name, $className);
            }

            $assignedGenerics[$name] = $generic;
        }

        if (! empty($generics)) {
            throw new CannotAssignGeneric($className, ...$generics);
        }

        return $assignedGenerics;
    }

    /**
     * @param ReflectionClass<object> $reflection
     * @param ReflectionClass<object> $parentReflection
     */
    private function parentType(ReflectionClass $reflection, ReflectionClass $parentReflection, TypeParser $typeParser): NativeClassType
    {
        $extendedClass = DocParser::classExtendsTypes($reflection);

        if (count($extendedClass) > 1) {
            throw new SeveralExtendTagsFound($reflection);
        } elseif (count($extendedClass) === 0) {
            $extendedClass = $parentReflection->name;
        } else {
            $extendedClass = $extendedClass[0];
        }

        try {
            $parentType = $typeParser->parse($extendedClass);
        } catch (InvalidType $exception) {
            throw new ExtendTagTypeError($reflection, $exception);
        }

        if (! $parentType instanceof NativeClassType) {
            throw new InvalidExtendTagType($reflection, $parentType);
        }

        if ($parentType->className() !== $parentReflection->name) {
            throw new InvalidExtendTagClassName($reflection, $parentType);
        }

        return $parentType;
    }
}
