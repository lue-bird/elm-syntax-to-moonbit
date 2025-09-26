// All random_* and Random* declarations are
// derived and modified from elm/random.
// All time_* and Time* declarations are
// derived and modified from elm/time.
// Both elm/random and elm/time are licensed under:
// 
// Copyright (c) 2018-present, Evan Czaplicki
// 
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
// 
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
// 
//     * Neither the name of Evan Czaplicki nor the names of other
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

///|
pub fn[S : Show] debug_to_string(thing : S) -> StringString {
  StringString::One(S::to_string(thing))
}

///|
pub fn[S : Show] debug_log(tag : StringString, thing : S) -> S {
  println("\{string_string_to_string(tag)}: \{thing}")
  thing
}

///|
pub fn[S] debug_todo(message : StringString) -> S {
  println("\{string_string_to_string(message)}")
  ...
}

///|
pub fn[A] basics_identity(thing : A) -> A {
  thing
}

///|
pub fn[Keep, Ignore] basics_always(keep : Keep, _ : Ignore) -> Keep {
  keep
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
pub fn[A, B, C] basics_composer(
  a_to_b : (A) -> B,
  b_to_c : (B) -> C,
) -> (A) -> C {
  fn(a) { b_to_c(a_to_b(a)) }
}

///|
pub fn[A, B, C] basics_composel(
  b_to_c : (B) -> C,
  a_to_b : (A) -> B,
) -> (A) -> C {
  fn(a) { b_to_c(a_to_b(a)) }
}

///|
pub fn basics_not(bool : Bool) -> Bool {
  !bool
}

///|
#inline
pub fn basics_and(a : Bool, b : Bool) -> Bool {
  a && b
}

///|
#inline
pub fn basics_or(a : Bool, b : Bool) -> Bool {
  a || b
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
fn basics_order_to_int(order : BasicsOrder) -> Int {
  match order {
    BasicsOrder::EQ => 0
    BasicsOrder::LT => -1
    BasicsOrder::GT => 1
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
pub fnalias Int64::div as basics_idiv

///|
pub fnalias Double::div as basics_fdiv

///|
pub fn basics_remainder_by(to_divide_by : Int64, n : Int64) -> Int64 {
  n % to_divide_by
}

///|
pub fn basics_mod_by(to_divide_by : Int64, n : Int64) -> Int64 {
  // https://github.com/elm/core/blob/1.0.5/src/Elm/Kernel/Basics.js#L20
  // https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf
  if to_divide_by == 0L {
    // will panic
    n % 0
  } else {
    let remainder : Int64 = n % to_divide_by
    if (remainder > 0L && to_divide_by < 0L) ||
      (remainder < 0L && to_divide_by > 0L) {
      remainder + to_divide_by
    } else {
      remainder
    }
  }
}

///|
pub fnalias Double::is_nan as basics_is_nan

///|
pub fnalias Double::sqrt as basics_sqrt

///|
pub fnalias Double::is_inf as basics_is_infinite

///|
pub fn basics_ceiling(float : Double) -> Int64 {
  Double::to_int64(Double::ceil(float))
}

///|
pub fn basics_floor(float : Double) -> Int64 {
  Double::to_int64(Double::floor(float))
}

///|
pub fn basics_round(float : Double) -> Int64 {
  Double::to_int64(Double::round(float))
}

///|
pub fn basics_truncate(float : Double) -> Int64 {
  Double::to_int64(float)
}

///|
pub fn[N : Neg] basics_negate(n : N) -> N {
  N::neg(n)
}

///|
pub fn basics_log_base(base : Double, n : Double) -> Double {
  @math.ln(n) / @math.ln(base)
}

///|
pub fn basics_to_radians(degrees : Double) -> Double {
  degrees / 180 * @math.PI
}

///|
pub fn basics_turns(turns : Double) -> Double {
  turns * 2 * @math.PI
}

///|
pub fn basics_to_polar(xy : (Double, Double)) -> (Double, Double) {
  let (x, y) = xy
  (Double::sqrt(x * x + y * y), @math.atan2(y, x))
}

///|
pub fn basics_from_polar(polar : (Double, Double)) -> (Double, Double) {
  let (radius, theta) = polar
  (radius * @math.cos(theta), radius * @math.sin(theta))
}

///|
pub fn[C : Compare] basics_clamp(minimum : C, maximum : C, n : C) -> C {
  if n < minimum {
    minimum
  } else if n > maximum {
    maximum
  } else {
    n
  }
}

///|
pub fnalias Int64::to_double as basics_to_float

///|
pub fn basics_pow_int(n : Int64, exponent : Int64) -> Int64 {
  Double::to_int64(@math.pow(Int64::to_double(n), Int64::to_double(exponent)))
}

///|
pub(all) enum BasicsNever {}

///|
pub fn[YourChoice] basics_never(ever : BasicsNever) -> YourChoice {
  match ever {

  }
}

///|
pub fn bitwise_shift_left_by(shift_bit_count : Int64, n : Int64) -> Int64 {
  Int::to_int64(Int64::to_int(n) << Int64::to_int(shift_bit_count))
}

///|
pub fn bitwise_shift_right_by(shift_bit_count : Int64, n : Int64) -> Int64 {
  Int::to_int64(Int64::to_int(n) >> Int64::to_int(shift_bit_count))
}

///|
pub fn bitwise_shift_right_zf_by(shift_bit_count : Int64, n : Int64) -> Int64 {
  UInt::to_int64(Int::reinterpret_as_uint(Int64::to_int(n))) >>
  Int64::to_int(shift_bit_count)
}

///|
pub fn bitwise_complement(n : Int64) -> Int64 {
  Int::to_int64(Int::lnot(Int64::to_int(n)))
}

///|
pub fn bitwise_xor(a : Int64, b : Int64) -> Int64 {
  Int::to_int64(Int64::to_int(a) ^ Int64::to_int(b))
}

///|
pub fn bitwise_and(a : Int64, b : Int64) -> Int64 {
  Int::to_int64(Int64::to_int(a) & Int64::to_int(b))
}

///|
pub fn bitwise_or(a : Int64, b : Int64) -> Int64 {
  Int::to_int64(Int64::to_int(a) | Int64::to_int(b))
}

///|
pub fn char_to_code(char : Char) -> Int64 {
  Int::to_int64(Char::to_int(char))
}

///|
pub fn char_from_code(code : Int64) -> Char {
  Option::unwrap_or(Int::to_char(Int64::to_int(code)), '\u{0}')
}

///|
pub fnalias Char::is_ascii_lowercase as char_is_lower

///|
pub fnalias Char::is_ascii_uppercase as char_is_upper

///|
pub fnalias Char::is_ascii_hexdigit as char_is_hex_digit

///|
pub fnalias Char::is_ascii_octdigit as char_is_oct_digit

///|
pub fnalias Char::is_ascii_digit as char_is_digit

///|
pub fnalias Char::is_ascii_alphabetic as char_is_alpha

///|
pub fn char_is_alpha_num(char : Char) -> Bool {
  Char::is_ascii_alphabetic(char) || Char::is_ascii_digit(char)
}

///|
pub fn char_to_lower(char : Char) -> Char {
  Option::unwrap_or(
    String::get_char(String::to_lower(Char::to_string(char)), 0),
    '\u{0}',
  )
}

///|
pub fn char_to_upper(char : Char) -> Char {
  Option::unwrap_or(
    String::get_char(String::to_upper(Char::to_string(char)), 0),
    '\u{0}',
  )
}

///|
pub fn[A] maybe_with_default(value_on_nothing : A, maybe : A?) -> A {
  Option::unwrap_or(maybe, value_on_nothing)
}

///|
pub fn[A, B] maybe_and_then(on_value : (A) -> B?, maybe : A?) -> B? {
  Option::bind(maybe, on_value)
}

///|
pub fn[A, B] maybe_map(value_change : (A) -> B, maybe : A?) -> B? {
  Option::map(maybe, value_change)
}

///|
pub fn[A, B, Combined] maybe_map2(
  combine : (A, B) -> Combined,
  a_maybe : A?,
  b_maybe : B?,
) -> Combined? {
  match (a_maybe, b_maybe) {
    (Option::Some(a), Option::Some(b)) => Option::Some(combine(a, b))
    (Option::None, _) | (_, Option::None) => Option::None
  }
}

///|
pub fn[A, B, C, Combined] maybe_map3(
  combine : (A, B, C) -> Combined,
  a_maybe : A?,
  b_maybe : B?,
  c_maybe : C?,
) -> Combined? {
  match (a_maybe, b_maybe, c_maybe) {
    (Option::Some(a), Option::Some(b), Option::Some(c)) =>
      Option::Some(combine(a, b, c))
    (Option::None, _, _) | (_, Option::None, _) | (_, _, Option::None) =>
      Option::None
  }
}

///|
pub fn[A, B, C, D, Combined] maybe_map4(
  combine : (A, B, C, D) -> Combined,
  a_maybe : A?,
  b_maybe : B?,
  c_maybe : C?,
  d_maybe : D?,
) -> Combined? {
  match (a_maybe, b_maybe, c_maybe, d_maybe) {
    (Option::Some(a), Option::Some(b), Option::Some(c), Option::Some(d)) =>
      Option::Some(combine(a, b, c, d))
    (Option::None, _, _, _)
    | (_, Option::None, _, _)
    | (_, _, Option::None, _)
    | (_, _, _, Option::None) => Option::None
  }
}

///|
pub fn[A, B, C, D, E, Combined] maybe_map5(
  combine : (A, B, C, D, E) -> Combined,
  a_maybe : A?,
  b_maybe : B?,
  c_maybe : C?,
  d_maybe : D?,
  e_maybe : E?,
) -> Combined? {
  match (a_maybe, b_maybe, c_maybe, d_maybe, e_maybe) {
    (
      Option::Some(a),
      Option::Some(b),
      Option::Some(c),
      Option::Some(d),
      Option::Some(e),
    ) => Option::Some(combine(a, b, c, d, e))
    (Option::None, _, _, _, _)
    | (_, Option::None, _, _, _)
    | (_, _, Option::None, _, _)
    | (_, _, _, Option::None, _)
    | (_, _, _, _, Option::None) => Option::None
  }
}

///|
pub typealias Result[Err, Ok] as ResultResult[Ok, Err]

///|
pub fn[A, X] result_with_default(
  value_on_err : A,
  result : ResultResult[X, A],
) -> A {
  Result::unwrap_or(result, value_on_err)
}

///|
pub fnalias Result::to_option as result_to_maybe

///|
pub fn[A, X] result_from_maybe(
  error_on_nothing : X,
  maybe : A?,
) -> ResultResult[X, A] {
  match maybe {
    Option::None => Result::Err(error_on_nothing)
    Option::Some(value) => Result::Ok(value)
  }
}

///|
pub fn[A, B, X] result_and_then(
  on_ok : (A) -> ResultResult[X, B],
  result : ResultResult[X, A],
) -> ResultResult[X, B] {
  Result::bind(result, on_ok)
}

///|
pub fn[A, X, Y] result_map_error(
  error_change : (X) -> Y,
  result : ResultResult[X, A],
) -> ResultResult[Y, A] {
  Result::map_err(result, error_change)
}

///|
pub fn[A, B, X] result_map(
  success_change : (A) -> B,
  result : ResultResult[X, A],
) -> ResultResult[X, B] {
  Result::map(result, success_change)
}

///|
pub fn[A, B, Combined, X] result_map2(
  combine : (A, B) -> Combined,
  a_result : ResultResult[X, A],
  b_result : ResultResult[X, B],
) -> ResultResult[X, Combined] {
  match (a_result, b_result) {
    (Result::Ok(a), Result::Ok(b)) => Result::Ok(combine(a, b))
    (Result::Err(x), _) | (_, Result::Err(x)) => Result::Err(x)
  }
}

///|
pub fn[A, B, C, Combined, X] result_map3(
  combine : (A, B, C) -> Combined,
  a_result : ResultResult[X, A],
  b_result : ResultResult[X, B],
  c_result : ResultResult[X, C],
) -> ResultResult[X, Combined] {
  match (a_result, b_result, c_result) {
    (Result::Ok(a), Result::Ok(b), Result::Ok(c)) =>
      Result::Ok(combine(a, b, c))
    (Result::Err(x), _, _) | (_, Result::Err(x), _) | (_, _, Result::Err(x)) =>
      Result::Err(x)
  }
}

///|
pub fn[A, B, C, D, Combined, X] result_map4(
  combine : (A, B, C, D) -> Combined,
  a_result : ResultResult[X, A],
  b_result : ResultResult[X, B],
  c_result : ResultResult[X, C],
  d_result : ResultResult[X, D],
) -> ResultResult[X, Combined] {
  match (a_result, b_result, c_result, d_result) {
    (Result::Ok(a), Result::Ok(b), Result::Ok(c), Result::Ok(d)) =>
      Result::Ok(combine(a, b, c, d))
    (Result::Err(x), _, _, _)
    | (_, Result::Err(x), _, _)
    | (_, _, Result::Err(x), _)
    | (_, _, _, Result::Err(x)) => Result::Err(x)
  }
}

///|
pub fn[A, B, C, D, E, Combined, X] result_map5(
  combine : (A, B, C, D, E) -> Combined,
  a_result : ResultResult[X, A],
  b_result : ResultResult[X, B],
  c_result : ResultResult[X, C],
  d_result : ResultResult[X, D],
  e_result : ResultResult[X, E],
) -> ResultResult[X, Combined] {
  match (a_result, b_result, c_result, d_result, e_result) {
    (Result::Ok(a), Result::Ok(b), Result::Ok(c), Result::Ok(d), Result::Ok(e)) =>
      Result::Ok(combine(a, b, c, d, e))
    (Result::Err(x), _, _, _, _)
    | (_, Result::Err(x), _, _, _)
    | (_, _, Result::Err(x), _, _)
    | (_, _, _, Result::Err(x), _)
    | (_, _, _, _, Result::Err(x)) => Result::Err(x)
  }
}

///|
pub fn[A] list_singleton(only_element : A) -> @list.List[A] {
  @list.of([only_element])
}

///|
pub fn[A] list_cons(newHead : A, tail : @list.List[A]) -> @list.List[A] {
  @list.List::prepend(tail, newHead)
}

///|
pub fnalias @list.List::is_empty as list_is_empty

///|
pub fn[A] list_length(list : @list.List[A]) -> Int64 {
  Int::to_int64(@list.List::length(list))
}

///|
pub fn[A : Eq] list_member(needle : A, list : @list.List[A]) -> Bool {
  @list.List::contains(list, needle)
}

///|
pub fnalias @list.List::minimum as list_minimum

///|
pub fnalias @list.List::maximum as list_maximum

///|
pub fn list_sum_int(list : @list.List[Int64]) -> Int64 {
  @list.List::fold(list, init=0L, Int64::add)
}

///|
pub fn list_sum_float(list : @list.List[Double]) -> Double {
  @list.List::fold(list, init=0.0, Double::add)
}

///|
pub fn list_product_int(list : @list.List[Int64]) -> Int64 {
  @list.List::fold(list, init=1L, Int64::mul)
}

///|
pub fn list_product_float(list : @list.List[Double]) -> Double {
  @list.List::fold(list, init=1.0, Double::mul)
}

///|
pub fnalias @list.List::head as list_head

///|
pub fn[A] list_tail(list : @list.List[A]) -> @list.List[A]? {
  match list {
    @list.List::Empty => Option::None
    @list.List::More(_, tail~) => Option::Some(tail)
  }
}

///|
pub fn[A] list_repeat(count : Int64, element : A) -> @list.List[A] {
  @list.repeat(Int64::to_int(count), element)
}

///|
pub fn list_range(
  smallest_inclusive : Int64,
  greatest_inclusive : Int64,
) -> @list.List[Int64] {
  let mut result : @list.List[Int64] = @list.empty()
  for n = greatest_inclusive; n >= smallest_inclusive; n = n - 1L {
    result = result.prepend(n)
  }
  result
}

///|
pub fnalias @list.List::concat as list_append

///|
pub fnalias @list.List::flatten as list_concat

///|
pub fnalias @list.List::rev as list_reverse

///|
pub fnalias @list.List::sort as list_sort

///|
pub fn[A, Key : Compare] list_sort_by(
  element_to_key : (A) -> Key,
  list : @list.List[A],
) -> @list.List[A] {
  let as_array : Array[A] = @list.List::to_array(list)
  Array::sort_by_key(as_array, element_to_key)
  @list.from_array(as_array)
}

///|
pub fn[A] list_sort_with(
  element_compare : (A, A) -> BasicsOrder,
  list : @list.List[A],
) -> @list.List[A] {
  let as_array : Array[A] = @list.List::to_array(list)
  Array::sort_by(as_array, fn(a, b) {
    basics_order_to_int(element_compare(a, b))
  })
  @list.from_array(as_array)
}

///|
pub fn[A] list_all(is_hay : (A) -> Bool, list : @list.List[A]) -> Bool {
  @list.List::all(list, is_hay)
}

///|
pub fn[A] list_any(is_needle : (A) -> Bool, list : @list.List[A]) -> Bool {
  @list.List::any(list, is_needle)
}

///|
pub fn[A, State] list_foldl(
  reduce : (A, State) -> State,
  initial_state : State,
  list : @list.List[A],
) -> State {
  @list.List::fold(list, init=initial_state, fn(state, element) {
    reduce(element, state)
  })
}

///|
pub fn[A, State] list_foldr(
  reduce : (A, State) -> State,
  initial_state : State,
  list : @list.List[A],
) -> State {
  Array::rev_fold(@list.List::to_array(list), init=initial_state, fn(
    state,
    element,
  ) {
    reduce(element, state)
  })
}

///|
pub fn[A] list_take(keep_count : Int64, list : @list.List[A]) -> @list.List[A] {
  @list.List::take(list, Int64::to_int(keep_count))
}

///|
pub fn[A] list_drop(
  start_remove_count : Int64,
  list : @list.List[A],
) -> @list.List[A] {
  @list.List::drop(list, Int64::to_int(start_remove_count))
}

///|
pub fn[A] list_intersperse(
  in_between_element : A,
  list : @list.List[A],
) -> @list.List[A] {
  @list.List::intersperse(list, in_between_element)
}

///|
pub fn[A] list_filter(
  keep_element : (A) -> Bool,
  list : @list.List[A],
) -> @list.List[A] {
  @list.List::filter(list, keep_element)
}

///|
pub fn[A, B] list_map(
  element_change : (A) -> B,
  list : @list.List[A],
) -> @list.List[B] {
  @list.List::map(list, element_change)
}

///|
pub fn[A, B] list_indexed_map(
  element_change : (Int64, A) -> B,
  list : @list.List[A],
) -> @list.List[B] {
  @list.List::mapi(list, fn(index, element) {
    element_change(Int::to_int64(index), element)
  })
}

///|
pub fn[A, B] list_filter_map(
  element_to_maybe_new : (A) -> B?,
  list : @list.List[A],
) -> @list.List[B] {
  @list.List::filter_map(list, element_to_maybe_new)
}

///|
pub fn[A, B] list_concat_map(
  element_to_maybe_new : (A) -> @list.List[B],
  list : @list.List[A],
) -> @list.List[B] {
  @list.List::flat_map(list, element_to_maybe_new)
}

///|
pub fnalias @list.List::unzip as list_unzip

///|
pub fnalias @list.zip as list_zip

///|
pub fn[A, B, Combined] list_map2(
  elements_combine : (A, B) -> Combined,
  a_list : @list.List[A],
  b_list : @list.List[B],
) -> @list.List[Combined] {
  let mut remaining_a_list : @list.List[A] = a_list
  let mut remaining_b_list : @list.List[B] = b_list
  let combined_array : Array[Combined] = Array::new()
  for {
    match (remaining_a_list, remaining_b_list) {
      (
        @list.List::More(a_head, tail=a_tail),
        @list.List::More(b_head, tail=b_tail),
      ) => {
        remaining_a_list = a_tail
        remaining_b_list = b_tail
        combined_array.push(elements_combine(a_head, b_head))
      }
      (@list.List::Empty, _) | (_, @list.List::Empty) => break
    }
  }
  @list.from_array(combined_array)
}

///|
pub fn[A, B, C, Combined] list_map3(
  elements_combine : (A, B, C) -> Combined,
  a_list : @list.List[A],
  b_list : @list.List[B],
  c_list : @list.List[C],
) -> @list.List[Combined] {
  let mut remaining_a_list : @list.List[A] = a_list
  let mut remaining_b_list : @list.List[B] = b_list
  let mut remaining_c_list : @list.List[C] = c_list
  let combined_array : Array[Combined] = Array::new()
  for {
    match (remaining_a_list, remaining_b_list, remaining_c_list) {
      (
        @list.List::More(a_head, tail=a_tail),
        @list.List::More(b_head, tail=b_tail),
        @list.List::More(c_head, tail=c_tail),
      ) => {
        remaining_a_list = a_tail
        remaining_b_list = b_tail
        remaining_c_list = c_tail
        combined_array.push(elements_combine(a_head, b_head, c_head))
      }
      (@list.List::Empty, _, _)
      | (_, @list.List::Empty, _)
      | (_, _, @list.List::Empty) => break
    }
  }
  @list.from_array(combined_array)
}

///|
pub fn[A, B, C, D, Combined] list_map4(
  elements_combine : (A, B, C, D) -> Combined,
  a_list : @list.List[A],
  b_list : @list.List[B],
  c_list : @list.List[C],
  d_list : @list.List[D],
) -> @list.List[Combined] {
  let mut remaining_a_list : @list.List[A] = a_list
  let mut remaining_b_list : @list.List[B] = b_list
  let mut remaining_c_list : @list.List[C] = c_list
  let mut remaining_d_list : @list.List[D] = d_list
  let combined_array : Array[Combined] = Array::new()
  for {
    match
      (remaining_a_list, remaining_b_list, remaining_c_list, remaining_d_list) {
      (
        @list.List::More(a_head, tail=a_tail),
        @list.List::More(b_head, tail=b_tail),
        @list.List::More(c_head, tail=c_tail),
        @list.List::More(d_head, tail=d_tail),
      ) => {
        remaining_a_list = a_tail
        remaining_b_list = b_tail
        remaining_c_list = c_tail
        remaining_d_list = d_tail
        combined_array.push(elements_combine(a_head, b_head, c_head, d_head))
      }
      (@list.List::Empty, _, _, _)
      | (_, @list.List::Empty, _, _)
      | (_, _, @list.List::Empty, _)
      | (_, _, _, @list.List::Empty) => break
    }
  }
  @list.from_array(combined_array)
}

///|
pub fn[A, B, C, D, E, Combined] list_map5(
  elements_combine : (A, B, C, D, E) -> Combined,
  a_list : @list.List[A],
  b_list : @list.List[B],
  c_list : @list.List[C],
  d_list : @list.List[D],
  e_list : @list.List[E],
) -> @list.List[Combined] {
  let mut remaining_a_list : @list.List[A] = a_list
  let mut remaining_b_list : @list.List[B] = b_list
  let mut remaining_c_list : @list.List[C] = c_list
  let mut remaining_d_list : @list.List[D] = d_list
  let mut remaining_e_list : @list.List[E] = e_list
  let combined_array : Array[Combined] = Array::new()
  for {
    match
      (
        remaining_a_list, remaining_b_list, remaining_c_list, remaining_d_list, remaining_e_list,
      ) {
      (
        @list.List::More(a_head, tail=a_tail),
        @list.List::More(b_head, tail=b_tail),
        @list.List::More(c_head, tail=c_tail),
        @list.List::More(d_head, tail=d_tail),
        @list.List::More(e_head, tail=e_tail),
      ) => {
        remaining_a_list = a_tail
        remaining_b_list = b_tail
        remaining_c_list = c_tail
        remaining_d_list = d_tail
        remaining_e_list = e_tail
        combined_array.push(
          elements_combine(a_head, b_head, c_head, d_head, e_head),
        )
      }
      (@list.List::Empty, _, _, _, _)
      | (_, @list.List::Empty, _, _, _)
      | (_, _, @list.List::Empty, _, _)
      | (_, _, _, @list.List::Empty, _)
      | (_, _, _, _, @list.List::Empty) => break
    }
  }
  @list.from_array(combined_array)
}

///|
/// A string-rope. use `string_string_to_string` to turn it into a `String`.
/// Only use `StringString::to_string(_)` for debugging
pub(all) enum StringString {
  One(String)
  Append(StringString, StringString)
}

///|
impl Show for StringString with output(self, logger) {
  String::output(string_string_to_string(self), logger)
}

///|
impl Eq for StringString with equal(self, other) {
  String::equal(string_string_to_string(self), string_string_to_string(other))
}

///|
pub fn string_string_equals_string(string : StringString, str : String) -> Bool {
  string_string_to_string(string) == str
}

///|
impl Compare for StringString with compare(self, other) -> Int {
  String::compare(string_string_to_string(self), string_string_to_string(other))
}

///|
pub fn string_string_to_string(string : StringString) -> String {
  match string {
    StringString::One(str) => str
    StringString::Append(full_left, full_right) => {
      let builder : StringBuilder = StringBuilder::new()
      let mut current_leftest : StringString = full_left
      let current_right_stack : Array[StringString] = Array::new()
      current_right_stack.push(full_right)
      for {
        match current_leftest {
          StringString::One(leftest_string) => {
            builder.write_string(leftest_string)
            match current_right_stack.pop() {
              Option::None => break
              Option::Some(next_right) => current_leftest = next_right
            }
          }
          StringString::Append(leftest_left, leftest_right) => {
            current_leftest = leftest_left
            current_right_stack.push(leftest_right)
          }
        }
      }
      StringBuilder::to_string(builder)
    }
  }
}

///|
pub fn string_is_empty(string : StringString) -> Bool {
  match string {
    StringString::One(str) => String::is_empty(str)
    StringString::Append(left, right) =>
      string_is_empty(left) && string_is_empty(right)
  }
}

///|
pub fn string_length(string : StringString) -> Int64 {
  Int::to_int64(string_length_int(string))
}

///|
pub fn string_length_int(string : StringString) -> Int {
  match string {
    StringString::One(str) => String::length(str)
    StringString::Append(left, right) =>
      string_length_int(left) + string_length_int(right)
  }
}

///|
pub fn string_contains(needle : StringString, string : StringString) -> Bool {
  String::contains(
    string_string_to_string(string),
    string_string_to_string(needle),
  )
}

///|
pub fn string_starts_with(needle : StringString, string : StringString) -> Bool {
  String::has_prefix(
    string_string_to_string(string),
    string_string_to_string(needle),
  )
}

///|
pub fn string_ends_with(needle : StringString, string : StringString) -> Bool {
  String::has_suffix(
    string_string_to_string(string),
    string_string_to_string(needle),
  )
}

///|
pub fn string_all(is_hay : (Char) -> Bool, string : StringString) -> Bool {
  Iter::all(String::iter(string_string_to_string(string)), is_hay)
}

///|
pub fn string_any(is_needle : (Char) -> Bool, string : StringString) -> Bool {
  Iter::any(String::iter(string_string_to_string(string)), is_needle)
}

///|
pub let string_empty : StringString = StringString::One("")

///|
pub fn string_from_char(char : Char) -> StringString {
  StringString::One(Char::to_string(char))
}

///|
pub fn string_from_int(int : Int64) -> StringString {
  StringString::One(Int64::to_string(int))
}

///|
pub fn string_from_float(float : Double) -> StringString {
  StringString::One(Double::to_string(float))
}

///|
pub fn string_repeat(count : Int64, to_repeat : StringString) -> StringString {
  StringString::One(
    String::repeat(string_string_to_string(to_repeat), Int64::to_int(count)),
  )
}

///|
pub fn string_from_list(chars : @list.List[Char]) -> StringString {
  StringString::One(String::from_array(@list.List::to_array(chars)))
}

///|
pub fn string_to_lower(string : StringString) -> StringString {
  StringString::One(String::to_lower(string_string_to_string(string)))
}

///|
pub fn string_to_upper(string : StringString) -> StringString {
  StringString::One(String::to_upper(string_string_to_string(string)))
}

///|
pub fn string_reverse(string : StringString) -> StringString {
  StringString::One(String::rev(string_string_to_string(string)))
}

///|
/// \s in https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_expressions/Cheatsheet
let whitespacePossibilities : String = String::from_array([
  '\n', '\r', '\f', '\t', '\u000B', ' ', '\u00a0', '\u1680', '\u2000', '\u2001',
  '\u2002', '\u2003', '\u2004', '\u2005', '\u2006', '\u2007', '\u2008', '\u2009',
  '\u200a', '\u2028', '\u2029', '\u202f', '\u205f', '\u3000', '\ufeff',
])

///|
pub fn string_trim(string : StringString) -> StringString {
  StringString::One(
    StringView::to_string(
      String::trim(string_string_to_string(string), whitespacePossibilities),
    ),
  )
}

///|
pub fn string_trim_left(string : StringString) -> StringString {
  StringString::One(
    StringView::to_string(
      String::trim_start(
        string_string_to_string(string),
        whitespacePossibilities,
      ),
    ),
  )
}

///|
pub fn string_trim_right(string : StringString) -> StringString {
  StringString::One(
    StringView::to_string(
      String::trim_end(string_string_to_string(string), whitespacePossibilities),
    ),
  )
}

///|
pub fn string_pad_left(
  new_minimum_length : Int64,
  padding : Char,
  string : StringString,
) -> StringString {
  StringString::One(
    StringView::to_string(
      String::pad_start(
        string_string_to_string(string),
        Int64::to_int(new_minimum_length),
        padding,
      ),
    ),
  )
}

///|
pub fn string_pad_right(
  new_minimum_length : Int64,
  padding : Char,
  string : StringString,
) -> StringString {
  StringString::One(
    StringView::to_string(
      String::pad_end(
        string_string_to_string(string),
        Int64::to_int(new_minimum_length),
        padding,
      ),
    ),
  )
}

///|
pub fn string_pad(
  new_minimum_length : Int64,
  padding : Char,
  string : StringString,
) -> StringString {
  let as_string : String = string_string_to_string(string)
  StringString::One(
    StringView::to_string(
      String::pad_start(
        String::pad_end(
          as_string,
          (String::length(as_string) + Int64::to_int(new_minimum_length)) / 2,
          padding,
        ),
        Int64::to_int(new_minimum_length),
        padding,
      ),
    ),
  )
}

///|
pub fn string_replace(
  to_replace : StringString,
  replacement : StringString,
  string : StringString,
) -> StringString {
  StringString::One(
    StringView::to_string(
      String::replace_all(
        string_string_to_string(string),
        old=string_string_to_string(to_replace),
        new=string_string_to_string(replacement),
      ),
    ),
  )
}

///|
pub fn string_map(
  char_change : (Char) -> Char,
  string : StringString,
) -> StringString {
  StringString::One(
    String::from_iter(
      Iter::map(String::iter(string_string_to_string(string)), char_change),
    ),
  )
}

///|
pub fn string_filter(
  keep_char : (Char) -> Bool,
  string : StringString,
) -> StringString {
  StringString::One(
    String::from_iter(
      Iter::filter(String::iter(string_string_to_string(string)), keep_char),
    ),
  )
}

///|
pub fn string_append(left : StringString, right : StringString) -> StringString {
  StringString::Append(left, right)
}

///|
pub fn string_cons(left : Char, right : StringString) -> StringString {
  StringString::Append(StringString::One(Char::to_string(left)), right)
}

///|
pub fn string_concat(strings : @list.List[StringString]) -> StringString {
  @list.List::fold(strings, init=string_empty, string_append)
}

///|
pub fn string_join(
  in_between : StringString,
  strings : @list.List[StringString],
) -> StringString {
  let in_between_as_string : StringString = StringString::One(
    string_string_to_string(in_between),
  )
  match strings {
    @list.List::Empty => string_empty
    @list.List::More(head_string, tail=tail_strings) =>
      @list.List::fold(tail_strings, init=head_string, fn(so_far, element) {
        string_append(so_far, string_append(in_between_as_string, element))
      })
  }
}

///|
pub fn string_uncons(string : StringString) -> (Char, StringString)? {
  let as_string : String = string_string_to_string(string)
  match Iter::head(String::iter(as_string)) {
    Option::None => Option::None
    Option::Some(headChar) =>
      Option::Some(
        (
          headChar,
          StringString::One(
            StringView::to_string(
              String::sub(as_string, start=Char::utf16_len(headChar)),
            ),
          ),
        ),
      ) catch {
        // should always work
        _ => Option::None
      }
  }
}

///|
pub fn string_left(
  count_to_keep : Int64,
  string : StringString,
) -> StringString {
  let as_string : String = string_string_to_string(string)
  if count_to_keep <= 0 {
    string_empty
  } else if Int64::to_int(count_to_keep) >= String::length(as_string) {
    string
  } else {
    StringString::One(
      StringView::to_string(
        String::sub(as_string, end=Int64::to_int(count_to_keep)),
      ),
    ) catch {
      IndexOutOfBounds =>
        // should not fail
        string_empty
      InvalidIndex =>
        // end position would split a UTF-16 surrogate pair
        // so we try the next UTF-16 offset
        StringString::One(
          StringView::to_string(
            String::sub(as_string, end=Int64::to_int(count_to_keep) + 1),
          ),
        ) catch {
          // should not fail
          _ => string_empty
        }
    }
  }
}

///|
pub fn string_right(
  count_to_keep : Int64,
  string : StringString,
) -> StringString {
  let as_string : String = string_string_to_string(string)
  let string_length : Int = String::length(as_string)
  if count_to_keep <= 0 {
    string_empty
  } else if Int64::to_int(count_to_keep) >= string_length {
    string
  } else {
    StringString::One(
      StringView::to_string(
        String::sub(
          as_string,
          start=string_length - Int64::to_int(count_to_keep),
        ),
      ),
    ) catch {
      IndexOutOfBounds => string_empty // should not fail
      InvalidIndex =>
        // end position would split a UTF-16 surrogate pair
        // so we try the next UTF-16 offset
        StringString::One(
          StringView::to_string(
            String::sub(
              as_string,
              start=string_length - Int64::to_int(count_to_keep) + 1,
            ),
          ),
        ) catch {
          _ => string_empty // should not fail
        }
    }
  }
}

///|
pub fn string_drop_left(
  count_to_drop : Int64,
  string : StringString,
) -> StringString {
  let as_string : String = string_string_to_string(string)
  if count_to_drop <= 0 {
    string
  } else if Int64::to_int(count_to_drop) >= String::length(as_string) {
    string_empty
  } else {
    StringString::One(
      StringView::to_string(
        String::sub(as_string, start=Int64::to_int(count_to_drop)),
      ),
    ) catch {
      IndexOutOfBounds => string_empty // should not fail
      InvalidIndex =>
        // end position would split a UTF-16 surrogate pair
        // so we try the next UTF-16 offset
        StringString::One(
          StringView::to_string(
            String::sub(as_string, start=Int64::to_int(count_to_drop) + 1),
          ),
        ) catch {
          _ => string_empty // should not fail
        }
    }
  }
}

///|
pub fn string_drop_right(
  count_to_drop : Int64,
  string : StringString,
) -> StringString {
  let as_string : String = string_string_to_string(string)
  let string_length : Int = String::length(as_string)
  if count_to_drop <= 0 {
    string
  } else if Int64::to_int(count_to_drop) >= string_length {
    string_empty
  } else {
    StringString::One(
      StringView::to_string(
        String::sub(as_string, end=string_length - Int64::to_int(count_to_drop)),
      ),
    ) catch {
      IndexOutOfBounds => string_empty // should not fail
      InvalidIndex =>
        // end position would split a UTF-16 surrogate pair
        // so we try the next UTF-16 offset
        StringString::One(
          StringView::to_string(
            String::sub(
              as_string,
              end=string_length - Int64::to_int(count_to_drop) + 1,
            ),
          ),
        ) catch {
          _ => string_empty // should not fail
        }
    }
  }
}

///|
pub fn string_slice(
  start_inclusive : Int64,
  end_exclusive : Int64,
  string : StringString,
) -> StringString {
  let as_string : String = string_string_to_string(string)
  let string_length : Int = String::length(as_string)
  if Int64::to_int(start_inclusive) >= string_length ||
    Int64::to_int(end_exclusive) <= -string_length {
    string_empty
  } else {
    let valid_start_inclusive : Int = Int::max(
      Int64::to_int(start_inclusive),
      -string_length,
    )
    let valid_end_exclusive : Int = Int::min(
      Int64::to_int(end_exclusive),
      string_length,
    )
    StringString::One(
      StringView::to_string(
        String::sub(
          as_string,
          start=valid_start_inclusive,
          end=valid_end_exclusive,
        ),
      ),
    ) catch {
      IndexOutOfBounds => string_empty // should not fail
      InvalidIndex =>
        // times are rough!
        // because we don't know if the start or end char boundaries
        // were violated (or both) so we have no choice but to try them all
        StringString::One(
          StringView::to_string(
            String::sub(
              as_string,
              start=valid_start_inclusive,
              end=valid_end_exclusive + 1,
            ),
          ),
        ) catch {
          IndexOutOfBounds => string_empty // should not fail
          InvalidIndex =>
            StringString::One(
              StringView::to_string(
                String::sub(
                  as_string,
                  start=valid_start_inclusive - 1,
                  end=valid_end_exclusive,
                ),
              ),
            ) catch {
              IndexOutOfBounds => string_empty // should not fail
              InvalidIndex =>
                StringString::One(
                  StringView::to_string(
                    String::sub(
                      as_string,
                      start=valid_start_inclusive - 1,
                      end=valid_end_exclusive + 1,
                    ),
                  ),
                ) catch {
                  // should not fail
                  _ => string_empty
                }
            }
        }
    }
  }
}

///|
pub fn string_to_int(string : StringString) -> Int64? {
  Option::Some(@strconv.parse_int64(string_string_to_string(string))) catch {
    _ => Option::None
  }
}

///|
pub fn string_to_float(string : StringString) -> Double? {
  Option::Some(@strconv.parse_double(string_string_to_string(string))) catch {
    _ => Option::None
  }
}

///|
pub fn string_to_list(string : StringString) -> @list.List[Char] {
  @list.List::from_array(String::to_array(string_string_to_string(string)))
}

///|
pub fn string_split(
  separator : StringString,
  string : StringString,
) -> @list.List[StringString] {
  @list.List::from_iter(
    Iter::map(
      String::split(
        string_string_to_string(string),
        string_string_to_string(separator),
      ),
      fn(string_view) { StringString::One(StringView::to_string(string_view)) },
    ),
  )
}

///|
pub fn string_lines(string : StringString) -> @list.List[StringString] {
  @list.List::from_iter(
    Iter::map(
      String::split(
        String::replace_all(
          string_string_to_string(string),
          old="\r\n",
          new="\n",
        ),
        "\n",
      ),
      fn(string_view) { StringString::One(StringView::to_string(string_view)) },
    ),
  )
}

///|
pub fn string_words(string : StringString) -> @list.List[StringString] {
  string_string_to_string(string)
  |> String::iter
  |> Iter::map(fn(char) {
    if String::contains_char(whitespacePossibilities, char) {
      ' '
    } else {
      char
    }
  })
  |> String::from_iter
  |> String::split(" ")
  |> Iter::filter_map(fn(string_view) {
    if StringView::is_empty(string_view) {
      Option::None
    } else {
      Option::Some(StringString::One(StringView::to_string(string_view)))
    }
  })
  |> @list.List::from_iter
}

///|
pub fn[State] string_foldl(
  reduce : (Char, State) -> State,
  initial_state : State,
  string : StringString,
) -> State {
  String::fold(string_string_to_string(string), init=initial_state, fn(
    so_far,
    char,
  ) {
    reduce(char, so_far)
  })
}

///|
pub fn[State] string_foldr(
  reduce : (Char, State) -> State,
  initial_state : State,
  string : StringString,
) -> State {
  String::rev_fold(string_string_to_string(string), init=initial_state, fn(
    so_far,
    char,
  ) {
    reduce(char, so_far)
  })
}

///|
pub fnalias @immut/array.T::is_empty as array_is_empty

///|
pub fn[A] array_length(array : @immut/array.T[A]) -> Int64 {
  Int::to_int64(@immut/array.T::length(array))
}

///|
pub fn[A] array_get(index : Int64, array : @immut/array.T[A]) -> A? {
  @immut/array.T::get(array, Int64::to_int(index))
}

///|
pub fn[A] array_singleton(only_element : A) -> @immut/array.T[A] {
  @immut/array.of([only_element])
}

///|
pub fn[A] array_repeat(length : Int64, element : A) -> @immut/array.T[A] {
  @immut/array.make(Int64::to_int(length), element)
}

///|
pub fn[A] array_from_list(list : @list.List[A]) -> @immut/array.T[A] {
  @immut/array.from_iter(@list.List::iter(list))
}

///|
pub fn[A] array_initialize(
  length : Int64,
  index_to_element : (Int64) -> A,
) -> @immut/array.T[A] {
  @immut/array.makei(Int64::to_int(length), fn(index) {
    index_to_element(Int::to_int64(index))
  })
}

///|
pub fn[A] array_push(
  new_last_element : A,
  array : @immut/array.T[A],
) -> @immut/array.T[A] {
  @immut/array.T::push(array, new_last_element)
}

///|
pub fn[A] array_set(
  index : Int64,
  new_element : A,
  array : @immut/array.T[A],
) -> @immut/array.T[A] {
  @immut/array.T::set(array, Int64::to_int(index), new_element)
}

///|
pub fn[A] array_slice(
  start_inclusive_possibly_negative : Int64,
  end_exclusive_possibly_negative : Int64,
  array : @immut/array.T[A],
) -> @immut/array.T[A] {
  // can maybe be optimized
  let start_inclusive = if start_inclusive_possibly_negative <= -1 {
    Int::max(
      0,
      Int64::to_int(start_inclusive_possibly_negative) +
      @immut/array.T::length(array),
    )
    // start_inclusive_possibly_negative >= 0
  } else {
    Int::min(
      @immut/array.T::length(array),
      Int64::to_int(start_inclusive_possibly_negative),
    )
  }
  let end_exclusive = if end_exclusive_possibly_negative <= -1 {
    Int::max(
      0,
      Int64::to_int(end_exclusive_possibly_negative) +
      @immut/array.T::length(array),
    )
    // end_exclusive_possibly_negative >= 0
  } else {
    Int::min(
      @immut/array.T::length(array),
      Int64::to_int(end_exclusive_possibly_negative),
    )
  }
  if start_inclusive >= end_exclusive {
    @immut/array.new()
  } else {
    Array::sub(
      @immut/array.T::to_array(array),
      start=start_inclusive,
      end=end_exclusive,
    )
    |> ArrayView::iter
    |> @immut/array.T::from_iter
  }
}

///|
pub fn[A] array_reverse(array : @immut/array.T[A]) -> @immut/array.T[A] {
  // can maybe be optimized
  @immut/array.T::rev_fold(array, init=@immut/array.new(), fn(so_far, element) {
    @immut/array.T::push(so_far, element)
  })
}

///|
pub fn[A] array_filter(
  keep_element : (A) -> Bool,
  array : @immut/array.T[A],
) -> @immut/array.T[A] {
  // can maybe be optimized
  array
  |> @immut/array.T::iter
  |> Iter::filter(keep_element)
  |> @immut/array.T::from_iter
}

///|
pub fn[A, B] array_map(
  element_change : (A) -> B,
  array : @immut/array.T[A],
) -> @immut/array.T[B] {
  @immut/array.T::map(array, element_change)
}

///|
pub fn[A, B] array_indexed_map(
  element_change : (Int64, A) -> B,
  array : @immut/array.T[A],
) -> @immut/array.T[B] {
  // can maybe be optimized
  array
  |> @immut/array.T::iter
  |> Iter::mapi(fn(index, element) {
    element_change(Int::to_int64(index), element)
  })
  |> @immut/array.T::from_iter
}

///|
pub fn[A, State] array_foldl(
  reduce : (A, State) -> State,
  initial_state : State,
  array : @immut/array.T[A],
) -> State {
  @immut/array.T::fold(array, init=initial_state, fn(so_far, element) {
    reduce(element, so_far)
  })
}

///|
pub fn[A, State] array_foldr(
  reduce : (A, State) -> State,
  initial_state : State,
  array : @immut/array.T[A],
) -> State {
  @immut/array.T::rev_fold(array, init=initial_state, fn(so_far, element) {
    reduce(element, so_far)
  })
}

///|
pub fnalias @immut/array.T::concat as array_append

///|
pub fn[A] array_to_list(array : @immut/array.T[A]) -> @list.List[A] {
  @list.from_iter(@immut/array.T::iter(array))
}

///|
pub fn[A] array_to_indexed_list(
  array : @immut/array.T[A],
) -> @list.List[(Int64, A)] {
  array
  |> @immut/array.T::iter
  |> Iter::mapi(fn(index, element) { (Int::to_int64(index), element) })
  |> @list.from_iter
}

///|
pub fnalias @immut/sorted_set.SortedSet::is_empty as set_is_empty

///|
pub fn[A] set_size(set : @immut/sorted_set.SortedSet[A]) -> Int64 {
  Int::to_int64(@immut/sorted_set.SortedSet::size(set))
}

///|
pub fn[A : Compare] set_member(
  element_to_remove : A,
  set : @immut/sorted_set.SortedSet[A],
) -> Bool {
  @immut/sorted_set.SortedSet::contains(set, element_to_remove)
}

///|
pub fn[A : Compare] set_from_list(
  list : @list.List[A],
) -> @immut/sorted_set.SortedSet[A] {
  @immut/sorted_set.SortedSet::from_iter(@list.List::iter(list))
}

///|
pub fn[A] set_to_list(set : @immut/sorted_set.SortedSet[A]) -> @list.List[A] {
  @list.from_iter(@immut/sorted_set.SortedSet::iter(set))
}

///|
pub fn[A : Compare] set_insert(
  new_element : A,
  set : @immut/sorted_set.SortedSet[A],
) -> @immut/sorted_set.SortedSet[A] {
  @immut/sorted_set.SortedSet::add(set, new_element)
}

///|
pub fn[A : Compare] set_remove(
  element_to_remove : A,
  set : @immut/sorted_set.SortedSet[A],
) -> @immut/sorted_set.SortedSet[A] {
  @immut/sorted_set.SortedSet::remove(set, element_to_remove)
}

///|
pub fn[A : Compare] set_filter(
  keep_element : (A) -> Bool,
  set : @immut/sorted_set.SortedSet[A],
) -> @immut/sorted_set.SortedSet[A] {
  @immut/sorted_set.SortedSet::filter(set, keep_element)
}

///|
pub fn[A, B : Compare] set_map(
  keep_element : (A) -> B,
  set : @immut/sorted_set.SortedSet[A],
) -> @immut/sorted_set.SortedSet[B] {
  set
  |> @immut/sorted_set.SortedSet::iter
  |> Iter::map(keep_element)
  |> @immut/sorted_set.SortedSet::from_iter
}

///|
pub fn[A : Compare, State] set_foldl(
  reduce : (A, State) -> State,
  initial_state : State,
  set : @immut/sorted_set.SortedSet[A],
) -> State {
  // TODO remove :Compare once https://github.com/moonbitlang/core/pull/2759 is merged
  @immut/sorted_set.SortedSet::fold(set, init=initial_state, fn(
    so_far,
    element,
  ) {
    reduce(element, so_far)
  })
}

///|
pub fn[A, State] set_foldr(
  reduce : (A, State) -> State,
  initial_state : State,
  set : @immut/sorted_set.SortedSet[A],
) -> State {
  set
  |> @immut/sorted_set.SortedSet::to_array
  |> Array::rev_fold(init=initial_state, fn(so_far, element) {
    reduce(element, so_far)
  })
}

///|
pub fn[A : Compare] set_partition(
  element_is_first : (A) -> Bool,
  set : @immut/sorted_set.SortedSet[A],
) -> (@immut/sorted_set.SortedSet[A], @immut/sorted_set.SortedSet[A]) {
  (
    @immut/sorted_set.SortedSet::filter(set, element_is_first),
    @immut/sorted_set.SortedSet::filter(set, fn(element) {
      !element_is_first(element)
    }),
  )
}

///|
pub fnalias @immut/sorted_set.SortedSet::intersection as set_intersect

///|
pub fnalias @immut/sorted_set.SortedSet::union as set_union

///|
pub fnalias @immut/sorted_set.SortedSet::difference as set_diff

///|
pub fnalias @immut/sorted_map.SortedMap::is_empty as dict_is_empty

///|
pub fn[K, V] dict_size(dict : @immut/sorted_map.SortedMap[K, V]) -> Int64 {
  Int::to_int64(@immut/sorted_map.SortedMap::size(dict))
}

///|
pub fn[K : Compare, V] dict_member(
  needle : K,
  dict : @immut/sorted_map.SortedMap[K, V],
) -> Bool {
  @immut/sorted_map.SortedMap::contains(dict, needle)
}

///|
pub fn[K : Compare, V] dict_get(
  needle : K,
  dict : @immut/sorted_map.SortedMap[K, V],
) -> V? {
  @immut/sorted_map.SortedMap::get(dict, needle)
}

///|
pub fn[K : Compare, V] dict_from_list(
  list : @list.List[(K, V)],
) -> @immut/sorted_map.SortedMap[K, V] {
  @immut/sorted_map.SortedMap::from_iter(@list.List::iter(list))
}

///|
pub fn[K : Compare, V] dict_insert(
  key : K,
  new_value : V,
  dict : @immut/sorted_map.SortedMap[K, V],
) -> @immut/sorted_map.SortedMap[K, V] {
  @immut/sorted_map.SortedMap::add(dict, key, new_value)
}

///|
pub fn[K : Compare, V] dict_update(
  key : K,
  change_maybe_value : (V?) -> V?,
  dict : @immut/sorted_map.SortedMap[K, V],
) -> @immut/sorted_map.SortedMap[K, V] {
  match @immut/sorted_map.SortedMap::get(dict, key) {
    Option::None =>
      match change_maybe_value(None) {
        Option::None => dict
        Option::Some(changed_value) =>
          @immut/sorted_map.SortedMap::add(dict, key, changed_value)
      }
    Option::Some(_) =>
      match change_maybe_value(None) {
        Option::None => @immut/sorted_map.SortedMap::remove(dict, key)
        Option::Some(changed_value) =>
          @immut/sorted_map.SortedMap::add(dict, key, changed_value)
      }
  }
}

///|
pub fn[K : Compare, V] dict_remove(
  keep_entry : K,
  dict : @immut/sorted_map.SortedMap[K, V],
) -> @immut/sorted_map.SortedMap[K, V] {
  @immut/sorted_map.SortedMap::remove(dict, keep_entry)
}

///|
pub fn[K : Compare, V] dict_filter(
  keep_entry : (K, V) -> Bool,
  dict : @immut/sorted_map.SortedMap[K, V],
) -> @immut/sorted_map.SortedMap[K, V] {
  @immut/sorted_map.SortedMap::filter_with_key(dict, keep_entry)
}

///|
pub fn[K, VA, VB] dict_map(
  keep_entry : (K, VA) -> VB,
  dict : @immut/sorted_map.SortedMap[K, VA],
) -> @immut/sorted_map.SortedMap[K, VB] {
  @immut/sorted_map.SortedMap::map_with_key(dict, keep_entry)
}

///|
pub fn[K, V] dict_to_list(
  dict : @immut/sorted_map.SortedMap[K, V],
) -> @list.List[(K, V)] {
  @list.from_iter(@immut/sorted_map.SortedMap::iter(dict))
}

///|
pub fn[K, V] dict_keys(
  dict : @immut/sorted_map.SortedMap[K, V],
) -> @list.List[K] {
  @list.from_iter(@immut/sorted_map.SortedMap::keys_as_iter(dict))
}

///|
pub fn[K, V] dict_values(
  dict : @immut/sorted_map.SortedMap[K, V],
) -> @list.List[V] {
  @list.from_iter(@immut/sorted_map.SortedMap::values(dict))
}

///|
pub fn[K, V, State] dict_foldl(
  reduce : (K, V, State) -> State,
  initial_state : State,
  dict : @immut/sorted_map.SortedMap[K, V],
) -> State {
  @immut/sorted_map.SortedMap::foldl_with_key(dict, init=initial_state, fn(
    so_far,
    k,
    v,
  ) {
    reduce(k, v, so_far)
  })
}

///|
pub fn[K, V, State] dict_foldr(
  reduce : (K, V, State) -> State,
  initial_state : State,
  dict : @immut/sorted_map.SortedMap[K, V],
) -> State {
  @immut/sorted_map.SortedMap::foldr_with_key(dict, init=initial_state, fn(
    so_far,
    k,
    v,
  ) {
    reduce(k, v, so_far)
  })
}

///|
pub fn[K : Compare, V] dict_union(
  addition_dict : @immut/sorted_map.SortedMap[K, V],
  base_dict : @immut/sorted_map.SortedMap[K, V],
) -> @immut/sorted_map.SortedMap[K, V] {
  @immut/sorted_map.SortedMap::foldl_with_key(addition_dict, init=base_dict, fn(
    so_far,
    k,
    v,
  ) {
    @immut/sorted_map.SortedMap::add(so_far, k, v)
  })
}

///|
pub fn[K : Compare, V] dict_intersect(
  base_dict : @immut/sorted_map.SortedMap[K, V],
  dict_with_keys_to_keep : @immut/sorted_map.SortedMap[K, V],
) -> @immut/sorted_map.SortedMap[K, V] {
  @immut/sorted_map.SortedMap::filter_with_key(base_dict, fn(k, _v) {
    @immut/sorted_map.SortedMap::contains(dict_with_keys_to_keep, k)
  })
}

///|
pub fn[K : Compare, V] dict_diff(
  base_dict : @immut/sorted_map.SortedMap[K, V],
  dict_with_keys_to_remove : @immut/sorted_map.SortedMap[K, V],
) -> @immut/sorted_map.SortedMap[K, V] {
  @immut/sorted_map.SortedMap::filter_with_key(base_dict, fn(k, _v) {
    !@immut/sorted_map.SortedMap::contains(dict_with_keys_to_remove, k)
  })
}

///|
pub fn[K : Compare, A] dict_partition(
  entry_is_first : (K, A) -> Bool,
  dict : @immut/sorted_map.SortedMap[K, A],
) -> (@immut/sorted_map.SortedMap[K, A], @immut/sorted_map.SortedMap[K, A]) {
  (
    @immut/sorted_map.SortedMap::filter_with_key(dict, entry_is_first),
    @immut/sorted_map.SortedMap::filter_with_key(dict, fn(k, v) {
      !entry_is_first(k, v)
    }),
  )
}

///|
pub fn[K : Compare, VA, VB, State] dict_merge(
  reduce_only_a : (K, VA, State) -> State,
  reduce_both : (K, VA, VB, State) -> State,
  reduce_only_b : (K, VB, State) -> State,
  a_dict : @immut/sorted_map.SortedMap[K, VA],
  b_dict : @immut/sorted_map.SortedMap[K, VB],
  initial_state : State,
) -> State {
  Iter::concat(a_dict.keys_as_iter(), b_dict.keys_as_iter())
  |> Iter::fold(init=initial_state, fn(so_far, key) {
    match
      (
        @immut/sorted_map.SortedMap::get(a_dict, key),
        @immut/sorted_map.SortedMap::get(b_dict, key),
      ) {
      (Option::None, Option::Some(only_b)) => reduce_only_b(key, only_b, so_far)
      (Option::Some(only_a), Option::None) => reduce_only_a(key, only_a, so_far)
      (Option::Some(va), Option::Some(vb)) => reduce_both(key, va, vb, so_far)
      // impossible as the key will always be from either
      (Option::None, Option::None) => so_far
    }
  })
}

///|
pub(all) enum PlatformCmdCmd[Event] {
  PortOutgoing(String, Json)
  Batch(@list.List[PlatformCmdCmd[Event]])
} derive(Eq, Show)

///|
pub fn[Event] platform_cmd_none() -> PlatformCmdCmd[Event] {
  PlatformCmdCmd::Batch(@list.empty())
}

///|
pub fn[Event] platform_cmd_batch(
  cmds : @list.List[PlatformCmdCmd[Event]],
) -> PlatformCmdCmd[Event] {
  PlatformCmdCmd::Batch(cmds)
}

///|
pub fn[A, B] platform_cmd_map(
  event_change : (A) -> B,
  cmd : PlatformCmdCmd[A],
) -> PlatformCmdCmd[B] {
  match cmd {
    PlatformCmdCmd::PortOutgoing(name, json) =>
      PlatformCmdCmd::PortOutgoing(name, json)
    PlatformCmdCmd::Batch(subs) =>
      PlatformCmdCmd::Batch(
        @list.List::map(subs, fn(sub_sub) {
          platform_cmd_map(event_change, sub_sub)
        }),
      )
  }
}

///|
pub enum PlatformSubSub[Event] {
  PortIncoming(String, (Json) -> Event)
  Batch(@list.List[PlatformSubSub[Event]])
}

///|
pub fn[Event] platform_sub_none() -> PlatformSubSub[Event] {
  PlatformSubSub::Batch(@list.empty())
}

///|
pub fn[Event] platform_sub_batch(
  subs : @list.List[PlatformSubSub[Event]],
) -> PlatformSubSub[Event] {
  PlatformSubSub::Batch(subs)
}

///|
pub fn[A, B] platform_sub_map(
  event_change : (A) -> B,
  sub : PlatformSubSub[A],
) -> PlatformSubSub[B] {
  match sub {
    PlatformSubSub::Batch(subs) =>
      PlatformSubSub::Batch(
        @list.List::map(subs, fn(sub_sub) {
          platform_sub_map(event_change, sub_sub)
        }),
      )
    PlatformSubSub::PortIncoming(name, on_data) =>
      PlatformSubSub::PortIncoming(name, fn(data) {
        event_change(on_data(data))
      })
  }
}

///|
pub(all) struct GeneratedInitSubscriptionsUpdate[Init, Subscriptions, Update] {
  init : Init
  update : Update
  subscriptions : Subscriptions
} derive(Eq, Show)

///|
pub typealias GeneratedInitSubscriptionsUpdate[
  (Flags) -> (State, PlatformCmdCmd[Event]),
  (State) -> PlatformSubSub[Event],
  (Event) -> (State) -> (State, PlatformCmdCmd[Event]),
] as PlatformProgram[Flags, State, Event]

///|
pub fn[Flags, State, Event] platform_worker(
  config : GeneratedInitSubscriptionsUpdate[
    (Flags) -> (State, PlatformCmdCmd[Event]),
    (State) -> PlatformSubSub[Event],
    (Event) -> (State) -> (State, PlatformCmdCmd[Event]),
  ],
) -> PlatformProgram[Flags, State, Event] {
  config
}

///|
pub(all) struct GeneratedOffsetStart[Offset, Start] {
  offset : Offset
  start : Start
} derive(Eq, Show)

///|
struct TimeCivil {
  day : Int64
  month : Int64
  year : Int64
}

///|
pub(all) enum TimeMonth {
  Apr
  Aug
  Dec
  Feb
  Jan
  Jul
  Jun
  Mar
  May
  Nov
  Oct
  Sep
} derive(Eq, Show)

///|
pub(all) enum TimePosix {
  Posix(Int64)
} derive(Eq, Show)

///|
pub(all) enum TimeWeekday {
  Fri
  Mon
  Sat
  Sun
  Thu
  Tue
  Wed
} derive(Eq, Show)

///|
pub typealias GeneratedOffsetStart[Int64, Int64] as TimeEra

///|
pub enum TimeZone {
  Zone(Int64, @list.List[TimeEra])
} derive(Eq, Show)

///|
pub enum TimeZoneName {
  Name(StringString)
  Offset(Int64)
} derive(Eq, Show)

///|
pub fn time_custom_zone(
  default_offset_in_minutes : Int64,
  eras : @list.List[GeneratedOffsetStart[Int64, Int64]],
) -> TimeZone {
  TimeZone::Zone(default_offset_in_minutes, eras)
}

///|
pub fn time_millis_to_posix(milliseconds : Int64) -> TimePosix {
  TimePosix::Posix(milliseconds)
}

///|
pub fn time_posix_to_millis(time_posix : TimePosix) -> Int64 {
  let TimePosix::Posix(millis) = time_posix
  millis
}

///|
pub fn time_to_adjusted_minutes(
  time_zone : TimeZone,
  time : TimePosix,
) -> Int64 {
  let TimeZone::Zone(default_offset, eras) = time_zone
  time_to_adjusted_minutes_help(
    default_offset,
    time_posix_to_millis(time) / 60000L,
    eras,
  )
}

///|
pub fn time_to_adjusted_minutes_help(
  default_offset : Int64,
  posix_minutes : Int64,
  eras : @list.List[GeneratedOffsetStart[Int64, Int64]],
) -> Int64 {
  match eras {
    @list.List::Empty => posix_minutes + default_offset
    @list.List::More(era, tail=older_eras) =>
      if era.start < posix_minutes {
        posix_minutes + era.offset
      } else {
        time_to_adjusted_minutes_help(default_offset, posix_minutes, older_eras)
      }
  }
}

///|
fn time_to_civil(minutes : Int64) -> TimeCivil {
  let raw_day : Int64 = minutes / (60L * 24L) + 719468L
  let era : Int64 = (if raw_day >= 0L { raw_day } else { raw_day - 146096L }) /
    146097L
  let day_of_era : Int64 = raw_day - era * 146097L
  let year_of_era : Int64 = (
      day_of_era -
      day_of_era / 1460L +
      day_of_era / 36524L -
      day_of_era / 146096L
    ) /
    365L
  let day_of_year : Int64 = day_of_era -
    (365L * year_of_era + year_of_era / 4L - year_of_era / 100L)
  let mp : Int64 = (5L * day_of_year + 2L) / 153L
  let month : Int64 = mp + (if mp < 10L { 3L } else { -9L })
  let year : Int64 = year_of_era + era * 400L
  TimeCivil::{
    day: day_of_year - (153L * mp + 2L) / 5L + 1L,
    month,
    year: year + (if month <= 2L { 1L } else { 0L }),
  }
}

///|
pub fn time_to_day(zone : TimeZone, time : TimePosix) -> Int64 {
  time_to_civil(time_to_adjusted_minutes(zone, time)).day
}

///|
pub fn time_to_hour(zone : TimeZone, time : TimePosix) -> Int64 {
  time_to_adjusted_minutes(zone, time) / 60L % 24L
}

///|
pub fn time_to_millis(_ : TimeZone, time : TimePosix) -> Int64 {
  time_posix_to_millis(time) % 1000L
}

///|
pub fn time_to_minute(zone : TimeZone, time : TimePosix) -> Int64 {
  time_to_adjusted_minutes(zone, time) % 60L
}

///|
pub fn time_to_month(zone : TimeZone, time : TimePosix) -> TimeMonth {
  match time_to_civil(time_to_adjusted_minutes(zone, time)).month {
    1L => TimeMonth::Jan
    2L => TimeMonth::Feb
    3L => TimeMonth::Mar
    4L => TimeMonth::Apr
    5L => TimeMonth::May
    6L => TimeMonth::Jun
    7L => TimeMonth::Jul
    8L => TimeMonth::Aug
    9L => TimeMonth::Sep
    10L => TimeMonth::Oct
    11L => TimeMonth::Nov
    _ => TimeMonth::Dec
  }
}

///|
pub fn time_to_second(_ : TimeZone, time : TimePosix) -> Int64 {
  time_posix_to_millis(time) / 1000L % 60L
}

///|
pub fn time_to_weekday(zone : TimeZone, time : TimePosix) -> TimeWeekday {
  match time_to_adjusted_minutes(zone, time) / (60L * 24L) % 7L {
    0L => TimeWeekday::Thu
    1L => TimeWeekday::Fri
    2L => TimeWeekday::Sat
    3L => TimeWeekday::Sun
    4L => TimeWeekday::Mon
    5L => TimeWeekday::Tue
    _ => TimeWeekday::Wed
  }
}

///|
pub fn time_to_year(zone : TimeZone, time : TimePosix) -> Int64 {
  time_to_civil(time_to_adjusted_minutes(zone, time)).year
}

///|
pub let time_utc : TimeZone = TimeZone::Zone(0L, @list.empty())

///|
pub fn json_encode_encode(indent_size : Int64, json : Json) -> StringString {
  StringString::One(Json::stringify(json, indent=Int64::to_int(indent_size)))
}

///|
pub let json_encode_null : Json = Json::null()

///|
pub fnalias Json::boolean as json_encode_bool

///|
pub fn json_encode_int(int : Int64) -> Json {
  Json::number(Int64::to_double(int), repr=Int64::to_string(int))
}

///|
pub fnalias Json::number as json_encode_float

///|
pub fn json_encode_string(string : StringString) -> Json {
  Json::string(string_string_to_string(string))
}

///|
pub fn[A] json_encode_array(
  element_to_json : (A) -> Json,
  array : @immut/array.T[A],
) -> Json {
  Json::array(
    array
    |> @immut/array.T::iter()
    |> Iter::map(element_to_json)
    |> Array::from_iter,
  )
}

///|
pub fn[A] json_encode_list(
  element_to_json : (A) -> Json,
  list : @list.List[A],
) -> Json {
  Json::array(
    list |> @list.List::iter() |> Iter::map(element_to_json) |> Array::from_iter,
  )
}

///|
pub fn[A] json_encode_set(
  element_to_json : (A) -> Json,
  set : @immut/sorted_set.SortedSet[A],
) -> Json {
  Json::array(
    set
    |> @immut/sorted_set.SortedSet::iter()
    |> Iter::map(element_to_json)
    |> Array::from_iter,
  )
}

///|
pub fn[K, V] json_encode_dict(
  key_to_string : (K) -> StringString,
  value_to_json : (V) -> Json,
  dict : @immut/sorted_map.SortedMap[K, V],
) -> Json {
  Json::object(
    dict
    |> @immut/sorted_map.SortedMap::iter()
    |> Iter::map(fn(entry) {
      (string_string_to_string(key_to_string(entry.0)), value_to_json(entry.1))
    })
    |> Map::from_iter,
  )
}

///|
pub fn json_encode_object(fields : @list.List[(StringString, Json)]) -> Json {
  Json::object(
    fields
    |> @list.List::iter()
    |> Iter::map(fn(field) { (string_string_to_string(field.0), field.1) })
    |> Map::from_iter,
  )
}

///|
pub(all) enum JsonDecodeError {
  Field(StringString, JsonDecodeError)
  Index(Int64, JsonDecodeError)
  OneOf(@list.List[JsonDecodeError])
  Failure(StringString, Json)
} derive(Eq)

///|
impl Show for JsonDecodeError with output(self, logger) {
  logger.write_string(json_decode_error_to_string_help(self, ""))
}

///|
pub(all) struct JsonDecodeDecoder[A] {
  decode : (Json) -> Result[A, JsonDecodeError]
}

///|
pub fn json_decode_error_to_string(
  json_decode_error : JsonDecodeError,
) -> StringString {
  StringString::One(json_decode_error_to_string_help(json_decode_error, ""))
}

///|
fn json_decode_error_to_string_help(
  json_decode_error : JsonDecodeError,
  context : String,
) -> String {
  match json_decode_error {
    Field(field_name, err) =>
      json_decode_error_to_string_help(
        err,
        context + json_field_description(string_string_to_string(field_name)),
      )
    Index(i, err) => json_decode_error_to_string_help(err, context + "[\{i}]")
    OneOf(errors) =>
      match errors {
        @list.List::Empty =>
          "Ran into a Json.Decode.oneOf with no possibilities" +
          (if String::is_empty(context) { "!" } else { " at json\{context}" })
        @list.List::More(err, tail=@list.List::Empty) =>
          json_decode_error_to_string_help(err, context)
        _ =>
          ((if String::is_empty(context) {
            "Json.Decode.oneOf"
          } else {
            "The Json.Decode.oneOf at json\{context}"
          }) +
          " failed in the following \{@list.List::length(errors)} ways:")
          |> Iter::singleton
          |> Iter::concat(
            errors
            |> @list.List::iter
            |> Iter::mapi(fn(index, error) {
              "\n\n(\{index + 1}) " +
              str_indent_by_4(json_decode_error_to_string_help(error, ""))
            }),
          )
          |> Iter::join("\n\n")
      }
    Failure(msg, json) =>
      (if String::is_empty(context) {
        "Problem with the given value:\n\n"
      } else {
        "Problem with the value at json\{context}:\n\n    "
      }) +
      str_indent_by_4(Json::stringify(json, indent=4)) +
      "\n\n\{string_string_to_string(msg)}"
  }
}

///|
fn str_indent_by_4(string : String) -> String {
  string
  |> String::split("\n")
  |> Iter::map(fn(line) { "    \{line}" })
  |> Iter::join("\n")
}

///|
pub fn[A] json_decode_decode_value(
  decoder : JsonDecodeDecoder[A],
  json : Json,
) -> ResultResult[JsonDecodeError, A] {
  (decoder.decode)(json)
}

///|
pub fn[A] json_decode_decode_string(
  decoder : JsonDecodeDecoder[A],
  json_string : StringString,
) -> ResultResult[JsonDecodeError, A] {
  let json_str : String = string_string_to_string(json_string)
  (decoder.decode)(@json.parse(json_str)) catch {
    json_parse_error =>
      Result::Err(
        JsonDecodeError::Failure(
          StringString::One(@json.ParseError::to_string(json_parse_error)),
          Json::string(json_str),
        ),
      )
  }
}

///|
pub let json_decode_value : JsonDecodeDecoder[Json] = JsonDecodeDecoder::{
  decode: fn(json) { Result::Ok(json) },
}

///|
pub let json_decode_bool : JsonDecodeDecoder[Bool] = JsonDecodeDecoder::{
  decode: fn(json) {
    match Json::as_bool(json) {
      Option::Some(bool) => Result::Ok(bool)
      Option::None =>
        Result::Err(
          JsonDecodeError::Failure(StringString::One("Expecting a BOOL"), json),
        )
    }
  },
}

///|
pub let json_decode_float : JsonDecodeDecoder[Double] = JsonDecodeDecoder::{
  decode: fn(json) {
    match Json::as_number(json) {
      Option::Some(double) => Result::Ok(double)
      Option::None =>
        Result::Err(
          JsonDecodeError::Failure(
            StringString::One("Expecting a NUMBER"),
            json,
          ),
        )
    }
  },
}

///|
pub let json_decode_int : JsonDecodeDecoder[Int64] = JsonDecodeDecoder::{
  decode: fn(json) {
    match Json::as_number(json) {
      Option::Some(double) => {
        let as_int64 = Double::to_int64(double)
        if double == Int64::to_double(as_int64) {
          Result::Ok(as_int64)
        } else {
          Result::Err(
            JsonDecodeError::Failure(
              StringString::One("Expecting an INT"),
              json,
            ),
          )
        }
      }
      Option::None =>
        Result::Err(
          JsonDecodeError::Failure(StringString::One("Expecting an INT"), json),
        )
    }
  },
}

///|
pub let json_decode_string : JsonDecodeDecoder[StringString] = JsonDecodeDecoder::{
  decode: fn(json) {
    match Json::as_string(json) {
      Option::Some(string) => Result::Ok(StringString::One(string))
      Option::None =>
        Result::Err(
          JsonDecodeError::Failure(
            StringString::One("Expecting a STRING"),
            json,
          ),
        )
    }
  },
}

///|
pub fn[A] json_decode_null(value_on_null : A) -> JsonDecodeDecoder[A] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      match Json::as_null(json) {
        Option::Some(_) => Result::Ok(value_on_null)
        Option::None =>
          Result::Err(
            JsonDecodeError::Failure(StringString::One("Expecting NULL"), json),
          )
      }
    },
  }
}

///|
pub fn[A] json_decode_nullable(
  on_not_null_decoder : JsonDecodeDecoder[A],
) -> JsonDecodeDecoder[A?] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      match Json::as_null(json) {
        Option::Some(_) => Result::Ok(Option::None)
        Option::None =>
          match (on_not_null_decoder.decode)(json) {
            Result::Ok(decoded_on_not_null) =>
              Result::Ok(Option::Some(decoded_on_not_null))
            Result::Err(on_not_null_error) =>
              Result::Err(
                JsonDecodeError::OneOf(
                  @list.of([
                    JsonDecodeError::Failure(
                      StringString::One("Expecting NULL"),
                      json,
                    ),
                    on_not_null_error,
                  ]),
                ),
              )
          }
      }
    },
  }
}

