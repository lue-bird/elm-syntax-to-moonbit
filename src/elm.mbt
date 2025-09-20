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
  element_compare : (A) -> (A) -> BasicsOrder,
  list : @list.List[A],
) -> @list.List[A] {
  let as_array : Array[A] = @list.List::to_array(list)
  Array::sort_by(as_array, fn(a, b) {
    basics_order_to_int(element_compare(a)(b))
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
  reduce : (A) -> (State) -> State,
  initial_state : State,
  list : @list.List[A],
) -> State {
  @list.List::fold(list, init=initial_state, fn(state, element) {
    reduce(element)(state)
  })
}

///|
pub fn[A, State] list_foldr(
  reduce : (A) -> (State) -> State,
  initial_state : State,
  list : @list.List[A],
) -> State {
  Array::rev_fold(@list.List::to_array(list), init=initial_state, fn(
    state,
    element,
  ) {
    reduce(element)(state)
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
  element_change : (Int64) -> (A) -> B,
  list : @list.List[A],
) -> @list.List[B] {
  @list.List::mapi(list, fn(index, element) {
    element_change(Int::to_int64(index))(element)
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
  elements_combine : (A) -> (B) -> Combined,
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
        combined_array.push(elements_combine(a_head)(b_head))
      }
      (@list.List::Empty, _) | (_, @list.List::Empty) => break
    }
  }
  @list.from_array(combined_array)
}

///|
pub fn[A, B, C, Combined] list_map3(
  elements_combine : (A) -> (B) -> (C) -> Combined,
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
        combined_array.push(elements_combine(a_head)(b_head)(c_head))
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
  elements_combine : (A) -> (B) -> (C) -> (D) -> Combined,
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
        combined_array.push(elements_combine(a_head)(b_head)(c_head)(d_head))
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
  elements_combine : (A) -> (B) -> (C) -> (D) -> (E) -> Combined,
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
          elements_combine(a_head)(b_head)(c_head)(d_head)(e_head),
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
pub(all) enum StringString {
  One(String)
  Append(StringString, StringString)
} derive(Show, Eq)

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
pub fn string_to_lower(string : StringString) -> StringString {
  StringString::One(String::to_lower(string_string_to_string(string)))
}

///|
pub fn string_to_upper(string : StringString) -> StringString {
  StringString::One(String::to_upper(string_string_to_string(string)))
}
