<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token;

use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Exception\UnknownSymbol;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\TokenStream;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Type;

/** @internal */
final class UnknownSymbolToken implements TraversingToken
{
    public function __construct(private string $symbol) {}

    public function traverse(TokenStream $stream): Type
    {
        throw new UnknownSymbol($this->symbol);
    }

    public function symbol(): string
    {
        return $this->symbol;
    }
}