///|
pub fn[A] json_decode_list(
  element_decoder : JsonDecodeDecoder[A],
) -> JsonDecodeDecoder[@list.List[A]] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      match json.as_array() {
        Option::None =>
          Result::Err(
            JsonDecodeError::Failure(
              StringString::One("Expecting an ARRAY"),
              json,
            ),
          )
        Option::Some(array) => {
          let decoded : Array[A] = Array::new()
          for element_index, element_json in array {
            match (element_decoder.decode)(element_json) {
              Result::Ok(decoded_element) =>
                Array::push(decoded, decoded_element)
              Result::Err(element_decode_error) =>
                return Result::Err(
                  JsonDecodeError::Index(
                    Int::to_int64(element_index),
                    element_decode_error,
                  ),
                )
            }
          } else {
            Result::Ok(@list.from_array(decoded))
          }
        }
      }
    },
  }
}

///|
pub fn[A] json_decode_array(
  element_decoder : JsonDecodeDecoder[A],
) -> JsonDecodeDecoder[@immut/array.T[A]] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      match json.as_array() {
        Option::None =>
          Result::Err(
            JsonDecodeError::Failure(
              StringString::One("Expecting an ARRAY"),
              json,
            ),
          )
        Option::Some(array) => {
          let mut decoded : @immut/array.T[A] = @immut/array.new()
          for element_index, element_json in array {
            match (element_decoder.decode)(element_json) {
              Result::Ok(decoded_element) =>
                decoded = @immut/array.T::push(decoded, decoded_element)
              Result::Err(element_decode_error) =>
                return Result::Err(
                  JsonDecodeError::Index(
                    Int::to_int64(element_index),
                    element_decode_error,
                  ),
                )
            }
          } else {
            Result::Ok(decoded)
          }
        }
      }
    },
  }
}

