<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository\Reflection;

use OCA\Talk\Vendor\CuyZ\Valinor\Definition\ParameterDefinition;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository\AttributesRepository;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Types\UnresolvableType;
use OCA\Talk\Vendor\CuyZ\Valinor\Utility\Reflection\Reflection;
use ReflectionParameter;

/** @internal */
final class ReflectionParameterDefinitionBuilder
{
    public function __construct(private AttributesRepository $attributesFactory) {}

    public function for(ReflectionParameter $reflection, ReflectionTypeResolver $typeResolver): ParameterDefinition
    {
        $name = $reflection->name;
        $signature = Reflection::signature($reflection);
        $type = $typeResolver->resolveType($reflection);
        $isOptional = $reflection->isOptional();
        $isVariadic = $reflection->isVariadic();
        $attributes = $this->attributesFactory->for($reflection);

        if ($reflection->isDefaultValueAvailable()) {
            $defaultValue = $reflection->getDefaultValue();
        } elseif ($reflection->isVariadic()) {
            $defaultValue = [];
        } else {
            $defaultValue = null;
        }

        if ($isOptional
            && ! $type instanceof UnresolvableType
            && ! $type->accepts($defaultValue)
        ) {
            $type = UnresolvableType::forInvalidParameterDefaultValue($signature, $type, $defaultValue);
        }

        return new ParameterDefinition($name, $signature, $type, $isOptional, $isVariadic, $defaultValue, $attributes);
    }
}
