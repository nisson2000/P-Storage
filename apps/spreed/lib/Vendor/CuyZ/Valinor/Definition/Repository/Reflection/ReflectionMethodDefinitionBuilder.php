<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository\Reflection;

use OCA\Talk\Vendor\CuyZ\Valinor\Definition\MethodDefinition;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Parameters;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository\AttributesRepository;
use OCA\Talk\Vendor\CuyZ\Valinor\Utility\Reflection\Reflection;
use ReflectionMethod;
use ReflectionParameter;

use function array_map;

/** @internal */
final class ReflectionMethodDefinitionBuilder
{
    private ReflectionParameterDefinitionBuilder $parameterBuilder;

    public function __construct(AttributesRepository $attributesRepository)
    {
        $this->parameterBuilder = new ReflectionParameterDefinitionBuilder($attributesRepository);
    }

    public function for(ReflectionMethod $reflection, ReflectionTypeResolver $typeResolver): MethodDefinition
    {
        $parameters = array_map(
            fn (ReflectionParameter $parameter) => $this->parameterBuilder->for($parameter, $typeResolver),
            $reflection->getParameters()
        );

        $returnType = $typeResolver->resolveType($reflection);

        return new MethodDefinition(
            $reflection->name,
            Reflection::signature($reflection),
            new Parameters(...$parameters),
            $reflection->isStatic(),
            $reflection->isPublic(),
            $returnType
        );
    }
}
