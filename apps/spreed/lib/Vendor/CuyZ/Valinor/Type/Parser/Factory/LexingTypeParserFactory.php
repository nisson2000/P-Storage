<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Factory;

use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\CachedParser;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Factory\Specifications\TypeParserSpecification;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\AdvancedClassLexer;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\NativeLexer;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\LexingParser;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\TypeParser;

/** @internal */
final class LexingTypeParserFactory implements TypeParserFactory
{
    private TypeParser $nativeParser;

    public function get(TypeParserSpecification ...$specifications): TypeParser
    {
        if (empty($specifications)) {
            return $this->nativeParser ??= $this->nativeParser();
        }

        $lexer = new NativeLexer();
        $lexer = new AdvancedClassLexer($lexer, $this);

        foreach ($specifications as $specification) {
            $lexer = $specification->transform($lexer);
        }

        return new LexingParser($lexer);
    }

    private function nativeParser(): TypeParser
    {
        $lexer = new NativeLexer();
        $lexer = new AdvancedClassLexer($lexer, $this);
        $parser = new LexingParser($lexer);

        return new CachedParser($parser);
    }
}
