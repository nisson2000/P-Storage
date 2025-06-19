<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\Generic;

use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\InvalidType;
use ReflectionClass;
use RuntimeException;

/** @internal */
final class SeveralExtendTagsFound extends RuntimeException implements InvalidType
{
    /**
     * @param ReflectionClass<object> $reflection
     */
    public function __construct(ReflectionClass $reflection)
    {
        parent::__construct(
            "Only one `@extends` tag should be set for the class `$reflection->name`.",
            1670195494
        );
    }
}
