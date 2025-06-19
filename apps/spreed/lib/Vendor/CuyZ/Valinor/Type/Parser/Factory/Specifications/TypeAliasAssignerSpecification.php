<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Factory\Specifications;

use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\TypeAliasLexer;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\TypeLexer;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Type;

/** @internal */
final class TypeAliasAssignerSpecification implements TypeParserSpecification
{
    public function __construct(
        /** @var array<string, Type> */
        private array $aliases
    ) {}

    public function transform(TypeLexer $lexer): TypeLexer
    {
        return new TypeAliasLexer($lexer, $this->aliases);
    }
}
