---
layout: post
title: What does it mean by `Html Msg`?
published: true
---
There are possibly 2 questions in this question. I'll answer them 1 by 1

### Part 1: h-t-m-l message

After knowing the basic Elm syntax, we could be reading the following "return values" like this

```elm
userFromJWT : String -> Maybe User
-- returns a User value or nothing
```

```elm
split : String -> List String
-- returns a list of String
```

With the help from our prior programming experience, we treat the return values as `*User` and `[]String` and jumps directly to think in terms of _"How do I use a `var u *User` value? `u.name`?"_ and _"How do I use a `var s String`? `String.length(s)`?"_

We don't actually "see" the words `Maybe` or `List`; our attention was focused on `User` and `String`.

If we proceed with these instincts alone, we'll fumble when we see unfamiliar types. We'd ask the wrong questions

``` elm
view : Model -> Html Msg
-- returns an h-t-m-l message... but how do I return such a message?
```


``` elm
userEmail : Json.Decode.Decoder String
-- returns a json decode decoder string... but how do I return such a string?
```

There are no answers to the questions because there's a misunderstanding of the grammar. To avoid being misled by my prior programming experience, I do this one weird trick instead:

1. Just focus on the first word

    ``` elm
    Html Msg
    ^^^^
    -- and read "Html" type


    Json.Decode.Decoder String
    ^^^^^^^^^^^^^^^^^^^
    -- and read "Json.Decode.Decoder" type


    HelloWorld (Html msg) (Json.Decode.Decoder String)
    ^^^^^^^^^^
    -- and read "HelloWorld" type
    ```

1. Then look at the documentation for that word; look for functions _that returns that word_

Here are some functions that I found with text search `-> Html ` on [in the `Html` docs page](https://package.elm-lang.org/packages/elm/html/latest/Html)

``` elm
text : String -> Html msg
div : List (Attribute msg) -> List (Html msg) -> Html msg
span : List (Attribute msg) -> List (Html msg) -> Html msg

-- note: unfamiliar types like `Attribute` usually refers to a type defined in the same module, i.e. `Html.Attribute`. You may have to search around for it
```
And calling any of the these functions will be able to give us a value of `Html` type, just provide the necessary input argument values.

Here are some functions that I found returning `Decoder` [in the docs page of `Json.Decode`](https://package.elm-lang.org/packages/elm/json/latest/Json-Decode) (there wasn't a page on `Json.Decode.Decoder` alone)

``` elm
string : Decoder String
int : Decoder Int
list : Decoder a -> Decoder (List a)
field : String -> Decoder a -> Decoder a
oneOf : List (Decoder a) -> Decoder a
```
Same idea: calling any of the these functions will be able to give us a value of `Json.Decode.Decoder` type, just provide the necessary input argument values.

### Part 2 Ok, but what _is_ this `Html` type

In an Elm [Browser program](https://package.elm-lang.org/packages/elm/browser/latest/) we are required to provide a `view` function that returns `Html` type. We can deduce Elm takes this return value and renders the corresponding DOM nodes in the browser.

``` elm
view : model -> Html msg
view model =
    Html.h1 [ Html.Attributes.class "greeting" ] [ Html.text "Hello" ]
```

will render

``` html
<h1 class="greeting">Hello</h1>
```

The `Html` module does not export the internal details of this type for us to look at (aka it's an opaque type). The module only exports a bunch of functions for us to call, to obtain various `Html` values. And really that's all we can know about it.


### Part 2b And what's the relevance of `msg` part?

That's the type parameter of `Html` type. We can't always have an effective mental model of what role they play. Sometimes we can deduce easily, e.g. `Maybe Int` or `List String`. But other times, it's not as obvious

``` elm
string : Parser (String -> a) a
```

What we can practically do with them is to make sure the type parameters / associated data types align, e.g.

``` elm
map : (a -> b) -> a -> b
map func arg =
    ...
```

To "line up" the type parameters.. i'll make sure the the `a` types are the same. And similarly:

``` elm
h1 : List (Attribute msg) -> List (Html msg) -> Html msg
```

When we call [`Html.h1`](https://package.elm-lang.org/packages/elm/html/latest/Html#h1) we can give any list of attributes and list of inner html elements -- as long as their `msg` are the same type
