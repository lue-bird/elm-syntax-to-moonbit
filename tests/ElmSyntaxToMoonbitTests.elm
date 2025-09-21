module ElmSyntaxToMoonbitTests exposing (suite)

{-| This module doesn't test a whole lot.
I mostly use it to check the project still compiles.

If you want to test certain things, it might also be nice
to use this module to quickly inspect the transpiled code

-}

import Elm.Parser
import ElmSyntaxToMoonbit
import Expect
import FastDict
import Test exposing (Test)


suite : Test
suite =
    Test.describe "elm-syntax-to-moonbit"
        [ Test.test ":: with multiple initial elements and final tail variable"
            (\() ->
                """module A exposing (..)
a0 =
    case [] of
        b :: Just c {- 0 -} {- 1 -} :: (d) ->
            b

        _ ->
            Maybe.Nothing

a1 =
    case [] of
        b :: Just c {- 0 -} {- 1 -} :: (_) ->
            b

        _ ->
            Nothing

a2 x =
    case x of
        (({y,z}::tail), Maybe.Nothing as nothing, (Just[ "" ],0)) ->
            0
        _ ->
            1
"""
                    |> elmModuleSourceTranspileToMoonbit
                    |> Expect.ok
            )
        ]


elmModuleSourceTranspileToMoonbit : String -> Result String String
elmModuleSourceTranspileToMoonbit source =
    case
        [ source ]
            |> List.foldl
                (\moduleSource soFarOrError ->
                    case moduleSource |> Elm.Parser.parseToFile of
                        Err deadEnds ->
                            Err
                                (("failed to parse actual source: "
                                    ++ (deadEnds |> Debug.toString)
                                 )
                                    :: (case soFarOrError of
                                            Err errors ->
                                                errors

                                            Ok _ ->
                                                []
                                       )
                                )

                        Ok parsed ->
                            case soFarOrError of
                                Err error ->
                                    Err error

                                Ok soFar ->
                                    Ok (parsed :: soFar)
                )
                (Ok [])
    of
        Err deadEnds ->
            Err
                ("failed to parse actual source: "
                    ++ (deadEnds |> Debug.toString)
                )

        Ok parsedModules ->
            let
                transpiledResult :
                    { errors : List String
                    , declarations :
                        { fns :
                            List
                                { name : String
                                , parameters :
                                    List
                                        { binding : Maybe String
                                        , type_ : ElmSyntaxToMoonbit.MoonbitType
                                        }
                                , result : ElmSyntaxToMoonbit.MoonbitExpression
                                , resultType : ElmSyntaxToMoonbit.MoonbitType
                                }
                        , lets :
                            List
                                { name : String
                                , result : ElmSyntaxToMoonbit.MoonbitExpression
                                , resultType : ElmSyntaxToMoonbit.MoonbitType
                                }
                        , typeAliases :
                            List
                                { name : String
                                , parameters : List String
                                , type_ : ElmSyntaxToMoonbit.MoonbitType
                                }
                        , enumTypes :
                            List
                                { name : String
                                , parameters : List String
                                , variants :
                                    FastDict.Dict
                                        String
                                        (List ElmSyntaxToMoonbit.MoonbitType)
                                }
                        , structs :
                            List
                                { name : String
                                , parameters : List String
                                , fields : FastDict.Dict String ElmSyntaxToMoonbit.MoonbitType
                                }
                        }
                    }
                transpiledResult =
                    parsedModules |> ElmSyntaxToMoonbit.modules
            in
            case transpiledResult.errors of
                transpilationError0 :: transpilationError1Up ->
                    Err
                        ("failed to transpile the parsed elm to moonbit: "
                            ++ ((transpilationError0 :: transpilationError1Up)
                                    |> String.join " and "
                               )
                        )

                [] ->
                    Ok
                        (transpiledResult.declarations
                            |> ElmSyntaxToMoonbit.moonbitDeclarationsToModuleString
                        )
