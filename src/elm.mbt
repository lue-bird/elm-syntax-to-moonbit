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
pub typealias Result[Ok, Err] as ResultResult[Err, Ok]

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
  match String::get_char(as_string, 0) {
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
  initial_state : State,
  reduce : (Char, State) -> State,
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
  initial_state : State,
  reduce : (Char, State) -> State,
  string : StringString,
) -> State {
  String::rev_fold(string_string_to_string(string), init=initial_state, fn(
    so_far,
    char,
  ) {
    reduce(char, so_far)
  })
}
