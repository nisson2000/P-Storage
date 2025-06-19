<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Definition\Exception;

use OCA\Talk\Vendor\CuyZ\Valinor\Type\Type;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\ClassType;
use LogicException;

/** @internal */
final class InvalidTypeAliasImportClassType extends LogicException
{
    public function __construct(ClassType $classType, Type $type)
    {
        parent::__construct(
            "Importing a type alias can only be done with classes, `{$type->toString()}` was given in class `{$classType->className()}`.",
            1638535608
        );
    }
}