///|
pub fn[A, Combined] json_decode_one_or_more(
  combine_head_tail : (A, @list.List[A]) -> Combined,
  element_decoder : JsonDecodeDecoder[A],
) -> JsonDecodeDecoder[Combined] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      match json.as_array() {
        Option::None =>
          Result::Err(
            JsonDecodeError::Failure(
              StringString::One("Expecting an ARRAY"),
              json,
            ),
          )
        Option::Some(array) => {
          let decoded : Array[A] = Array::new()
          for element_index, element_json in array {
            match (element_decoder.decode)(element_json) {
              Result::Ok(decoded_element) =>
                Array::push(decoded, decoded_element)
              Result::Err(element_decode_error) =>
                return Result::Err(
                  JsonDecodeError::Index(
                    Int::to_int64(element_index),
                    element_decode_error,
                  ),
                )
            }
          } else {
            match @list.from_array(decoded) {
              @list.List::Empty =>
                Result::Err(
                  JsonDecodeError::Failure(
                    StringString::One(
                      "Expecting an ARRAY with at least ONE element",
                    ),
                    json,
                  ),
                )
              @list.List::More(decoded_head, tail=decoded_tail) =>
                Result::Ok(combine_head_tail(decoded_head, decoded_tail))
            }
          }
        }
      }
    },
  }
}

