<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\Factory;

use OCA\Talk\Vendor\CuyZ\Valinor\Definition\ClassDefinition;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\FunctionObject;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\FunctionsContainer;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\DynamicConstructor;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\Exception\CannotInstantiateObject;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\Exception\InvalidConstructorClassTypeParameter;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\Exception\InvalidConstructorReturnType;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\Exception\MissingConstructorClassTypeParameter;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\FunctionObjectBuilder;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\MethodObjectBuilder;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\NativeConstructorObjectBuilder;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\NativeEnumObjectBuilder;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\ObjectBuilder;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\ClassType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\ObjectType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Types\ClassStringType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Types\EnumType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Types\NativeStringType;

use function array_key_exists;
use function count;
use function is_a;

/** @internal */
final class ConstructorObjectBuilderFactory implements ObjectBuilderFactory
{
    /** @var list<FunctionObject> */
    private array $filteredConstructors;

    public function __construct(
        private ObjectBuilderFactory $delegate,
        /** @var array<class-string, null> */
        private array $nativeConstructors,
        private FunctionsContainer $constructors
    ) {}

    public function for(ClassDefinition $class): array
    {
        $builders = $this->builders($class);

        if (count($builders) === 0) {
            if ($class->methods()->hasConstructor()) {
                throw new CannotInstantiateObject($class);
            }

            return $this->delegate->for($class);
        }

        return $builders;
    }

    /**
     * @return list<ObjectBuilder>
     */
    private function builders(ClassDefinition $class): array
    {
        $className = $class->name();
        $classType = $class->type();
        $methods = $class->methods();

        $builders = [];

        foreach ($this->filteredConstructors() as $constructor) {
            if (! $this->constructorMatches($constructor, $classType)) {
                continue;
            }

            $definition = $constructor->definition();
            $functionClass = $definition->class();

            if ($functionClass && $definition->isStatic() && ! $definition->isClosure()) {
                $scopedClass = is_a($className, $functionClass, true) ? $className : $functionClass;

                $builders[] = new MethodObjectBuilder($scopedClass, $definition->name(), $definition->parameters());
            } else {
                $builders[] = new FunctionObjectBuilder($constructor, $classType);
            }
        }

        if (! array_key_exists($className, $this->nativeConstructors) && count($builders) > 0) {
            return $builders;
        }

        if ($classType instanceof EnumType) {
            $builders[] = new NativeEnumObjectBuilder($classType);
        } elseif ($methods->hasConstructor() && $methods->constructor()->isPublic()) {
            $builders[] = new NativeConstructorObjectBuilder($class);
        }

        return $builders;
    }

    private function constructorMatches(FunctionObject $function, ClassType $classType): bool
    {
        $definition = $function->definition();
        $parameters = $definition->parameters();
        $returnType = $definition->returnType();

        if (! $classType->matches($returnType)) {
            return false;
        }

        if (! $definition->attributes()->has(DynamicConstructor::class)) {
            return true;
        }

        if (count($parameters) === 0) {
            throw new MissingConstructorClassTypeParameter($definition);
        }

        $parameterType = $parameters->at(0)->type();

        if ($parameterType instanceof NativeStringType) {
            $parameterType = ClassStringType::get();
        }

        if (! $parameterType instanceof ClassStringType) {
            throw new InvalidConstructorClassTypeParameter($definition, $parameterType);
        }

        $subType = $parameterType->subType();

        if ($subType) {
            return $classType->matches($subType);
        }

        return true;
    }

    /**
     * @return list<FunctionObject>
     */
    private function filteredConstructors(): array
    {
        if (! isset($this->filteredConstructors)) {
            $this->filteredConstructors = [];

            foreach ($this->constructors as $constructor) {
                $function = $constructor->definition();

                if (enum_exists($function->class() ?? '') && in_array($function->name(), ['from', 'tryFrom'], true)) {
                    continue;
                }

                if (! $function->returnType() instanceof ObjectType) {
                    throw new InvalidConstructorReturnType($function);
                }

                $this->filteredConstructors[] = $constructor;
            }
        }

        return $this->filteredConstructors;
    }
}
