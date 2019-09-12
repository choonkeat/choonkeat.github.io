---
layout: post
title: The Elm Json Decoder "Object"
published: true
---
When I was learning Elm, json decoding stumps me. The [documentation](https://package.elm-lang.org/packages/elm/json/latest/Json-Decode) says upfront

> ``` elm
> type Decoder a
> ```
> A value that knows how to decode JSON values.

And followed by a rather imperative description of `Json.Decode.float`

> ``` elm
> float : Decoder Float
> ```
> Decode a JSON number into an Elm `Float`.

I suspect my head was parsing as

- `Json.Decode.Decoder a` means a decoder that knows how to decode a given json string into a value of type `a`
- `Json.Decode.Decoder Float` knows how to decode a given json string into a `Float`.
- If I create my own `Json.Decode.Decoder User`, it is something that knows how to decode a given json string into a `User`

I wasn't aware how deeply OOP had shaped my thinking. Or maybe it's because of the "-er" suffix of `Decoder` and my [Go instincts](https://golang.org/doc/effective_go.html#interface-names).

To ease understanding, it is better we don't treat `Json.Decode.Decoder Float` nor `Json.Decode.Decoder User` as "objects". They don't "know how to do" anything. They hold values and are easier to grok if perceived as dumb values like `{ kind = "Float" }` or `{ kind = "User" }`.

A `Json.Decode.Decoder a`
- is not an "object"
- does not have a "method"
- to perform the work when "given a String"

Give that string to [`Json.Decode.decodeString`](https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#decodeString) function instead:

``` elm
Json.Decode.decodeString Json.Decode.float someString
```

The code doing the work is inside the `Json.Decode.decodeString` function, not with your `Json.Decode.Decoder a` value.

Our `Json.Decode.float` decoders are just values (or flags or settings or config... whatever works for your mental model) that will be used to if-else our way inside the `Json.Decode.decodeString` function, to decide what code branch to run. i.e. a pretend implementation of `decodeString` might be

``` elm
decodeString decoder someString =
    case decoder.kind of
        "Float" ->
            String.toFloat someString
        "User" ->
            ...
```

So, [any function returning a `Decoder a`](https://package.elm-lang.org/packages/elm/json/latest/Json-Decode) is just a function that returns a flag or settings or configuration... not returning an "object" with "method" that parses a string.

If you're struggling with `Json.Decode.Decoder`, hope this mental model helps.

NOTE: it doesn't matter if the implementation detail is such that there's actually a function being carried around inside `Json.Decode.Decoder a` values; the OOP mental model makes this hard to understand.