///|
pub fn[V] json_decode_dict(
  element_decoder : JsonDecodeDecoder[V],
) -> JsonDecodeDecoder[@immut/sorted_map.SortedMap[StringString, V]] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      match json.as_object() {
        Option::None =>
          Result::Err(
            JsonDecodeError::Failure(
              StringString::One("Expecting an OBJECT"),
              json,
            ),
          )
        Option::Some(json_fields) => {
          let mut decoded : @immut/sorted_map.SortedMap[StringString, V] = @immut/sorted_map.new()
          for key, element_json in json_fields {
            match (element_decoder.decode)(element_json) {
              Result::Ok(decoded_value) =>
                decoded = @immut/sorted_map.SortedMap::add(
                  decoded,
                  StringString::One(key),
                  decoded_value,
                )
              Result::Err(element_decode_error) =>
                return Result::Err(
                  JsonDecodeError::Field(
                    StringString::One(key),
                    element_decode_error,
                  ),
                )
            }
          } else {
            Result::Ok(decoded)
          }
        }
      }
    },
  }
}

///|
pub fn[V] json_decode_key_value_pairs(
  element_decoder : JsonDecodeDecoder[V],
) -> JsonDecodeDecoder[@list.List[(StringString, V)]] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      match json.as_object() {
        Option::None =>
          Result::Err(
            JsonDecodeError::Failure(
              StringString::One("Expecting an OBJECT"),
              json,
            ),
          )
        Option::Some(json_fields) => {
          let decoded : Array[(StringString, V)] = Array::new()
          for key, element_json in json_fields {
            match (element_decoder.decode)(element_json) {
              Result::Ok(decoded_value) =>
                Array::push(decoded, (StringString::One(key), decoded_value))
              Result::Err(element_decode_error) =>
                return Result::Err(
                  JsonDecodeError::Field(
                    StringString::One(key),
                    element_decode_error,
                  ),
                )
            }
          } else {
            Result::Ok(@list.from_array(decoded))
          }
        }
      }
    },
  }
}

