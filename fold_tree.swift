indirect enum Tree<a,b> {
    case Leaf(b)
    case Node(a, [Tree<a,b>])
}

func foldTree<a, b, c>(_ op: ((a, [c])->c), _ f: ((b)->c), _ tree:Tree<a,b>) -> c{
    switch tree {
        case .Leaf(let x):
            return f(x)
        case .Node(let x, let xs):
            return op(x, xs.map { foldTree(op, f, $0) })
    }
}

func catMaybes<a>(_ xs: [a?]) -> [a] {
    return xs.filter {$0 != nil}.map { $0! }
}

func catMaybeTree<a, b>(_ t: Tree<a, b?>) -> Tree<a, b>? {
    func f<a, b>(_ x: b?) -> Tree<a, b>? {
        if x == nil {
            return nil
        } else {
            return .Leaf(x!)
        }
    }
    return foldTree({ .Node($0, catMaybes($1)) }, f, t)
}

print(catMaybes([1, 2, nil, 4]))
let x: Tree<Int, Int?> = .Node(2, [.Leaf(nil), .Node(2, []), .Leaf(3)])
print(catMaybeTree(x)!)
