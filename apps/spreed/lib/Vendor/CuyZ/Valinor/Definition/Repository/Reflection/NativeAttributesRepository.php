<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository\Reflection;

use OCA\Talk\Vendor\CuyZ\Valinor\Definition\NativeAttributes;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository\AttributesRepository;
use Reflector;

/** @internal */
final class NativeAttributesRepository implements AttributesRepository
{
    public function for(Reflector $reflector): NativeAttributes
    {
        return new NativeAttributes($reflector);
    }
}