///|
pub fn[A] json_decode_index(
  index : Int64,
  field_value_decoder : JsonDecodeDecoder[A],
) -> JsonDecodeDecoder[A] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      match json.as_array() {
        Option::None =>
          Result::Err(
            JsonDecodeError::Failure(
              StringString::One("Expecting an ARRAY"),
              json,
            ),
          )
        Option::Some(json_array) =>
          match Array::get(json_array, Int64::to_int(index)) {
            Option::None =>
              Result::Err(
                JsonDecodeError::Failure(
                  StringString::One(
                    "Expecting an ARRAY with an element at index \{index}",
                  ),
                  json,
                ),
              )
            Option::Some(field_value_json) =>
              Result::map_err((field_value_decoder.decode)(field_value_json), element_decode_error => JsonDecodeError::Index(
                index, element_decode_error,
              ))
          }
      }
    },
  }
}

///|
pub fn[A] json_decode_field(
  field_name : StringString,
  field_value_decoder : JsonDecodeDecoder[A],
) -> JsonDecodeDecoder[A] {
  let field_name_as_string : String = string_string_to_string(field_name)
  JsonDecodeDecoder::{
    decode: fn(json) {
      match json.as_object() {
        Option::None =>
          Result::Err(
            JsonDecodeError::Failure(
              StringString::One("Expecting an OBJECT"),
              json,
            ),
          )
        Option::Some(json_fields) =>
          match Map::get(json_fields, field_name_as_string) {
            Option::None =>
              Result::Err(
                JsonDecodeError::Failure(
                  StringString::One(
                    "Expecting an OBJECT with field \{json_field_description(field_name_as_string)}",
                  ),
                  json,
                ),
              )
            Option::Some(field_value_json) =>
              Result::map_err((field_value_decoder.decode)(field_value_json), element_decode_error => JsonDecodeError::Field(
                StringString::One(field_name_as_string),
                element_decode_error,
              ))
          }
      }
    },
  }
}

///|
fn json_field_description(field_name : String) -> String {
  if (field_name
    |> String::iter()
    |> Iter::head
    |> Option::map_or(false, Char::is_ascii_alphabetic)) &&
    (field_name
    |> String::iter()
    |> Iter::drop(1)
    |> Iter::all(tail_char => Char::is_ascii_alphabetic(tail_char) ||
      Char::is_ascii_digit(tail_char))) {
    "." + field_name
  } else {
    "['\{field_name}'']"
  }
}

///|
pub fn[A] json_decode_at(
  field_name_path : @list.List[StringString],
  inner_field_value_decoder : JsonDecodeDecoder[A],
) -> JsonDecodeDecoder[A] {
  // can be optimized (flattened to single decode step)
  list_foldr(json_decode_field, inner_field_value_decoder, field_name_path)
}

///|
pub fn[A] json_decode_succeed(result : A) -> JsonDecodeDecoder[A] {
  JsonDecodeDecoder::{ decode: fn(_json) { Result::Ok(result) } }
}

///|
pub fn[A] json_decode_fail(message : StringString) -> JsonDecodeDecoder[A] {
  JsonDecodeDecoder::{
    decode: fn(json) { Result::Err(JsonDecodeError::Failure(message, json)) },
  }
}

///|
pub fn[A] json_decode_lazy(
  construct_decoder : (Unit) -> JsonDecodeDecoder[A],
) -> JsonDecodeDecoder[A] {
  JsonDecodeDecoder::{
    decode: fn(json) { (construct_decoder(()).decode)(json) },
  }
}

///|
pub fn[A, B] json_decode_and_then(
  result_to_followup_decoder : (A) -> JsonDecodeDecoder[B],
  decoder : JsonDecodeDecoder[A],
) -> JsonDecodeDecoder[B] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      (decoder.decode)(json)
      |> Result::bind(fn(result) {
        (result_to_followup_decoder(result).decode)(json)
      })
    },
  }
}

///|
pub fn[A] json_decode_maybe(
  decoder : JsonDecodeDecoder[A],
) -> JsonDecodeDecoder[A?] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      Result::Ok(
        match (decoder.decode)(json) {
          Result::Err(_) => Option::None
          Result::Ok(decoded) => Option::Some(decoded)
        },
      )
    },
  }
}

///|
pub fn[A] json_decode_one_of(
  options : @list.List[JsonDecodeDecoder[A]],
) -> JsonDecodeDecoder[A] {
  JsonDecodeDecoder::{
    decode: json => {
      let option_decode_errors : Array[JsonDecodeError] = Array::new()
      for next_option_decoder in options {
        match (next_option_decoder.decode)(json) {
          Result::Ok(value) => return Result::Ok(value)
          Result::Err(option_decode_error) =>
            option_decode_errors.push(option_decode_error)
        }
      }
      Result::Err(
        JsonDecodeError::OneOf(@list.from_array(option_decode_errors)),
      )
    },
  }
}

///|
pub fn[A, B] json_decode_map(
  value_change : (A) -> B,
  decoder : JsonDecodeDecoder[A],
) -> JsonDecodeDecoder[B] {
  JsonDecodeDecoder::{
    decode: fn(json) { result_map(value_change, (decoder.decode)(json)) },
  }
}

