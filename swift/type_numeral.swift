enum Nat {
    case Z
    indirect case S(Nat)
}

func inc(_ x: Nat) -> Nat {
    return .S(x) as Nat
}

func undefined<T>(hint: String = "", file: StaticString = #file, line: UInt = #line) -> T {
    let message = hint == "" ? "" : ": \(hint)"
    fatalError("undefined \(T.self)\(message)", file:file, line:line)
}

let x: Nat = .S(.S(.Z))
//toInt(x)

func toInt(_ x: Nat) -> Int {
    switch x {
        case .Z: return 0
        case .S(let y): return 1 + toInt(y)
    }
}

struct Val <A, B> {
    let val: B
}

func inc(_ x: Val <Int, Nat>) -> Val <Int, Nat> {
    return x
}
