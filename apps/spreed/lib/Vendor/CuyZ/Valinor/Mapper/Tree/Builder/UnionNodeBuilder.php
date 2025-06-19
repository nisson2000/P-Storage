<?php

declare(strict_types=1);

namespace OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Tree\Builder;

use OCA\Talk\Vendor\CuyZ\Valinor\Definition\Repository\ClassDefinitionRepository;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\Factory\ObjectBuilderFactory;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\FilteredObjectBuilder;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Object\ObjectBuilder;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Tree\Exception\CannotResolveTypeFromUnion;
use OCA\Talk\Vendor\CuyZ\Valinor\Mapper\Tree\Shell;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\ScalarType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Type;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\ClassType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Types\NullType;
use OCA\Talk\Vendor\CuyZ\Valinor\Type\Types\UnionType;

use function count;

/** @internal */
final class UnionNodeBuilder implements NodeBuilder
{
    public function __construct(
        private NodeBuilder $delegate,
        private ClassDefinitionRepository $classDefinitionRepository,
        private ObjectBuilderFactory $objectBuilderFactory,
        private ObjectNodeBuilder $objectNodeBuilder,
        private bool $enableFlexibleCasting
    ) {}

    public function build(Shell $shell, RootNodeBuilder $rootBuilder): TreeNode
    {
        $type = $shell->type();

        if (! $type instanceof UnionType) {
            return $this->delegate->build($shell, $rootBuilder);
        }

        $classNode = $this->tryToBuildClassNode($type, $shell, $rootBuilder);

        if ($classNode instanceof TreeNode) {
            return $classNode;
        }

        $narrowedType = $this->narrow($type, $shell->value());

        return $rootBuilder->build($shell->withType($narrowedType));
    }

    private function narrow(UnionType $type, mixed $source): Type
    {
        $subTypes = $type->types();

        if ($source !== null && count($subTypes) === 2) {
            if ($subTypes[0] instanceof NullType) {
                return $subTypes[1];
            } elseif ($subTypes[1] instanceof NullType) {
                return $subTypes[0];
            }
        }

        foreach ($subTypes as $subType) {
            if (! $subType instanceof ScalarType) {
                continue;
            }

            if (! $this->enableFlexibleCasting) {
                continue;
            }

            if ($subType->canCast($source)) {
                return $subType;
            }
        }

        throw new CannotResolveTypeFromUnion($source, $type);
    }

    private function tryToBuildClassNode(UnionType $type, Shell $shell, RootNodeBuilder $rootBuilder): ?TreeNode
    {
        $classTypes = [];

        foreach ($type->types() as $subType) {
            if ($subType instanceof NullType) {
                continue;
            }

            if (! $subType instanceof ClassType) {
                return null;
            }

            $classTypes[] = $subType;
        }

        $objectBuilder = $this->objectBuilder($shell->value(), ...$classTypes);

        return $this->objectNodeBuilder->build($objectBuilder, $shell, $rootBuilder);
    }

    private function objectBuilder(mixed $value, ClassType ...$types): ObjectBuilder
    {
        $builders = [];

        foreach ($types as $type) {
            $class = $this->classDefinitionRepository->for($type);

            $builders = [...$builders, ...$this->objectBuilderFactory->for($class)];
        }

        return new FilteredObjectBuilder($value, ...$builders);
    }
}
