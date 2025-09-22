///|
fn main {
  match (try? main_err()) {
    Ok(_) => ()
    Err(e) => println(e)
  }
}

///|
fn main_err() -> Unit raise {
  let sdl3_context : @sdl3.Context = @sdl3.Context::new()
  let elm_initialized = main_init_window
  let mut current_elm_state = elm_initialized.state
  let window = @sdl3.Context::createWindow(
    sdl3_context,
    string_string_to_string(elm_initialized.window_title),
    width=Int64::to_int(elm_initialized.window_width),
    height=Int64::to_int(elm_initialized.window_height),
  )
  let renderer = @sdl3.Window::createRenderer(window)
  let timer = @sdl3.Context::getTimer(sdl3_context)
  main_loop~: for {
    let events = @sdl3.Context::getEvents(sdl3_context)
    handling_interfaces~: for
      interface in main_state_to_interface(current_elm_state) {
      match interface {
        InterfaceQuit => break main_loop~
        InterfaceOnSimulationTick(construct_new_state) => {
          current_elm_state = construct_new_state(())
          break handling_interfaces~
        }
        InterfaceOnQuit(construct_new_state_on_quit) =>
          if events.iter().any(e => e.getType() is Quit) {
            // TODO remove next line
            current_elm_state = construct_new_state_on_quit(())
            break handling_interfaces~
          }
        InterfaceRender(render) => {
          @sdl3.Renderer::setDrawColor(
            renderer,
            elm_color_to_sdl3(render.clear_color),
          )
          @sdl3.Renderer::clear(renderer)
          for render_element in render.elements {
            match render_element {
              MainElementToRender::FilledRectangleToRender(filled_rectangle) => {
                @sdl3.Renderer::setDrawColor(
                  renderer,
                  elm_color_to_sdl3(filled_rectangle.color),
                )
                let rect = @sdl3.Context::createRect(
                  sdl3_context,
                  anchor=(filled_rectangle.left, filled_rectangle.top),
                  width=filled_rectangle.width,
                  height=filled_rectangle.height,
                )
                // fillRect does not appear to be ported yet, so an outline will have to do
                @sdl3.Renderer::drawRect(renderer, rect)
              }
            }
            @sdl3.Renderer::present(renderer)
          }
        }
      }
    }
    timer.delay(16)
  }
  @sdl3.Context::quit(sdl3_context)
}

///|
fn elm_color_to_sdl3(elm_color : ColorColor) -> @sdl3.Color {
  let colorComponents = color_to_rgba(elm_color)
  @sdl3.Color::RGB(
    Double::to_int(colorComponents.red * 255),
    Double::to_int(colorComponents.green * 255),
    Double::to_int(colorComponents.blue * 255),
    //double_to_byte(colorComponents.alpha * 255),
  )
}

///|
fn double_to_byte(double : Double) -> Byte {
  Int::to_byte(Double::to_int(double))
}
