<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository;

use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Attributes;
use ReflectionClass;
use ReflectionFunction;
use ReflectionMethod;
use ReflectionParameter;
use ReflectionProperty;

/** @internal */
interface AttributesRepository
{
    /**
     * @param ReflectionClass<object>|ReflectionProperty|ReflectionMethod|ReflectionFunction|ReflectionParameter $reflector
     */
    public function for(ReflectionClass|ReflectionProperty|ReflectionMethod|ReflectionFunction|ReflectionParameter $reflector): Attributes;
}
