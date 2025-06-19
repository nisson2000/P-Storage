<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Factory\Specifications;

use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\TypeLexer;

/** @internal */
interface TypeParserSpecification
{
    public function transform(TypeLexer $lexer): TypeLexer;
}