///|
pub fn[A, B, Combined] json_decode_map2(
  combine : (A, B) -> Combined,
  a_decoder : JsonDecodeDecoder[A],
  b_decoder : JsonDecodeDecoder[B],
) -> JsonDecodeDecoder[Combined] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      result_map2(combine, (a_decoder.decode)(json), (b_decoder.decode)(json))
    },
  }
}

///|
pub fn[A, B, C, Combined] json_decode_map3(
  combine : (A, B, C) -> Combined,
  a_decoder : JsonDecodeDecoder[A],
  b_decoder : JsonDecodeDecoder[B],
  c_decoder : JsonDecodeDecoder[C],
) -> JsonDecodeDecoder[Combined] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      result_map3(
        combine,
        (a_decoder.decode)(json),
        (b_decoder.decode)(json),
        (c_decoder.decode)(json),
      )
    },
  }
}

///|
pub fn[A, B, C, D, Combined] json_decode_map4(
  combine : (A, B, C, D) -> Combined,
  a_decoder : JsonDecodeDecoder[A],
  b_decoder : JsonDecodeDecoder[B],
  c_decoder : JsonDecodeDecoder[C],
  d_decoder : JsonDecodeDecoder[D],
) -> JsonDecodeDecoder[Combined] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      result_map4(
        combine,
        (a_decoder.decode)(json),
        (b_decoder.decode)(json),
        (c_decoder.decode)(json),
        (d_decoder.decode)(json),
      )
    },
  }
}

///|
pub fn[A, B, C, D, E, Combined] json_decode_map5(
  combine : (A, B, C, D, E) -> Combined,
  a_decoder : JsonDecodeDecoder[A],
  b_decoder : JsonDecodeDecoder[B],
  c_decoder : JsonDecodeDecoder[C],
  d_decoder : JsonDecodeDecoder[D],
  e_decoder : JsonDecodeDecoder[E],
) -> JsonDecodeDecoder[Combined] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      result_map5(
        combine,
        (a_decoder.decode)(json),
        (b_decoder.decode)(json),
        (c_decoder.decode)(json),
        (d_decoder.decode)(json),
        (e_decoder.decode)(json),
      )
    },
  }
}

///|
pub fn[A, B, C, D, E, F, Combined] json_decode_map6(
  combine : (A, B, C, D, E, F) -> Combined,
  a_decoder : JsonDecodeDecoder[A],
  b_decoder : JsonDecodeDecoder[B],
  c_decoder : JsonDecodeDecoder[C],
  d_decoder : JsonDecodeDecoder[D],
  e_decoder : JsonDecodeDecoder[E],
  f_decoder : JsonDecodeDecoder[F],
) -> JsonDecodeDecoder[Combined] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      match
        (
          (a_decoder.decode)(json),
          (b_decoder.decode)(json),
          (c_decoder.decode)(json),
          (d_decoder.decode)(json),
          (e_decoder.decode)(json),
          (f_decoder.decode)(json),
        ) {
        (
          Result::Ok(a),
          Result::Ok(b),
          Result::Ok(c),
          Result::Ok(d),
          Result::Ok(e),
          Result::Ok(f),
        ) => Result::Ok(combine(a, b, c, d, e, f))
        (_, _, _, _, _, Result::Err(error))
        | (_, _, _, _, Result::Err(error), _)
        | (_, _, _, Result::Err(error), _, _)
        | (_, _, Result::Err(error), _, _, _)
        | (_, Result::Err(error), _, _, _, _)
        | (Result::Err(error), _, _, _, _, _) => Result::Err(error)
      }
    },
  }
}

///|
pub fn[A, B, C, D, E, F, G, Combined] json_decode_map7(
  combine : (A, B, C, D, E, F, G) -> Combined,
  a_decoder : JsonDecodeDecoder[A],
  b_decoder : JsonDecodeDecoder[B],
  c_decoder : JsonDecodeDecoder[C],
  d_decoder : JsonDecodeDecoder[D],
  e_decoder : JsonDecodeDecoder[E],
  f_decoder : JsonDecodeDecoder[F],
  g_decoder : JsonDecodeDecoder[G],
) -> JsonDecodeDecoder[Combined] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      match
        (
          (a_decoder.decode)(json),
          (b_decoder.decode)(json),
          (c_decoder.decode)(json),
          (d_decoder.decode)(json),
          (e_decoder.decode)(json),
          (f_decoder.decode)(json),
          (g_decoder.decode)(json),
        ) {
        (
          Result::Ok(a),
          Result::Ok(b),
          Result::Ok(c),
          Result::Ok(d),
          Result::Ok(e),
          Result::Ok(f),
          Result::Ok(g),
        ) => Result::Ok(combine(a, b, c, d, e, f, g))
        (_, _, _, _, _, _, Result::Err(error))
        | (_, _, _, _, _, Result::Err(error), _)
        | (_, _, _, _, Result::Err(error), _, _)
        | (_, _, _, Result::Err(error), _, _, _)
        | (_, _, Result::Err(error), _, _, _, _)
        | (_, Result::Err(error), _, _, _, _, _)
        | (Result::Err(error), _, _, _, _, _, _) => Result::Err(error)
      }
    },
  }
}

///|
pub fn[A, B, C, D, E, F, G, H, Combined] json_decode_map8(
  combine : (A, B, C, D, E, F, G, H) -> Combined,
  a_decoder : JsonDecodeDecoder[A],
  b_decoder : JsonDecodeDecoder[B],
  c_decoder : JsonDecodeDecoder[C],
  d_decoder : JsonDecodeDecoder[D],
  e_decoder : JsonDecodeDecoder[E],
  f_decoder : JsonDecodeDecoder[F],
  g_decoder : JsonDecodeDecoder[G],
  h_decoder : JsonDecodeDecoder[H],
) -> JsonDecodeDecoder[Combined] {
  JsonDecodeDecoder::{
    decode: fn(json) {
      match
        (
          (a_decoder.decode)(json),
          (b_decoder.decode)(json),
          (c_decoder.decode)(json),
          (d_decoder.decode)(json),
          (e_decoder.decode)(json),
          (f_decoder.decode)(json),
          (g_decoder.decode)(json),
          (h_decoder.decode)(json),
        ) {
        (
          Result::Ok(a),
          Result::Ok(b),
          Result::Ok(c),
          Result::Ok(d),
          Result::Ok(e),
          Result::Ok(f),
          Result::Ok(g),
          Result::Ok(h),
        ) => Result::Ok(combine(a, b, c, d, e, f, g, h))
        (_, _, _, _, _, _, _, Result::Err(error))
        | (_, _, _, _, _, _, Result::Err(error), _)
        | (_, _, _, _, _, Result::Err(error), _, _)
        | (_, _, _, _, Result::Err(error), _, _, _)
        | (_, _, _, Result::Err(error), _, _, _, _)
        | (_, _, Result::Err(error), _, _, _, _, _)
        | (_, Result::Err(error), _, _, _, _, _, _)
        | (Result::Err(error), _, _, _, _, _, _, _) => Result::Err(error)
      }
    },
  }
}

///|
fn str_remove_whitespace_and_ascii_lowercase(str : String) -> String {
  str
  |> String::iter()
  |> Iter::filter(char => !char.is_whitespace())
  |> Iter::map(char => char.to_ascii_lowercase())
  |> String::from_iter
}

///|
pub fn virtual_dom_no_java_script_uri(uri : StringString) -> StringString {
  if str_remove_whitespace_and_ascii_lowercase(string_string_to_string(uri)).contains(
      "javascript",
    ) {
    string_empty
  } else {
    uri
  }
}

///|
pub fn virtual_dom_no_java_script_or_html_uri(
  uri : StringString,
) -> StringString {
  let uri_normal : String = str_remove_whitespace_and_ascii_lowercase(
    string_string_to_string(uri),
  )
  if uri_normal.contains("javascript") || uri_normal.contains("data:text/html") {
    string_empty
  } else {
    uri
  }
}

///|
pub struct GeneratedMessagePreventDefaultStopPropagation[Message, PreventDefault, StopPropagation] {
  message : Message
  prevent_default : PreventDefault
  stop_propagation : StopPropagation
} derive(Eq, Show)

///|
pub typealias GeneratedMessagePreventDefaultStopPropagation[Event, Bool, Bool] as VirtualDomCustomHandledEvent[Event]

///|
pub enum VirtualDomHandler[Event] {
  Normal(JsonDecodeDecoder[Event])
  MayStopPropagation(JsonDecodeDecoder[(Event, Bool)])
  MayPreventDefault(JsonDecodeDecoder[(Event, Bool)])
  Custom(JsonDecodeDecoder[VirtualDomCustomHandledEvent[Event]])
}

///|
pub enum VirtualDomAttribute[Event] {
  ModifierAttribute(namespace_~ : String?, key~ : String, value~ : String)
  ModifierStyle(key~ : String, value~ : String)
  ModifierProperty(key~ : String, value~ : Json)
  ModifierEventListener(name~ : String, handler~ : VirtualDomHandler[Event])
}

///|
pub enum VirtualDomNode[Event] {
  Text(String)
  Element(
    tag~ : String,
    namespace_~ : String?,
    subs~ : @list.List[VirtualDomNode[Event]],
    modifiers~ : @list.List[VirtualDomAttribute[Event]]
  )
  ElementKeyed(
    tag~ : String,
    namespace_~ : String?,
    subs~ : @list.List[(String, VirtualDomNode[Event])],
    modifiers~ : @list.List[VirtualDomAttribute[Event]]
  )
}

///|
pub fn[Event] virtual_dom_text(string : StringString) -> VirtualDomNode[Event] {
  VirtualDomNode::Text(string_string_to_string(string))
}

///|
pub fn[Event] virtual_dom_node(
  tag : StringString,
  modifiers : @list.List[VirtualDomAttribute[Event]],
  subs : @list.List[VirtualDomNode[Event]],
) -> VirtualDomNode[Event] {
  VirtualDomNode::Element(
    tag=string_string_to_string(tag),
    namespace_=Option::None,
    subs~,
    modifiers~,
  )
}

///|
pub fn[Event] virtual_dom_node_ns(
  namespace_ : StringString,
  tag : StringString,
  modifiers : @list.List[VirtualDomAttribute[Event]],
  subs : @list.List[VirtualDomNode[Event]],
) -> VirtualDomNode[Event] {
  VirtualDomNode::Element(
    tag=string_string_to_string(tag),
    namespace_=Option::Some(string_string_to_string(namespace_)),
    subs~,
    modifiers~,
  )
}

///|
pub fn[Event] virtual_dom_keyed_node(
  tag : StringString,
  modifiers : @list.List[VirtualDomAttribute[Event]],
  subs : @list.List[(StringString, VirtualDomNode[Event])],
) -> VirtualDomNode[Event] {
  VirtualDomNode::ElementKeyed(
    tag=string_string_to_string(tag),
    namespace_=Option::None,
    subs=subs
      |> @list.List::map(fn(keyed_node) {
        let (key, node) = keyed_node
        (string_string_to_string(key), node)
      }),
    modifiers~,
  )
}

///|
pub fn[Event] virtual_dom_keyed_node_ns(
  namespace_ : StringString,
  tag : StringString,
  modifiers : @list.List[VirtualDomAttribute[Event]],
  subs : @list.List[(StringString, VirtualDomNode[Event])],
) -> VirtualDomNode[Event] {
  VirtualDomNode::ElementKeyed(
    tag=string_string_to_string(tag),
    namespace_=Option::Some(string_string_to_string(namespace_)),
    subs=subs
      |> @list.List::map(fn(keyed_node) {
        let (key, node) = keyed_node
        (string_string_to_string(key), node)
      }),
    modifiers~,
  )
}

///|
pub fn[Event] virtual_dom_style(
  key : StringString,
  value : StringString,
) -> VirtualDomAttribute[Event] {
  VirtualDomAttribute::ModifierStyle(
    key=string_string_to_string(key),
    value=string_string_to_string(value),
  )
}

///|
pub fn[Event] virtual_dom_property(
  key : StringString,
  value : Json,
) -> VirtualDomAttribute[Event] {
  VirtualDomAttribute::ModifierProperty(
    key=string_string_to_string(key),
    value~,
  )
}

///|
pub fn[Event] virtual_dom_attribute(
  key : StringString,
  value : StringString,
) -> VirtualDomAttribute[Event] {
  VirtualDomAttribute::ModifierAttribute(
    namespace_=Option::None,
    key=string_string_to_string(key),
    value=string_string_to_string(value),
  )
}

///|
pub fn[Event] virtual_dom_attribute_ns(
  namespace_ : StringString,
  key : StringString,
  value : StringString,
) -> VirtualDomAttribute[Event] {
  VirtualDomAttribute::ModifierAttribute(
    namespace_=Option::Some(string_string_to_string(namespace_)),
    key=string_string_to_string(key),
    value=string_string_to_string(value),
  )
}

///|
pub fn[Event] virtual_dom_on(
  name : StringString,
  handler : VirtualDomHandler[Event],
) -> VirtualDomAttribute[Event] {
  VirtualDomAttribute::ModifierEventListener(
    name=string_string_to_string(name),
    handler~,
  )
}

///|
pub fn[Event, EventMapped] virtual_dom_map_attribute(
  event_change : (Event) -> EventMapped,
  modifier : VirtualDomAttribute[Event],
) -> VirtualDomAttribute[EventMapped] {
  match modifier {
    VirtualDomAttribute::ModifierAttribute(namespace_~, key~, value~) =>
      VirtualDomAttribute::ModifierAttribute(namespace_~, key~, value~)
    VirtualDomAttribute::ModifierStyle(key~, value~) =>
      VirtualDomAttribute::ModifierStyle(key~, value~)
    VirtualDomAttribute::ModifierProperty(key~, value~) =>
      VirtualDomAttribute::ModifierProperty(key~, value~)
    VirtualDomAttribute::ModifierEventListener(name~, handler~) =>
      VirtualDomAttribute::ModifierEventListener(
        name~,
        handler=virtual_dom_handler_map(event_change, handler),
      )
  }
}

///|
pub fn[Event, EventMapped] virtual_dom_handler_map(
  event_change : (Event) -> EventMapped,
  handler : VirtualDomHandler[Event],
) -> VirtualDomHandler[EventMapped] {
  match handler {
    VirtualDomHandler::Normal(decoder) =>
      VirtualDomHandler::Normal(json_decode_map(event_change, decoder))
    VirtualDomHandler::MayStopPropagation(decoder) =>
      VirtualDomHandler::MayStopPropagation(
        json_decode_map(
          (decoded : (Event, Bool)) => (event_change(decoded.0), decoded.1),
          decoder,
        ),
      )
    VirtualDomHandler::MayPreventDefault(decoder) =>
      VirtualDomHandler::MayPreventDefault(
        json_decode_map(
          (decoded : (Event, Bool)) => (event_change(decoded.0), decoded.1),
          decoder,
        ),
      )
    VirtualDomHandler::Custom(decoder) =>
      VirtualDomHandler::Custom(
        json_decode_map(
          fn(custom : VirtualDomCustomHandledEvent[Event]) {
            GeneratedMessagePreventDefaultStopPropagation::{
              message: event_change(custom.message),
              prevent_default: custom.prevent_default,
              stop_propagation: custom.stop_propagation,
            }
          },
          decoder,
        ),
      )
  }
}

///|
pub fn[Event, EventMapped] virtual_dom_map(
  event_change : (Event) -> EventMapped,
  node : VirtualDomNode[Event],
) -> VirtualDomNode[EventMapped] {
  match node {
    VirtualDomNode::Text(text) => VirtualDomNode::Text(text)
    VirtualDomNode::Element(tag~, namespace_~, subs~, modifiers~) =>
      VirtualDomNode::Element(
        tag~,
        namespace_~,
        subs=subs |> @list.List::map(sub => virtual_dom_map(event_change, sub)),
        modifiers=modifiers
          |> @list.List::map(fn(modifier) {
            virtual_dom_map_attribute(event_change, modifier)
          }),
      )
    VirtualDomNode::ElementKeyed(tag~, namespace_~, subs~, modifiers~) =>
      VirtualDomNode::ElementKeyed(
        tag~,
        namespace_~,
        subs=subs
          |> @list.List::map(fn(keyed_sub) {
            let (key, sub) = keyed_sub
            (key, virtual_dom_map(event_change, sub))
          }),
        modifiers=modifiers
          |> @list.List::map(fn(modifier) {
            virtual_dom_map_attribute(event_change, modifier)
          }),
      )
  }
}

///|
pub fn[A, Event] virtual_dom_lazy(
  construct : (A) -> VirtualDomNode[Event],
  a : A,
) -> VirtualDomNode[Event] {
  construct(a)
}

