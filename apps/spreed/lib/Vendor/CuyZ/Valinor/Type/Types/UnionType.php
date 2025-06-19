<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Type\Types;

use OCA\Talk\Vendor\CuyZ\Valinor\Type\CombiningType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\CompositeType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Type;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Types\Exception\ForbiddenMixedType;

use function array_map;
use function implode;

/** @internal */
final class UnionType implements CombiningType
{
    /** @var Type[] */
    private array $types = [];

    private string $signature;

    public function __construct(Type ...$types)
    {
        $this->signature = implode('|', array_map(fn (Type $type) => $type->toString(), $types));

        foreach ($types as $type) {
            if ($type instanceof self) {
                foreach ($type->types as $subType) {
                    $this->types[] = $subType;
                }

                continue;
            }

            if ($type instanceof MixedType) {
                throw new ForbiddenMixedType();
            }

            $this->types[] = $type;
        }
    }

    public function accepts(mixed $value): bool
    {
        foreach ($this->types as $type) {
            if ($type->accepts($value)) {
                return true;
            }
        }

        return false;
    }

    public function matches(Type $other): bool
    {
        if ($other instanceof self) {
            foreach ($this->types as $type) {
                if (! $other->isMatchedBy($type)) {
                    return false;
                }
            }

            return true;
        }

        foreach ($this->types as $type) {
            if (! $type->matches($other)) {
                return false;
            }
        }

        return true;
    }

    public function isMatchedBy(Type $other): bool
    {
        foreach ($this->types as $type) {
            if ($other->matches($type)) {
                return true;
            }
        }

        return false;
    }

    public function traverse(): array
    {
        $types = [];

        foreach ($this->types as $type) {
            $types[] = $type;

            if ($type instanceof CompositeType) {
                $types = [...$types, ...$type->traverse()];
            }
        }

        return $types;
    }

    public function types(): array
    {
        return $this->types;
    }

    public function toString(): string
    {
        return $this->signature;
    }
}
