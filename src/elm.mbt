// below first some default declarations included in every transpiled bundle

///|
pub fn[A] basics_identity(thing : A) -> A {
  thing
}

///|
pub fn[Keep, Ignore] basics_always(keep : Keep, _ : Ignore) -> Keep {
  keep
}

///|
pub fn basics_not(bool : Bool) -> Bool {
  !bool
}

///|
pub(all) enum BasicsOrder {
  LT
  EQ
  GT
}

///|
fn int_to_basics_order(as_int : Int) -> BasicsOrder {
  if as_int <= -1 {
    BasicsOrder::LT
  } else if as_int >= 1 {
    BasicsOrder::GT
  } else {
    BasicsOrder::EQ
  }
}

///|
pub fn[C : Compare] basics_compare(a : C, b : C) -> BasicsOrder {
  int_to_basics_order(C::compare(a, b))
}

///|
pub let basics_e : Double = @math.exp(1.0)

///|
pub fn[E : Eq] basics_neq(a : E, b : E) -> Bool {
  E::equal(a, b)
}

///|
pub fn[E : Eq] basics_eq(a : E, b : E) -> Bool {
  E::equal(a, b)
}

///|
pub fn[N : Compare] basics_lt(a : N, b : N) -> Bool {
  a < b
}

///|
pub fn[N : Compare] basics_le(a : N, b : N) -> Bool {
  a <= b
}

///|
pub fn[N : Compare] basics_gt(a : N, b : N) -> Bool {
  a > b
}

///|
pub fn[N : Compare] basics_ge(a : N, b : N) -> Bool {
  a >= b
}

///|
pub fn[N : Add] basics_add(a : N, b : N) -> N {
  a + b
}

///|
pub fn[N : Sub] basics_sub(base : N, reduction : N) -> N {
  base - reduction
}

///|
pub fn[N : Mul] basics_mul(a : N, b : N) -> N {
  a * b
}

///|
pub fn[C : Compare] basics_clamp(minimum : C, maximum : C, toClamp : C) -> C {
  if toClamp < minimum {
    minimum
  } else if toClamp > maximum {
    maximum
  } else {
    toClamp
  }
}

///|
pub fn[In, Out] basics_apr(food : In, eat : (In) -> Out) -> Out {
  eat(food)
}

///|
pub fn[In, Out] basics_apl(eat : (In) -> Out, food : In) -> Out {
  eat(food)
}

///|
pub fn[A, B, C] basics_composel(aToB : (A) -> B, bToC : (B) -> C) -> (A) -> C {
  fn(a) { bToC(aToB(a)) }
}

///|
pub fn[A, B, C] basics_composer(aToB : (A) -> B, bToC : (B) -> C) -> (A) -> C {
  fn(a) { bToC(aToB(a)) }
}

///|
pub fn[A] list_cons(newHead : A, tail : @list.List[A]) -> @list.List[A] {
  @list.List::prepend(tail, newHead)
}