///|
pub fn[A, B, Event] virtual_dom_lazy2(
  construct : (A, B) -> VirtualDomNode[Event],
  a : A,
  b : B,
) -> VirtualDomNode[Event] {
  construct(a, b)
}

///|
pub fn[A, B, C, Event] virtual_dom_lazy3(
  construct : (A, B, C) -> VirtualDomNode[Event],
  a : A,
  b : B,
  c : C,
) -> VirtualDomNode[Event] {
  construct(a, b, c)
}

///|
pub fn[A, B, C, D, Event] virtual_dom_lazy4(
  construct : (A, B, C, D) -> VirtualDomNode[Event],
  a : A,
  b : B,
  c : C,
  d : D,
) -> VirtualDomNode[Event] {
  construct(a, b, c, d)
}

///|
pub fn[A, B, C, D, E, Event] virtual_dom_lazy5(
  construct : (A, B, C, D, E) -> VirtualDomNode[Event],
  a : A,
  b : B,
  c : C,
  d : D,
  e : E,
) -> VirtualDomNode[Event] {
  construct(a, b, c, d, e)
}

///|
pub fn[A, B, C, D, E, F, Event] virtual_dom_lazy6(
  construct : (A, B, C, D, E, F) -> VirtualDomNode[Event],
  a : A,
  b : B,
  c : C,
  d : D,
  e : E,
  f : F,
) -> VirtualDomNode[Event] {
  construct(a, b, c, d, e, f)
}

///|
pub fn[A, B, C, D, E, F, G, Event] virtual_dom_lazy7(
  construct : (A, B, C, D, E, F, G) -> VirtualDomNode[Event],
  a : A,
  b : B,
  c : C,
  d : D,
  e : E,
  f : F,
  g : G,
) -> VirtualDomNode[Event] {
  construct(a, b, c, d, e, f, g)
}

///|
pub fn[A, B, C, D, E, F, G, H, Event] virtual_dom_lazy8(
  construct : (A, B, C, D, E, F, G, H) -> VirtualDomNode[Event],
  a : A,
  b : B,
  c : C,
  d : D,
  e : E,
  f : F,
  g : G,
  h : H,
) -> VirtualDomNode[Event] {
  construct(a, b, c, d, e, f, g, h)
}

///|
pub fn elm_kernel_parser_is_sub_string(
  small_string : StringString,
  offset_original : Int64,
  row_original : Int64,
  col_original : Int64,
  big_string : StringString,
) -> (Int64, Int64, Int64) {
  let mut row : Int = Int64::to_int(row_original)
  let mut col : Int = Int64::to_int(col_original)
  let small_str : String = string_string_to_string(small_string)
  let big_string_from_offset : StringView = string_string_to_string(big_string).view(
    start_offset=Int64::to_int(offset_original),
  )
  if !big_string_from_offset.has_prefix(small_str) {
    (-1L, row_original, col_original)
  } else {
    for code in big_string_from_offset {
      if code == '\n' {
        row = row + 1
        col = 1
      } else {
        col = col + 1
      }
    }
    (
      offset_original + Int::to_int64(small_str.length()),
      Int::to_int64(row),
      Int::to_int64(col),
    )
  }
}

///|
pub fn elm_kernel_parser_is_sub_char(
  predicate : (Char) -> Bool,
  offset_original : Int64,
  string : StringString,
) -> Int64 {
  match
    String::get_char(
      string_string_to_string(string),
      Int64::to_int(offset_original),
    ) {
    Option::None => -1L
    Option::Some(char_at_offset) =>
      if predicate(char_at_offset) {
        if char_at_offset == '\n' {
          -2L
        } else {
          offset_original + Int::to_int64(char_at_offset.utf16_len())
        }
      } else {
        -1L
      }
  }
}

///|
pub fn elm_kernel_parser_is_ascii_code(
  code : Int64,
  offset : Int64,
  string : StringString,
) -> Bool {
  match
    String::get_char(string_string_to_string(string), Int64::to_int(offset)) {
    Option::None => false
    Option::Some(char_at_offset) =>
      Char::to_int(char_at_offset) == Int64::to_int(code)
  }
}

///|
pub fn elm_kernel_parser_chomp_base10(
  offset_original : Int64,
  string : StringString,
) -> Int64 {
  let mut offset : Int = Int64::to_int(offset_original)
  let str : String = string_string_to_string(string)
  the_loop~: for char_at_offset in str.view(start_offset=offset) {
    if char_at_offset < '0' || char_at_offset > '9' {
      break the_loop~
    } else {
      offset = offset + char_at_offset.utf16_len()
    }
  }
  Int::to_int64(offset)
}

///|
pub fn elm_kernel_parser_consume_base(
  base : Int64,
  offset_original : Int64,
  string : StringString,
) -> (Int64, Int64) {
  let mut offset : Int = Int64::to_int(offset_original)
  let str : String = string_string_to_string(string)
  let mut total : Int64 = 0
  the_loop~: for char_at_offset in str.view(start_offset=offset) {
    let digit : Int64 = Int::to_int64(
      Char::to_int(char_at_offset) - Char::to_int('0'),
    )
    if digit < 0 || digit >= base {
      break the_loop~
    } else {
      total = base * total + digit
      offset = offset + char_at_offset.utf16_len()
    }
  }
  (Int::to_int64(offset), total)
}

///|
pub fn elm_kernel_parser_consume_base16(
  offset_original : Int64,
  string : StringString,
) -> (Int64, Int64) {
  let mut offset : Int = Int64::to_int(offset_original)
  let str : String = string_string_to_string(string)
  let mut total : Int = 0
  the_loop~: for char_at_offset in str.view(start_offset=offset) {
    if char_at_offset >= '0' && char_at_offset <= '9' {
      total = 16 * total + Char::to_int(char_at_offset) - Char::to_int('0')
      offset = offset + char_at_offset.utf16_len()
    } else if char_at_offset >= 'A' && char_at_offset <= 'F' {
      total = 16 * total + 10 + Char::to_int(char_at_offset) - Char::to_int('A')
      offset = offset + char_at_offset.utf16_len()
    } else if char_at_offset >= 'a' && char_at_offset <= 'f' {
      total = 16 * total + 10 + Char::to_int(char_at_offset) - Char::to_int('a')
      offset = offset + char_at_offset.utf16_len()
    } else {
      break the_loop~
    }
  }
  (Int::to_int64(offset), Int::to_int64(total))
}

///|
pub fn elm_kernel_parser_find_sub_string(
  small_string : StringString,
  offset_original_i64 : Int64,
  row_original : Int64,
  col_original : Int64,
  big_string : StringString,
) -> (Int64, Int64, Int64) {
  let offset_original : Int = Int64::to_int(offset_original_i64)
  let big_str : String = string_string_to_string(big_string)
  let small_string_cow : String = string_string_to_string(small_string)
  match big_str.view(start_offset=offset_original).find(small_string_cow) {
    Option::None => (-1L, row_original, col_original)
    Option::Some(found_start_offset_from_offset) => {
      let mut row : Int = Int64::to_int(row_original)
      let mut col : Int = Int64::to_int(col_original)
      let found_start_index_in_big_string : Int = offset_original +
        found_start_offset_from_offset
      for
        char in big_str.view(
          start_offset=offset_original,
          end_offset=found_start_index_in_big_string,
        ) {
        if char == '\n' {
          col = 1
          row = row + 1
        } else {
          col = col + 1
        }
      }
      (
        Int::to_int64(found_start_index_in_big_string),
        Int::to_int64(row),
        Int::to_int64(col),
      )
    }
  }
}

///|
pub(all) enum BytesEndianness {
  LE
  BE
}

///|
pub fn bytes_width(bytes : Bytes) -> Int64 {
  Int::to_int64(Bytes::length(bytes))
}

///|
pub(all) enum BytesEncodeEncoder {
  I8(Byte)
  I16(BytesEndianness, Int16)
  I32(BytesEndianness, Int)
  U8(Byte)
  U16(BytesEndianness, UInt16)
  U32(BytesEndianness, UInt)
  F32(BytesEndianness, Float)
  F64(BytesEndianness, Double)
  Utf8(String)
  Bytes(Bytes)
  Seq(@list.List[BytesEncodeEncoder])
}

///|
pub fn basics_encode_encode(encoder : BytesEncodeEncoder) -> Bytes {
  let bytes_buffer : @buffer.Buffer = @buffer.new()
  loop (encoder, @list.empty()) {
    (BytesEncodeEncoder::U8(byte), remaining_encoders) => {
      @buffer.Buffer::write_byte(bytes_buffer, byte)
      match remaining_encoders {
        @list.List::Empty => break
        @list.List::More(next_encoder, tail=next_remaining_encoders) =>
          continue (next_encoder, next_remaining_encoders)
      }
    }
    (BytesEncodeEncoder::I8(byte), remaining_encoders) => {
      @buffer.Buffer::write_byte(bytes_buffer, byte)
      match remaining_encoders {
        @list.List::Empty => break
        @list.List::More(next_encoder, tail=next_remaining_encoders) =>
          continue (next_encoder, next_remaining_encoders)
      }
    }
    (BytesEncodeEncoder::U16(endianness, u16), remaining_encoders) => {
      buffer_write_uint16(bytes_buffer, endianness, u16)
      match remaining_encoders {
        @list.List::Empty => break
        @list.List::More(next_encoder, tail=next_remaining_encoders) =>
          continue (next_encoder, next_remaining_encoders)
      }
    }
    (BytesEncodeEncoder::I16(endianness, i16), remaining_encoders) => {
      // moonbit has no direct Int16 to bytes conversion which is weird
      buffer_write_uint16(
        bytes_buffer,
        endianness,
        Int16::reinterpret_as_uint16(i16),
      )
      match remaining_encoders {
        @list.List::Empty => break
        @list.List::More(next_encoder, tail=next_remaining_encoders) =>
          continue (next_encoder, next_remaining_encoders)
      }
    }
    (BytesEncodeEncoder::U32(endianness, u32), remaining_encoders) => {
      (match endianness {
        BytesEndianness::LE => @buffer.Buffer::write_uint_le
        BytesEndianness::BE => @buffer.Buffer::write_uint_be
      })(bytes_buffer, u32)
      match remaining_encoders {
        @list.List::Empty => break
        @list.List::More(next_encoder, tail=next_remaining_encoders) =>
          continue (next_encoder, next_remaining_encoders)
      }
    }
    (BytesEncodeEncoder::I32(endianness, i32), remaining_encoders) => {
      (match endianness {
        BytesEndianness::LE => @buffer.Buffer::write_int_le
        BytesEndianness::BE => @buffer.Buffer::write_int_be
      })(bytes_buffer, i32)
      match remaining_encoders {
        @list.List::Empty => break
        @list.List::More(next_encoder, tail=next_remaining_encoders) =>
          continue (next_encoder, next_remaining_encoders)
      }
    }
    (BytesEncodeEncoder::F32(endianness, f32), remaining_encoders) => {
      (match endianness {
        BytesEndianness::LE => @buffer.Buffer::write_float_le
        BytesEndianness::BE => @buffer.Buffer::write_float_be
      })(bytes_buffer, f32)
      match remaining_encoders {
        @list.List::Empty => break
        @list.List::More(next_encoder, tail=next_remaining_encoders) =>
          continue (next_encoder, next_remaining_encoders)
      }
    }
    (BytesEncodeEncoder::F64(endianness, f64), remaining_encoders) => {
      (match endianness {
        BytesEndianness::LE => @buffer.Buffer::write_double_le
        BytesEndianness::BE => @buffer.Buffer::write_double_be
      })(bytes_buffer, f64)
      match remaining_encoders {
        @list.List::Empty => break
        @list.List::More(next_encoder, tail=next_remaining_encoders) =>
          continue (next_encoder, next_remaining_encoders)
      }
    }
    (BytesEncodeEncoder::Bytes(bytes), remaining_encoders) => {
      @buffer.Buffer::write_bytes(bytes_buffer, bytes)
      match remaining_encoders {
        @list.List::Empty => break
        @list.List::More(next_encoder, tail=next_remaining_encoders) =>
          continue (next_encoder, next_remaining_encoders)
      }
    }
    (BytesEncodeEncoder::Utf8(string), remaining_encoders) => {
      @buffer.Buffer::write_string_utf8(bytes_buffer, string)
      match remaining_encoders {
        @list.List::Empty => break
        @list.List::More(next_encoder, tail=next_remaining_encoders) =>
          continue (next_encoder, next_remaining_encoders)
      }
    }
    (BytesEncodeEncoder::Seq(subs), remaining_encoders) =>
      match subs {
        @list.List::Empty =>
          match remaining_encoders {
            @list.List::Empty => break
            @list.List::More(next_encoder, tail=next_remaining_encoders) =>
              continue (next_encoder, next_remaining_encoders)
          }
        @list.List::More(next_encoder, tail=seq_remaining_encoders) =>
          continue (
              next_encoder,
              @list.List::concat(seq_remaining_encoders, remaining_encoders),
            )
      }
  }
  @buffer.Buffer::contents(bytes_buffer)
}

///|
fn buffer_write_uint16(
  bytes_buffer : @buffer.Buffer,
  endianness : BytesEndianness,
  u16 : UInt16,
) -> Unit {
  // moonbit has no direct UInt16 to bytes conversion which is weird
  match endianness {
    BytesEndianness::LE => {
      @buffer.Buffer::write_byte(bytes_buffer, UInt16::to_byte(u16))
      @buffer.Buffer::write_byte(bytes_buffer, UInt16::to_byte(u16 >> 8))
    }
    BytesEndianness::BE => {
      @buffer.Buffer::write_byte(bytes_buffer, UInt16::to_byte(u16 >> 8))
      @buffer.Buffer::write_byte(bytes_buffer, UInt16::to_byte(u16))
    }
  }
}

///|
pub fn bytes_encode_bytes(bytes : Bytes) -> BytesEncodeEncoder {
  BytesEncodeEncoder::Bytes(bytes)
}

///|
pub fn bytes_encode_unsigned_int8(int : Int64) -> BytesEncodeEncoder {
  BytesEncodeEncoder::U8(Int64::to_byte(int))
}

///|
pub fn bytes_encode_signed_int8(int : Int64) -> BytesEncodeEncoder {
  BytesEncodeEncoder::U8(UInt16::to_byte(Int64::to_uint16(int)))
}

///|
pub fn bytes_encode_unsigned_int16(
  endianness : BytesEndianness,
  int : Int64,
) -> BytesEncodeEncoder {
  BytesEncodeEncoder::U16(endianness, Int64::to_uint16(int))
}

///|
pub fn bytes_encode_signed_int16(
  endianness : BytesEndianness,
  int : Int64,
) -> BytesEncodeEncoder {
  BytesEncodeEncoder::I16(endianness, Int64::to_int16(int))
}

///|
pub fn bytes_encode_unsigned_int32(
  endianness : BytesEndianness,
  int : Int64,
) -> BytesEncodeEncoder {
  BytesEncodeEncoder::U32(
    endianness,
    // moonbit has no direct Int64 to UInt conversion which is weird
    BigInt::to_uint(BigInt::from_int64(int)),
  )
}

///|
pub fn bytes_encode_signed_int32(
  endianness : BytesEndianness,
  int : Int64,
) -> BytesEncodeEncoder {
  BytesEncodeEncoder::I32(endianness, Int64::to_int(int))
}

///|
pub fn bytes_encode_signed_float32(
  endianness : BytesEndianness,
  double : Double,
) -> BytesEncodeEncoder {
  BytesEncodeEncoder::F32(endianness, Double::to_float(double))
}

///|
pub fn bytes_encode_signed_float64(
  endianness : BytesEndianness,
  double : Double,
) -> BytesEncodeEncoder {
  BytesEncodeEncoder::F64(endianness, double)
}

///|
pub fn bytes_encode_get_string_width(string : StringString) -> Int64 {
  string
  |> string_string_to_string
  |> @encoding/utf8.encode
  |> Bytes::length
  |> Int::to_int64
}

///|
pub fn bytes_encode_string(string : StringString) -> BytesEncodeEncoder {
  BytesEncodeEncoder::Utf8(string_string_to_string(string))
}

///|
pub fn bytes_encode_sequence(
  encoders : @list.List[BytesEncodeEncoder],
) -> BytesEncodeEncoder {
  BytesEncodeEncoder::Seq(encoders)
}

///|
pub(all) struct BytesDecodeDecoder[A] {
  decode : (Int, BytesView) -> BytesDecodeSuccess[A]?
}

///|
pub(all) struct BytesDecodeSuccess[A] {
  index_after : Int
  result : A
}

///|
pub fn[A] bytes_decode_decode(
  decoder : BytesDecodeDecoder[A],
  bytes : Bytes,
) -> A? {
  match (decoder.decode)(0, bytes) {
    Option::None => Option::None
    Option::Some({ index_after: _, result }) => Option::Some(result)
  }
}

