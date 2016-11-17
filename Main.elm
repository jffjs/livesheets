import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main =
  Html.beginnerProgram
    { model = initialModel
    , view = view
    , update = update
    }

-- Model

type alias Model =
  { name : String
  , level : Int
  , xp : Int
  , str : Int
  , dex : Int
  , con : Int
  , int : Int
  , wis : Int
  , cha : Int
  }

initialModel : Model
initialModel =
  { name = ""
  , level = 1
  , xp = 0
  , str = 10
  , dex = 10
  , con = 10
  , int = 10
  , wis = 10
  , cha = 10
  }

-- Update

type Msg
  = Name String
  | Strength String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }
    Strength strength ->
      let
          str = Result.withDefault 0 (String.toInt strength)
      in
          { model | str = str }

-- View

view : Model -> Html Msg
view model =
  div []
  [ viewName model
  , text model.name
  , viewAbilityScores model
  ]

viewName : Model -> Html Msg
viewName model =
  div []
  [ input [ value model.name
          , type_ "text"
          , placeholder "Name"
          , onInput Name
          ] [] ]

abilityModifier : Int -> String
abilityModifier abl =
  let
      modifier = (abl - 10) // 2
  in
      if modifier < 0 then
        toString modifier
      else
        "+" ++ (toString modifier)

viewAbilityScores : Model -> Html Msg
viewAbilityScores model =
  div []
  [ text "Str"
  , input [ value ( if model.str == 0 then "" else (toString model.str) )
          , type_ "text"
          , size 2
          , onInput Strength
          ] []
  , text (abilityModifier model.str)
  ]
