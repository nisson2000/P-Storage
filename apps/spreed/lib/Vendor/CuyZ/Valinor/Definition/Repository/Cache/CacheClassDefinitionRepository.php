<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository\Cache;

use OCA\Talk\Vendor\CuyZ\Valinor\Definition\ClassDefinition;
use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository\ClassDefinitionRepository;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\ClassType;
use OCA\Talk\Vendor\Psr\SimpleCache\CacheInterface;

/** @internal */
final class CacheClassDefinitionRepository implements ClassDefinitionRepository
{
    public function __construct(
        private ClassDefinitionRepository $delegate,
        /** @var CacheInterface<ClassDefinition> */
        private CacheInterface $cache
    ) {}

    public function for(ClassType $type): ClassDefinition
    {
        $key = "class-definition-{$type->toString()}";

        $entry = $this->cache->get($key);

        if ($entry) {
            return $entry;
        }

        $class = $this->delegate->for($type);

        $this->cache->set($key, $class);

        return $class;
    }
}
