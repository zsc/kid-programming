# https://course.ccs.neu.edu/cs4410/hw_boa_assignment.html
"""
type prim1 =
  | Add1
  | Sub1

type prim2 =
  | Plus
  | Minus
  | Times

type 'a bind =
  (* the 3rd component is any information specifically about the identifier, like its position *)
  (string * 'a expr * 'a)

and 'a expr =
  | ELet of 'a bind list * 'a expr * 'a
  | EPrim1 of prim1 * 'a expr * 'a
  | EPrim2 of prim2 * 'a expr * 'a expr * 'a
  | EIf of 'a expr * 'a expr * 'a expr * 'a
  | ENumber of int * 'a
  | EId of string * 'a

let rec is_anf (e : 'a expr) : bool =
  match e with
  | EPrim1(_, e, _) -> is_imm e
  | EPrim2(_, e1, e2, _) -> is_imm e1 && is_imm e2
  | ELet(binds, body, _) ->
     List.for_all (fun (_, e, _) -> is_anf e) binds
     && is_anf body
  | EIf(cond, thn, els, _) -> is_imm cond && is_anf thn && is_anf els
  | _ -> is_imm e
and is_imm e =
  match e with
  | ENumber _ -> true
  | EId _ -> true
  | _ -> false
;;
"""

enum Prim1 {
    case PAdd1
    case PSub1
}

enum Prim2 {
    case PPlus
    case PMinus
    case PTimes
}

//typealias Bind <A> = (String, Expr <A>, A)

indirect enum Expr <A> {
    case ELet ([(String, Expr <A>, A)], Expr <A>, A)
    case EPrim1 (Prim1, Expr <A>, A)
    case EPrim2 (Prim2, Expr <A>, Expr <A>, A)
    case EIf (Expr <A>, Expr <A>, Expr <A>, A)
    case ENumber (Int64, A)
    case EId (String, A)
}

func is_imm <A>(_ e: Expr <A>) -> Bool {
    switch e {
        case .ENumber(_, _): return true
        case .EId(_, _): return true
        default: return false
    }
}

func is_anf <A>(_ e: Expr <A>) -> Bool {
    switch e {
        case .EPrim1(_, let e1, _): return is_imm(e1)
        case .EPrim2(_, let e1, let e2, _): return is_imm(e1) && is_imm(e2)
        case .ELet(let binds, let body, _):
            return binds.map({x in second(x)})
                .reduce(true, { x, y in x && y}) && is_anf(body)
        case .EIf(let c, let e1, let e2, _): return is_imm(c) && is_anf(e1) && is_anf(e2)
        default: return is_imm(e)
    }
}

func second<A>(_ inp: (String, Expr <A>, A)) -> Bool {
    let (_, e, _) = inp
    return is_anf(e)
}

let e: Expr <String> =
    .EPrim1(.PAdd1,
            .EId ("str", "anno2"),
            "anno3") 

print(is_anf(e))
