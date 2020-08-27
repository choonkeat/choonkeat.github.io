---
layout: post
title: Make bugs into type errors
published: true
---
It's very common for frontend apps to fetch remote data to update sections of the UI. For example

1. user click and triggers a `LoadThing` message which fires off a network call, `getThing`
1. if it was successful, show data
1. otherwise, show error

``` elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadThing num ->
            ( model
            , Task.attempt OnThing (getThing num) )

        OnThing (Err err) ->
            ( { model
                | alert = Just (httpErrorString err)
              }
            , Cmd.none )

        OnThing (Ok thing) ->
            ( { model
                | thing = RemoteData.Success thing
              }
            , Cmd.none )
```

Did you notice a bug?

A very common bug here is: we've forgotten to set the loading status before firing off `getThing`. And even after we fix _that_, we might realise days later that we've forgotten to unset the loading state upon getting an error. Whack-a-mole. As the number of APIs grow, and changes happen over time, preventing such bugs will only become harder and harder.

Wait, there's a request to update the api, now we should update `model.category` from the api response too, merge PR & deploy. Oops, we forgot to set `category = Loading` 😩 Again 😖

Is our constant vigilance the only protection?

<img width="294" alt="Screenshot 2020-08-26 at 10 34 10 PM" src="https://user-images.githubusercontent.com/473/91317369-8cdfd980-e7ec-11ea-8668-96d959898f17.png">

As a code reviewer, I'd prefer the answer to be: no.

> [make bugs into type errors - @mattoflambda](https://twitter.com/mattoflambda/status/1008735243581288449)

Well, since we're trying to coordinate the state changes of request and response activities for each API, let's unify them into a sum type

### Part 1/2

``` elm
type RequestResponse param response
    = Request param
    | Response (Result Http.Error response)

type ApiMsg
    = ThingApi (RequestResponse Int Thing)
    -- other APIs ...
    -- each API defines a `RequestResponse` with their own `param` and `response` types
```

then we can nest all API related Msg,

``` diff
type Msg
-    = LoadThing Int
-    | OnThing (Result Http.Error Thing)
+    = OnApiMsg ApiMsg
     -- other button click etc Msg still remain
```

and delegate all API related state updates to a new `updateWithApiMsg`

``` elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnApiMsg apiMsg ->
            updateWithApiMsg apiMsg model
        -- other button click etc Msg still handled here

updateWithApiMsg : ApiMsg -> Model -> ( Model, Cmd Msg )
updateWithApiMsg siteApi model =
    case siteApi of
        ThingApi requestResponse ->
            case requestResponse of
                Request num ->
                    ( model
                    , requestCmd ThingApi (getThing num) )

                Response (Err err) ->
                    ( { model
                        | alert = Just (httpErrorString err)
                      }
                    , Cmd.none )

                Response (Ok thing) ->
                    ( { model
                        | thing = RemoteData.Success thing
                      }
                    , Cmd.none )

        -- other APIs ...
```

We've done a bunch of busy work but everything still compiles; we still have our bug?? Perfect. _Now_, we're ready to make this bug a type error.

### Part 2/2

Recall that what we're trying to achieve is make sure we don't forget to update the same set of model attributes for every stage of the API call (request, success, error). And each API will have their own set of model attributes.

> All branches in a `case` must produce the same type of values. This way, no matter which branch we take, the result is always a consistent shape.

Let's rearrange our Elm code to take advantage of this

``` elm
updateWithApiMsg : ApiMsg -> Model -> ( Model, Cmd Msg )
updateWithApiMsg siteApi model =
    case siteApi of
        ThingApi requestResponse ->
            let
                -- NOTE: `updated` is only a subset of our `Model` record type
                -- with only the fields that needs to be updated for `ThingApi`
                ( updated, cmd ) =
                    case requestResponse of
                        Request num ->
                            ( {}
                            , requestCmd ThingApi (getThing num)
                            )

                        Response (Err err) ->
                            ( { alert = Just (httpErrorString err) }
                            , Cmd.none
                            )

                        Response (Ok thing) ->
                            ( { thing = RemoteData.Success thing }
                            , Cmd.none
                            )
            in
            ( { model | alert = updated.alert, thing = updated.thing }, cmd )

        -- other APIs ...
        -- each `updated` record will be different subsets of `Model` record type
```

Now, we have a compiler error!

```
The 2nd branch is a tuple of type:

    ( { alert : Maybe String, thing : RemoteData.RemoteData Http.Error a }
    , Cmd msg
    )

But all the previous branches result in:

    ( {}, Cmd Msg )

Hint: All branches in a `case` must produce the same type of values. This way,
no matter which branch we take, the result is always a consistent shape. Read
<https://elm-lang.org/0.19.1/custom-types> to learn how to “mix” types.
```

Elm does not allow returning different types for different branches of a `case` or `if` expression, but currently
- our "request" branch, returns an empty record `{}`
- our "error" branch, returns a `{ alert : Maybe Alert }` record
- our "ok" branch, returns a `{ thing : RemoteData.RemoteData Http.Error a }` record
- and if any branch forgets, and returns `( model, sendRequestCmd )` it won't work too!

The only way to compile, is to return the _same subset_ of fields for _all branches_ of our `case requestResponse of` -- which is exactly what we wanted!

### Result

``` elm
updateWithApiMsg : ApiMsg -> Model -> ( Model, Cmd Msg )
updateWithApiMsg siteApi model =
    case siteApi of
        ThingApi requestResponse ->
            let
                -- NOTE: `updated` is only a subset of our `Model` record type
                -- with only the fields that needs to be updated for `ThingApi`
                ( updated, cmd ) =
                    case requestResponse of
                        Request num ->
                            ( { alert = model.alert -- aka no change
                              , thing = RemoteData.Loading
                              }
                            , requestCmd ThingApi (getThing num)
                            )

                        Response (Err err) ->
                            ( { alert = Just (httpErrorString err)
                              , thing = RemoteData.Failure err
                              }
                            , Cmd.none
                            )

                        Response (Ok thing) ->
                            ( { alert = Just "Thing loaded successfully"
                              , thing = RemoteData.Success thing
                              }
                            , Cmd.none
                            )
            in
            ( { model | alert = updated.alert, thing = updated.thing }, cmd )

        -- other APIs ...
        -- each `updated` record will be different subsets of `Model` record type
```

Now, each branch is required to return the same fields; each API can have their own field set. Elm compiler can be our constant vigilance instead. 🎉