///|
pub fn[A] bytes_decode_fail() -> BytesDecodeDecoder[A] {
  BytesDecodeDecoder::{ decode: fn(_index, _bytes) { Option::None } }
}

///|
pub fn[A] bytes_decode_succeed(result : A) -> BytesDecodeDecoder[A] {
  BytesDecodeDecoder::{
    decode: fn(index, _bytes) {
      Option::Some(BytesDecodeSuccess::{ index_after: index, result })
    },
  }
}

///|
pub fn[A, B] bytes_decode_and_then(
  followup : (A) -> BytesDecodeDecoder[B],
  decoder : BytesDecodeDecoder[A],
) -> BytesDecodeDecoder[B] {
  BytesDecodeDecoder::{
    decode: fn(index, bytes) {
      (decoder.decode)(index, bytes)
      |> Option::bind(fn(decoded) {
        (followup(decoded.result).decode)(decoded.index_after, bytes)
      })
    },
  }
}

///|
pub fn[A, B] bytes_decode_map(
  result_change : (A) -> B,
  decoder : BytesDecodeDecoder[A],
) -> BytesDecodeDecoder[B] {
  BytesDecodeDecoder::{
    decode: fn(index, bytes) {
      (decoder.decode)(index, bytes)
      |> Option::map(fn(decoded) {
        BytesDecodeSuccess::{
          index_after: decoded.index_after,
          result: result_change(decoded.result),
        }
      })
    },
  }
}

///|
pub fn[A, B, Combined] bytes_decode_map2(
  combine : (A, B) -> Combined,
  a_decoder : BytesDecodeDecoder[A],
  b_decoder : BytesDecodeDecoder[B],
) -> BytesDecodeDecoder[Combined] {
  BytesDecodeDecoder::{
    decode: fn(index, bytes) {
      (a_decoder.decode)(index, bytes)
      |> Option::bind(fn(a) {
        (b_decoder.decode)(a.index_after, bytes)
        |> Option::map(fn(b) {
          BytesDecodeSuccess::{
            index_after: b.index_after,
            result: combine(a.result, b.result),
          }
        })
      })
    },
  }
}

///|
pub fn[A, B, C, Combined] bytes_decode_map3(
  combine : (A, B, C) -> Combined,
  a_decoder : BytesDecodeDecoder[A],
  b_decoder : BytesDecodeDecoder[B],
  c_decoder : BytesDecodeDecoder[C],
) -> BytesDecodeDecoder[Combined] {
  BytesDecodeDecoder::{
    decode: fn(index, bytes) {
      (a_decoder.decode)(index, bytes)
      |> Option::bind(fn(a) {
        (b_decoder.decode)(a.index_after, bytes)
        |> Option::bind(fn(b) {
          (c_decoder.decode)(b.index_after, bytes)
          |> Option::map(fn(c) {
            BytesDecodeSuccess::{
              index_after: b.index_after,
              result: combine(a.result, b.result, c.result),
            }
          })
        })
      })
    },
  }
}

///|
pub fn[A, B, C, D, Combined] bytes_decode_map4(
  combine : (A, B, C, D) -> Combined,
  a_decoder : BytesDecodeDecoder[A],
  b_decoder : BytesDecodeDecoder[B],
  c_decoder : BytesDecodeDecoder[C],
  d_decoder : BytesDecodeDecoder[D],
) -> BytesDecodeDecoder[Combined] {
  BytesDecodeDecoder::{
    decode: fn(index, bytes) {
      (a_decoder.decode)(index, bytes)
      |> Option::bind(fn(a) {
        (b_decoder.decode)(a.index_after, bytes)
        |> Option::bind(fn(b) {
          (c_decoder.decode)(b.index_after, bytes)
          |> Option::bind(fn(c) {
            (d_decoder.decode)(c.index_after, bytes)
            |> Option::map(fn(d) {
              BytesDecodeSuccess::{
                index_after: b.index_after,
                result: combine(a.result, b.result, c.result, d.result),
              }
            })
          })
        })
      })
    },
  }
}

///|
pub fn[A, B, C, D, E, Combined] bytes_decode_map5(
  combine : (A, B, C, D, E) -> Combined,
  a_decoder : BytesDecodeDecoder[A],
  b_decoder : BytesDecodeDecoder[B],
  c_decoder : BytesDecodeDecoder[C],
  d_decoder : BytesDecodeDecoder[D],
  e_decoder : BytesDecodeDecoder[E],
) -> BytesDecodeDecoder[Combined] {
  BytesDecodeDecoder::{
    decode: fn(index, bytes) {
      (a_decoder.decode)(index, bytes)
      |> Option::bind(fn(a) {
        (b_decoder.decode)(a.index_after, bytes)
        |> Option::bind(fn(b) {
          (c_decoder.decode)(b.index_after, bytes)
          |> Option::bind(fn(c) {
            (d_decoder.decode)(c.index_after, bytes)
            |> Option::bind(fn(d) {
              (e_decoder.decode)(d.index_after, bytes)
              |> Option::map(fn(e) {
                BytesDecodeSuccess::{
                  index_after: b.index_after,
                  result: combine(
                    a.result,
                    b.result,
                    c.result,
                    d.result,
                    e.result,
                  ),
                }
              })
            })
          })
        })
      })
    },
  }
}

///|
pub(all) enum BytesDecodeStep[State, Result] {
  Loop(State)
  Done(Result)
}

///|
pub fn[State, Result] bytes_decode_loop(
  initial_state : State,
  step : (State) -> BytesDecodeDecoder[BytesDecodeStep[State, Result]],
) -> BytesDecodeDecoder[Result] {
  BytesDecodeDecoder::{
    decode: fn(index, bytes) {
      bytes_decode_loop_from(initial_state, index, bytes, step)
    },
  }
}

///|
fn[State, Result] bytes_decode_loop_from(
  state : State,
  index : Int,
  bytes : BytesView,
  step : (State) -> BytesDecodeDecoder[BytesDecodeStep[State, Result]],
) -> BytesDecodeSuccess[Result]? {
  match (step(state).decode)(index, bytes) {
    Option::None => Option::None
    Option::Some(step_decode_result) =>
      match step_decode_result.result {
        BytesDecodeStep::Loop(next_state) =>
          bytes_decode_loop_from(
            next_state,
            step_decode_result.index_after,
            bytes,
            step,
          )
        BytesDecodeStep::Done(result) =>
          Option::Some(BytesDecodeSuccess::{
            index_after: step_decode_result.index_after,
            result,
          })
      }
  }
}

///|
pub(all) enum RandomSeed {
  Seed(Int64, Int64)
} derive(Eq, Show)

///|
pub(all) struct RandomGenerator[A] {
  generate : (RandomSeed) -> (A, RandomSeed)
}

///|
pub let random_min_int : Int64 = -2147483648L

///|
pub let random_max_int : Int64 = 2147483647L

///|
pub fn[A] random_step(
  generator : RandomGenerator[A],
  seed : RandomSeed,
) -> (A, RandomSeed) {
  (generator.generate)(seed)
}

///|
pub fn random_peel(seed : RandomSeed) -> Int64 {
  let RandomSeed::Seed(state, _) = seed
  let word : Int64 = bitwise_xor(
      state,
      bitwise_shift_right_zf_by(
        bitwise_shift_right_zf_by(28L, state) + 4L,
        state,
      ),
    ) *
    277803737L
  bitwise_shift_right_zf_by(
    0L,
    bitwise_xor(bitwise_shift_right_zf_by(22L, word), word),
  )
}

///|
pub fn random_next(seed : RandomSeed) -> RandomSeed {
  let RandomSeed::Seed(state0, incr) = seed
  RandomSeed::Seed(
    bitwise_shift_right_zf_by(0L, state0 * 1664525L + incr),
    incr,
  )
}

///|
pub fn random_initial_seed(x : Int64) -> RandomSeed {
  let RandomSeed::Seed(state1, incr) = random_next(
    RandomSeed::Seed(0L, 1013904223L),
  )
  let state2 : Int64 = bitwise_shift_right_zf_by(0L, state1 + x)
  random_next(RandomSeed::Seed(state2, incr))
}

///|
pub let random_independent_seed : RandomGenerator[RandomSeed] = RandomGenerator::{
  generate: fn(seed0 : RandomSeed) {
    fn make_independent_seed(
      state : Int64,
      b : Int64,
      c : Int64,
    ) -> RandomSeed {
      random_next(
        RandomSeed::Seed(
          state,
          bitwise_shift_right_zf_by(0L, bitwise_or(1L, bitwise_xor(b, c))),
        ),
      )
    }

    let gen : RandomGenerator[Int64] = random_int(0L, 4294967295L)
    random_step(random_map3(make_independent_seed, gen, gen, gen), seed0)
  },
}

///|
pub fn[A] random_constant(value : A) -> RandomGenerator[A] {
  RandomGenerator::{ generate: fn(seed : RandomSeed) { (value, seed) } }
}

///|
pub fn[A, B] random_and_then(
  followup_generator : (A) -> RandomGenerator[B],
  generator : RandomGenerator[A],
) -> RandomGenerator[B] {
  RandomGenerator::{
    generate: fn(seed : RandomSeed) {
      let (result, new_seed) = (generator.generate)(seed)
      (followup_generator(result).generate)(new_seed)
    },
  }
}

///|
pub fn[A] random_lazy(
  construct_generator : (Unit) -> RandomGenerator[A],
) -> RandomGenerator[A] {
  RandomGenerator::{
    generate: fn(seed : RandomSeed) { (construct_generator(()).generate)(seed) },
  }
}

///|
pub fn[A, B] random_pair(
  first_generator : RandomGenerator[A],
  second_generator : RandomGenerator[B],
) -> RandomGenerator[(A, B)] {
  random_map2(fn(a : A, b : B) { (a, b) }, first_generator, second_generator)
}

///|
pub fn[A, B] random_map(
  value_change : (A) -> B,
  generator : RandomGenerator[A],
) -> RandomGenerator[B] {
  RandomGenerator::{
    generate: fn(seed0 : RandomSeed) {
      let (a, seed1) = (generator.generate)(seed0)
      (value_change(a), seed1)
    },
  }
}

///|
pub fn[A, B, Combined] random_map2(
  combine : (A, B) -> Combined,
  a_generator : RandomGenerator[A],
  b_geenrator : RandomGenerator[B],
) -> RandomGenerator[Combined] {
  RandomGenerator::{
    generate: fn(seed0 : RandomSeed) {
      let (a, seed1) = (a_generator.generate)(seed0)
      let (b, seed2) = (b_geenrator.generate)(seed1)
      (combine(a, b), seed2)
    },
  }
}

///|
pub fn[A, B, C, Combined] random_map3(
  combine : (A, B, C) -> Combined,
  a_generator : RandomGenerator[A],
  b_geenrator : RandomGenerator[B],
  c_generator : RandomGenerator[C],
) -> RandomGenerator[Combined] {
  RandomGenerator::{
    generate: fn(seed0 : RandomSeed) {
      let (a, seed1) = (a_generator.generate)(seed0)
      let (b, seed2) = (b_geenrator.generate)(seed1)
      let (c, seed3) = (c_generator.generate)(seed2)
      (combine(a, b, c), seed3)
    },
  }
}

///|
pub fn[A, B, C, D, Combined] random_map4(
  combine : (A, B, C, D) -> Combined,
  a_generator : RandomGenerator[A],
  b_geenrator : RandomGenerator[B],
  c_generator : RandomGenerator[C],
  d_generator : RandomGenerator[D],
) -> RandomGenerator[Combined] {
  RandomGenerator::{
    generate: fn(seed0 : RandomSeed) {
      let (a, seed1) = (a_generator.generate)(seed0)
      let (b, seed2) = (b_geenrator.generate)(seed1)
      let (c, seed3) = (c_generator.generate)(seed2)
      let (d, seed4) = (d_generator.generate)(seed3)
      (combine(a, b, c, d), seed4)
    },
  }
}

///|
pub fn[A, B, C, D, E, Combined] random_map5(
  combine : (A, B, C, D, E) -> Combined,
  a_generator : RandomGenerator[A],
  b_geenrator : RandomGenerator[B],
  c_generator : RandomGenerator[C],
  d_generator : RandomGenerator[D],
  e_generator : RandomGenerator[E],
) -> RandomGenerator[Combined] {
  RandomGenerator::{
    generate: fn(seed0 : RandomSeed) {
      let (a, seed1) = (a_generator.generate)(seed0)
      let (b, seed2) = (b_geenrator.generate)(seed1)
      let (c, seed3) = (c_generator.generate)(seed2)
      let (d, seed4) = (d_generator.generate)(seed3)
      let (e, seed5) = (e_generator.generate)(seed4)
      (combine(a, b, c, d, e), seed5)
    },
  }
}

///|
pub fn[A] random_uniform(
  first : A,
  others : @list.List[A],
) -> RandomGenerator[A] {
  random_weighted((1.0, first), @list.List::map(others, fn(v) { (1.0, v) }))
}

///|
pub fn[A] random_weighted(
  first : (Double, A),
  others : @list.List[(Double, A)],
) -> RandomGenerator[A] {
  fn normalize(weighted : (Double, _)) -> Double {
    let (weight, _) = weighted
    Double::abs(weight)
  }

  let total : Double = normalize(first) +
    others.iter().map(normalize).fold(init=0.0, Double::add)
  random_map(
    fn(generated_float : Double) {
      random_get_by_weight(first, others, generated_float)
    },
    random_float(0.0, total),
  )
}

///|
pub fn[A] random_get_by_weight(
  first : (Double, A),
  others : @list.List[(Double, A)],
  countdown : Double,
) -> A {
  let (first_weight, first_value) = first
  match others {
    @list.List::Empty => first_value
    @list.List::More(second, tail=other_others) =>
      if countdown <= Double::abs(first_weight) {
        first_value
      } else {
        random_get_by_weight(
          second,
          other_others,
          countdown - Double::abs(first_weight),
        )
      }
  }
}

///|
pub fn[A] random_list(
  length : Int64,
  element_generator : RandomGenerator[A],
) -> RandomGenerator[@list.List[A]] {
  RandomGenerator::{
    generate: fn(seed : RandomSeed) {
      random_list_help(@list.empty(), length, element_generator.generate, seed)
    },
  }
}

///|
pub fn[A] random_list_help(
  reverse_list : @list.List[A],
  length : Int64,
  generate : (RandomSeed) -> (A, RandomSeed),
  seed : RandomSeed,
) -> (@list.List[A], RandomSeed) {
  if length < 1L {
    (reverse_list, seed)
  } else {
    let (value, new_seed) = generate(seed)
    random_list_help(
      list_cons(value, reverse_list),
      length - 1L,
      generate,
      new_seed,
    )
  }
}

///|
pub fn random_int(a : Int64, b : Int64) -> RandomGenerator[Int64] {
  RandomGenerator::{
    generate: fn(seed0 : RandomSeed) {
      let (lo, hi) = if a < b { (a, b) } else { (b, a) }
      let range : Int64 = hi - lo + 1L
      if bitwise_and(range - 1L, range) == 0L {
        (
          bitwise_shift_right_zf_by(
            0L,
            bitwise_and(range - 1L, random_peel(seed0)),
          ) +
          lo,
          random_next(seed0),
        )
      } else {
        let threshold : Int64 = bitwise_shift_right_zf_by(
          0L,
          basics_remainder_by(range, bitwise_shift_right_zf_by(0L, -range)),
        )
        fn account_for_bias(
          lo : Int64,
          range : Int64,
          threshold : Int64,
          seed : RandomSeed,
        ) -> (Int64, RandomSeed) {
          let x : Int64 = random_peel(seed)
          let seed_n : RandomSeed = random_next(seed)
          if x < threshold {
            account_for_bias(lo, range, threshold, seed_n)
          } else {
            (basics_remainder_by(range, x) + lo, seed_n)
          }
        }

        account_for_bias(lo, range, threshold, seed0)
      }
    },
  }
}

///|
pub fn random_float(a : Double, b : Double) -> RandomGenerator[Double] {
  RandomGenerator::{
    generate: fn(seed0 : RandomSeed) {
      let seed1 : RandomSeed = random_next(seed0)
      let range : Double = Double::abs(b - a)
      let n1 : Int64 = random_peel(seed1)
      let n0 : Int64 = random_peel(seed0)
      let lo : Double = Int64::to_double(bitwise_and(134217727L, n1))
      let hi : Double = Int64::to_double(bitwise_and(67108863L, n0))
      let val : Double = (hi * 134217728.0 + lo) / 9007199254740992.0
      let scaled : Double = val * range + a
      (scaled, random_next(seed1))
    },
  }
}
