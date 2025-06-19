<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\Generic;

use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\InvalidType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Type;
use ReflectionClass;
use RuntimeException;

/** @internal */
final class InvalidExtendTagType extends RuntimeException implements InvalidType
{
    /**
     * @param ReflectionClass<object> $reflection
     */
    public function __construct(ReflectionClass $reflection, Type $invalidExtendTag)
    {
        /** @var ReflectionClass<object> $parentClass */
        $parentClass = $reflection->getParentClass();

        parent::__construct(
            "The `@extends` tag of the class `$reflection->name` has invalid type `{$invalidExtendTag->toString()}`, it should be `{$parentClass->name}`.",
            1670181134
        );
    }
}
