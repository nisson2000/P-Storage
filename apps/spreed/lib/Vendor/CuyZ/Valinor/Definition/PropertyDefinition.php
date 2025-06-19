<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Definition;

use OCA\Talk\Vendor\CuyZ\Valinor\Type\Type;

/** @internal */
final class PropertyDefinition
{
    public function __construct(
        private string $name,
        private string $signature,
        private Type $type,
        private bool $hasDefaultValue,
        private mixed $defaultValue,
        private bool $isPublic,
        private Attributes $attributes
    ) {}

    public function name(): string
    {
        return $this->name;
    }

    public function signature(): string
    {
        return $this->signature;
    }

    public function type(): Type
    {
        return $this->type;
    }

    public function hasDefaultValue(): bool
    {
        return $this->hasDefaultValue;
    }

    public function defaultValue(): mixed
    {
        return $this->defaultValue;
    }

    public function isPublic(): bool
    {
        return $this->isPublic;
    }

    public function attributes(): Attributes
    {
        return $this->attributes;
    }
}
