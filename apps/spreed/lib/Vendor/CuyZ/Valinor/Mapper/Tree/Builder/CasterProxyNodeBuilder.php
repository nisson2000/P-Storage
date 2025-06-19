<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Tree\Builder;

use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Tree\Shell;

/** @internal */
final class CasterProxyNodeBuilder implements NodeBuilder
{
    public function __construct(private NodeBuilder $delegate) {}

    public function build(Shell $shell, RootNodeBuilder $rootBuilder): TreeNode
    {
        if ($shell->hasValue()) {
            $value = $shell->value();

            if ($shell->type()->accepts($value)) {
                return TreeNode::leaf($shell, $value);
            }
        }

        return $this->delegate->build($shell, $rootBuilder);
    }
}
