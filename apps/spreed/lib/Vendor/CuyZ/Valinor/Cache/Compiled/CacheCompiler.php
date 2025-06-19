<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Cache\Compiled;

/** @internal */
interface CacheCompiler
{
    public function compile(mixed $value): string;
}
