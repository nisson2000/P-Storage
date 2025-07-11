<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer;

use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\ArrayToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\ClassNameToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\ClassStringToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\ClosingBracketToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\ClosingCurlyBracketToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\ClosingSquareBracketToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\ColonToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\CommaToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\DoubleColonToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\EnumNameToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\FloatValueToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\IntegerToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\IntegerValueToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\IntersectionToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\IterableToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\ListToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\NativeToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\NullableToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\OpeningBracketToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\OpeningCurlyBracketToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\OpeningSquareBracketToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\QuoteToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\Token;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\UnionToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Parser\Lexer\Token\UnknownSymbolToken;
use OCA\Talk\Vendor\CuyZ\Valinor\Utility\Reflection\Reflection;
use UnitEnum;

use function filter_var;
use function is_numeric;
use function strtolower;

/** @internal */
final class NativeLexer implements TypeLexer
{
    public function tokenize(string $symbol): Token
    {
        if (NativeToken::accepts($symbol)) {
            return NativeToken::from($symbol);
        }

        $token = match (strtolower($symbol)) {
            '|' => UnionToken::get(),
            '&' => IntersectionToken::get(),
            '<' => OpeningBracketToken::get(),
            '>' => ClosingBracketToken::get(),
            '[' => OpeningSquareBracketToken::get(),
            ']' => ClosingSquareBracketToken::get(),
            '{' => OpeningCurlyBracketToken::get(),
            '}' => ClosingCurlyBracketToken::get(),
            '::' => DoubleColonToken::get(),
            ':' => ColonToken::get(),
            '?' => NullableToken::get(),
            ',' => CommaToken::get(),
            '"', "'" => new QuoteToken($symbol),
            'int', 'integer' => IntegerToken::get(),
            'array' => ArrayToken::array(),
            'non-empty-array' => ArrayToken::nonEmptyArray(),
            'list' => ListToken::list(),
            'non-empty-list' => ListToken::nonEmptyList(),
            'iterable' => IterableToken::get(),
            'class-string' => ClassStringToken::get(),
            default => null,
        };

        if ($token) {
            return $token;
        }

        if (filter_var($symbol, FILTER_VALIDATE_INT) !== false) {
            return new IntegerValueToken((int)$symbol);
        }

        if (is_numeric($symbol)) {
            return new FloatValueToken((float)$symbol);
        }

        /** @infection-ignore-all */
        if (PHP_VERSION_ID >= 8_01_00 && enum_exists($symbol)) {
            /** @var class-string<UnitEnum> $symbol */
            return new EnumNameToken($symbol);
        }

        if (Reflection::classOrInterfaceExists($symbol)) {
            /** @var class-string $symbol */
            return new ClassNameToken($symbol);
        }

        return new UnknownSymbolToken($symbol);
    }
}
