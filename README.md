> Status: somewhat simple programs only relying on elm/core are likely to succeed, others will probably fail.

Print [`elm-syntax`](https://dark.elm.dmy.fr/packages/stil4m/elm-syntax/latest/) declarations as [moonbit](https://docs.moonbitlang.com/en/latest/index.html) code.
To try it out, you can
run [this script](https://github.com/lue-bird/elm-syntax-to-moonbit/tree/main/node-elm-to-moonbit).

```elm
import Elm.Parser
import ElmSyntaxToMoonbit

"""module Sample exposing (..)

plus2 : Float -> Float
plus2 n =
    n + ([ 2.0 ] |> List.sum)
"""
    |> Elm.Parser.parseToFile
    |> Result.mapError (\_ -> "failed to parse elm source code")
    |> Result.map
        (\syntaxModule ->
            [ syntaxModule ]
                |> ElmSyntaxToMoonbit.modules
                |> .declarations
                |> ElmSyntaxToMoonbit.moonbitDeclarationsToModuleString
        )
-->
Ok """...
pub fn sample_plus2(n: Double) -> Double {
    basics_add(n, list_sum_float(@list.of([2.0])))
}
"""
```

### be aware

- not supported are
    - ports that use non-json values like `port sendMessage : String -> Cmd msg`, glsl, phantom types, `==` on a generic value
    - `elm/file`, `elm/http`, `elm/browser`, `elm-explorations/markdown`, `elm-explorations/webgl`, `elm-explorations/benchmark`, `elm/regex`, `elm-explorations/linear-algebra` (TODO currently also most other non elm/core packages!)
    - `Task`, `Process`, `Platform.Task`, `Platform.ProcessId`, `Platform.Router`, `Platform.sendToApp`, `Platform.sendToSelf`, `Random.generate`, `Time.now`, `Time.every`, `Time.here`, `Time.getZoneName`, `Bytes.getHostEndianness`
    - extensible record types outside of module-level value/function declarations. For example, these declarations might not work:
        ```elm
        -- in variant value
        type Named rec = Named { rec | name : String }
        -- in let type, annotated or not
        let getName : { r | name : name } -> name
        ```
        Allowed is only record extension in module-level value/functions, annotated or not:
        ```elm
        userId : { u | name : String, server : Domain } -> String
        ```
        In the non-allowed cases listed above, we assume that you intended to use a regular record type with only the extension fields which can lead to moonbit compile errors if you actually pass in additional fields.
    - elm's `Char.toLocale[Case]` functions will just behave like `Char.to[Case]`
    - elm's `VirtualDom/Html/Svg.lazyN` functions will still exist for compatibility but they will behave just like constructing them eagerly
- dependencies cannot internally use the same module names as the transpiled project
- the resulting code might not be readable or even conventionally formatted and comments are not preserved

Please [report any issues](https://github.com/lue-bird/elm-syntax-to-moonbit/issues/new) you notice <3

### why moonbit?

- it has first-class support for wasm (and native)
- it feels like a superset of elm which makes transpiling and "ffi" easier
- it supposedly has fast compile times (I have yet to verify this claim)

### why not moonbit?

- the language is bloated
- the language is very young and tooling like the build CLI are fragile
- the language's promotion has made overly big claims and has the classic AI bullshit
- the ecosystem is tiny so you will likely need to write your own FFI wrappers and similar

### how do I use the transpiled output?

An example can be found in [`example-hello-world/`](https://github.com/lue-bird/elm-syntax-to-moonbit/tree/main/example-hello-world).

In your elm project, add `moon.pkg.json`
```json
{"is-main": true}
```
and `moon.mod.json`
```json
{"name": "your_project_name"}
```
(If you know of a simpler setup, please [open an issue](https://github.com/lue-bird/elm-syntax-to-moonbit/issues/new))

and a file `main.mbt` that uses `elm.mbt`:

```moonbit
mod elm
print(your_module_your_function("yourInput"))
```

where `your_module_your_function(firstArgument, secondArgument)` is the transpiled elm function `Your.Module.yourFunction firstArgument secondArgument`. (If the value/function contains extensible records, search for `your_module_your_function_` with the underscore to see the different specialized options)

Run with
```bash
cargo run
```

If something unexpected happened,
please [report an issue](https://github.com/lue-bird/elm-syntax-to-moonbit/issues/new).

In the transpiled code, you will find these types:

- elm `Bool` (`True` or `False`) → moonbit `Bool` (`true` or `false`), `Char` (`'a'`) → `Char` (`'a'`), `( Bool, Char )` → `( Bool, Char )`
- elm `Int`s will be of type `Int64`. Create and match by appending `L` to any number literal or using `Int::to_int64`/`Int64::from_int`
- elm `Float`s will be of type `f64`. Create and match by using any number literal with a decimal point
- elm `String`s (like `"a"`) will be of the custom type `StringString`.
  Create from literals or other string slices with (`StringString::One("a")`). Match with `your_string if string_equals_str(your_string, "some string")`
- elm `Array`s (like `Array.fromList [ 'a' ]`) will be of type `@immut.array.Array`.
  Create and match with the helpers in `@immut.array`
- elm records like `{ y : Float, x : Float }` will be of type `GeneratedXY<f64, f64>` with the fields sorted and can be constructed and matched with `{ x: _, y: _ }`. `record.x` access also works
- a transpiled elm app does not run itself.
  An elm main `Platform.worker` program type will literally just consist of fields `init`, `update` and `subscriptions` where
  subscriptions/commands are returned as a list of `PlatformSubSingle`/`PlatformCmdSingle` with possible elm subscriptions/commands in a choice type.
  It's then your responsibility as "the platform" to perform effects, create events and manage the state. For an example see [example-worker-blocking/](https://github.com/lue-bird/elm-syntax-to-moonbit/tree/main/example-worker-blocking) & [example-worker-concurrent/](https://github.com/lue-bird/elm-syntax-to-moonbit/tree/main/example-worker-concurrent)

### improvement ideas

- try and benchmark switching `String` representation from `One &str | Append String String` to `(StringBuilder) -> StringBuilder`
- if lambda is called with a function, always inline that function
- your idea 👀
