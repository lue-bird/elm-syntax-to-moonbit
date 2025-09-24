///|
typealias @html.Html

///|
enum FullEvent[ElmEvent] {
  EventJsonDecodeFailed(JsonDecodeError)
  ElmEvent(ElmEvent)
}

///|
fn main {
  @tea.startup(model=main_initial_state(()), update~, view~)
}

///|
fn update(
  event : FullEvent[MainEvent],
  state : MainState,
) -> (@tea.Cmd[FullEvent[MainEvent]], MainState) {
  match event {
    EventJsonDecodeFailed(json_decode_error) => {
      println(json_decode_error)
      (@tea.none(), state)
    }
    ElmEvent(elm_event) => (@tea.none(), main_update(elm_event, state))
  }
}

///|
fn view(state : MainState) -> Html[FullEvent[MainEvent]] {
  elm_virtual_dom_node_to_tea_html(main_view(state))
}

//

///|
fn[ElmEvent] elm_virtual_dom_node_to_tea_html(
  elm_virtual_dom_node : VirtualDomNode[ElmEvent],
) -> Html[FullEvent[ElmEvent]] {
  match elm_virtual_dom_node {
    VirtualDomNode::Text(text) => @html.text(text)
    VirtualDomNode::Element(tag~, namespace_~, subs~, modifiers~) =>
      @html.node(
        tag,
        namespace_
        |> Option::map(fn(xmlns) { @html.attribute("xmlns", xmlns) })
        |> Option::iter
        |> Iter::concat(
          modifiers
          |> @list.List::iter
          |> Iter::map(elm_virtual_dom_modifier_to_tea_attribute),
        )
        |> Iter::to_array,
        subs
        |> @list.List::iter
        |> Iter::map(elm_virtual_dom_node_to_tea_html)
        |> Iter::to_array,
      )
    VirtualDomNode::ElementKeyed(tag~, namespace_~, subs~, modifiers~) =>
      @html.node(
        tag,
        namespace_
        |> Option::map(fn(xmlns) { @html.attribute("xmlns", xmlns) })
        |> Option::iter
        |> Iter::concat(
          modifiers
          |> @list.List::iter
          |> Iter::map(elm_virtual_dom_modifier_to_tea_attribute),
        )
        |> Iter::to_array,
        subs
        |> @list.List::iter
        |> Iter::map(fn(keyed_node) {
          elm_virtual_dom_node_to_tea_html(keyed_node.1)
        })
        |> Iter::to_array,
      )
  }
}

///|
fn[ElmEvent] elm_virtual_dom_modifier_to_tea_attribute(
  elm_virtual_dom_modifier : VirtualDomAttribute[ElmEvent],
) -> @html.Attribute[FullEvent[ElmEvent]] {
  match elm_virtual_dom_modifier {
    VirtualDomAttribute::ModifierProperty(key~, value~) => {
      let value_as_maybe_tea_property_value_variant : @variant.Variant? = match
        value {
        Json::True => Option::Some(@variant.Variant::Boolean(true))
        Json::False => Option::Some(@variant.Variant::Boolean(false))
        Json::Number(number_value, repr=_) => {
          let int_value : Int = Double::to_int(number_value)
          Option::Some(
            if Int::to_double(int_value) == number_value {
              @variant.Variant::Integer(int_value)
            } else {
              @variant.Variant::Floating(number_value)
            },
          )
        }
        Json::String(string_value) =>
          Option::Some(@variant.Variant::String(string_value))
        Json::Null | Json::Array(_) | Json::Object(_) => Option::None
      }
      match value_as_maybe_tea_property_value_variant {
        Option::None => tea_attribute_none()
        Option::Some(value_as_tea_property_value_variant) =>
          @html.property(key, value_as_tea_property_value_variant)
      }
    }
    VirtualDomAttribute::ModifierStyle(key~, value~) => @html.style(key, value)
    VirtualDomAttribute::ModifierAttribute(key~, namespace_=_, value~) =>
      @html.attribute(key, value)
    VirtualDomAttribute::ModifierEventListener(name~, handler~) =>
      match name {
        "mousemove" =>
          @html.on_mouse_move(fn(mouse_event) {
            match
              json_decode_decode_value(
                handler_to_decoder(handler),
                tea_mouse_event_to_json(mouse_event),
              ) {
              Result::Err(json_decode_error) =>
                EventJsonDecodeFailed(json_decode_error)
              Result::Ok(event) => ElmEvent(event)
            }
          })
        "click" =>
          @html.on_click(fn(mouse_event) {
            match
              json_decode_decode_value(
                handler_to_decoder(handler),
                tea_mouse_event_to_json(mouse_event),
              ) {
              Result::Err(json_decode_error) =>
                EventJsonDecodeFailed(json_decode_error)
              Result::Ok(event) => ElmEvent(event)
            }
          })
        unimplemented_event_name => {
          println(
            "event handler for \{unimplemented_event_name} not implemented",
          )
          tea_attribute_none()
        }
      }
  }
}

///|
fn tea_mouse_event_to_json(mouse_event : @html.Mouse) -> Json {
  Json::object(
    Map::of([
      ("clientX", Int::to_json(mouse_event.client_pos().x)),
      ("clientY", Int::to_json(mouse_event.client_pos().y)),
      ("offsetX", Int::to_json(mouse_event.offset_pos().x)),
      ("offsetY", Int::to_json(mouse_event.offset_pos().y)),
      ("screenX", Int::to_json(mouse_event.screen_pos().x)),
      ("screenY", Int::to_json(mouse_event.screen_pos().y)),
    ]),
  )
}

///|
fn[Event] handler_to_decoder(
  handler : VirtualDomHandler[Event],
) -> JsonDecodeDecoder[Event] {
  match handler {
    VirtualDomHandler::Custom(decoder) =>
      json_decode_map(
        (res : GeneratedMessagePreventDefaultStopPropagation[Event, Bool, Bool]) => res.message,
        decoder,
      )
    VirtualDomHandler::MayStopPropagation(decoder) =>
      json_decode_map(fn(res : (Event, Bool)) { res.0 }, decoder)
    VirtualDomHandler::Normal(decoder) => decoder
    VirtualDomHandler::MayPreventDefault(decoder) =>
      json_decode_map(fn(res : (Event, Bool)) { res.0 }, decoder)
  }
}

///|
pub fn[Event] tea_attribute_none() -> @html.Attribute[Event] {
  @html.attribute("class", "")
}
