<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository\Cache\Compiler;

use OCA\Talk\Vendor\CuyZ\Valinor\Cache\Compiled\CacheCompiler;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\FunctionDefinition;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\ParameterDefinition;

use function var_export;

/** @internal */
final class FunctionDefinitionCompiler implements CacheCompiler
{
    private TypeCompiler $typeCompiler;

    private AttributesCompiler $attributesCompiler;

    private ParameterDefinitionCompiler $parameterCompiler;

    public function __construct()
    {
        $this->typeCompiler = new TypeCompiler();
        $this->attributesCompiler = new AttributesCompiler();

        $this->parameterCompiler = new ParameterDefinitionCompiler($this->typeCompiler, new AttributesCompiler());
    }

    public function compile(mixed $value): string
    {
        assert($value instanceof FunctionDefinition);

        $parameters = array_map(
            fn (ParameterDefinition $parameter) => $this->parameterCompiler->compile($parameter),
            iterator_to_array($value->parameters())
        );

        $attributes = $this->attributesCompiler->compile($value->attributes());
        $fileName = var_export($value->fileName(), true);
        $class = var_export($value->class(), true);
        $isStatic = var_export($value->isStatic(), true);
        $isClosure = var_export($value->isClosure(), true);
        $parameters = implode(', ', $parameters);
        $returnType = $this->typeCompiler->compile($value->returnType());

        return <<<PHP
            new \OCA\Talk\Vendor\CuyZ\Valinor\Definition\FunctionDefinition(
                '{$value->name()}',
                '{$value->signature()}',
                $attributes,
                $fileName,
                $class,
                $isStatic,
                $isClosure,
                new \OCA\Talk\Vendor\CuyZ\Valinor\Definition\Parameters($parameters),
                $returnType
            )
            PHP;
    }
}
