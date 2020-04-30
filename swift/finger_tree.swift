enum Digit<a> {
    case One(a)
    case Two(a, a)
    case Three(a, a, a)
    case Four (a, a, a, a)
}

enum Node<a> {
    case Node2(a, a)
    case Node3(a, a, a)
}

extension Node {
    func reducer<a>(_ op: (a, a) -> a, node: Node<a>, _ z: a) -> a {
        switch node {
            case .Node2(let a, let b):
                return op(a, op(b, z))
            case .Node3(let a, let b, let c):
                return op(a, op(b, op(c, z)))
        }
    }
    
    func reducel<a>(_ op: (a, a) -> a, _ z: a, node: Node<a>) -> a {
        switch node {
            case .Node2(let b, let a):
                return op(z, op(b, a))
            case .Node3(let c, let b, let a):
                return op(z, op(c, op(b, a)))
        }
    }
}

enum FingerTree<a> {
    case Empty
    case Single(a)
    indirect case Deep(Digit<a>, FingerTree<Node<a>>, Digit<a>)
}

let ft: FingerTree<Int> = .Deep(.One(1), .Single(.Node2(2, 3)), .One(4))
print(ft)
