---
layout: post
title: "Re: Statically Typing Big Erratic JSON"
published: true
---
Related to [my previous post](/weblog/2022/03/regarding-the-user-wizard-scenario.html), I'd like to address another scenario cited as reasons to favor dynamic types:

> Some APIs have a huge JSON format. But we might only need a few fields. Some fields could be `false`, or a list things. Some fields should even be parsed depending on some other fields in the JSON. To statically type this is very tedious and the type might not be understandable anymore.

When it comes to parsing JSON, there are reasons to favor dynamic types (who doesn't like `JSON.parse` when exploring data?), but I think the reasons above are actually reasons _to favor static types_.

> **1. "Some APIs have a huge JSON format. But we might only need a few fields."**

In a dynamically typed language, we'd simply ignore the rest of the json and use what we need

```js
function handle(jsonString) {
    let user = JSON.parse(jsonString)
    store(user);
}

function store({ email }) {
    // do stuff with `email`
}
```

In a statically typed language, we'd simply ignore the rest of the json and decode what we need

```elm
userDecoder =
    Json.Decode.map (\s -> { email = s })
        (field "email" string) -- only decode `"email"` field

handle jsonString =
    case decodeString userDecoder jsonString of
        Ok user ->
            store user

        Err jsonError ->      -- runtime error for
            handle jsonError  -- dynamically typed langs

store { email } =
    -- do stuff with `email`
```

The added benefit is, if `email` field is anything but a `String`, we would've gotten a parsing error early and have code to deal with it upfront. Whereas, in the JS example, we might not know that our `email` is `null` or `42` until much later in the system (a background job 3 days later?).

Troubleshooting the source of bad values that causes a crash is tedious, time consuming, and (given decoder pattern exists) an unnecessary trouble imo.

Even if we implemented decoders in JS, we still can't reap its benefits in the rest of our dynamically typed system. We need to manually add assertions everywhere that matters (that we remember to). `welcomeEmail( { email })` ? hmm, add a check just to be safe

```js
function welcomeEmail( { email }) {
    if (typeof email !== 'string') {
```

Btw, what can we effectively _do_ with an invalid value here? [Dealing with errors deep in the system is awkward](/weblog/2021/05/awkward-error-handling-is-a-smell.html)

> Isn't writing type signatures everywhere equivalent to scattering assertions everywhere?

No. Types are checked at compile time over the entire codebase, while assertions checks at runtime... and _only when_ that line is run. 5th page of a form wizard? Code gotta run until there, in the right condition, to find out about it.

> We can add type signatures in some dynamically typed languages

Type inferred languages like Haskell had long allowed type signatures to be _removed_ and still keep the benefit!

Basically _"where do you want to check"_ vs _"everything is checked"_. I think it's safe to say while folks might prefer some control over what they want to check in their code, we'd prefer other people's code to be fully checked where possible 😆 as they say, _["Software engineering is what happens to programming when you add time and other programmers."](https://research.swtch.com/vgo-eng)_


> **2. "Some fields could be `false`, or a list things. Some fields should even be parsed depending on some other fields in the JSON."**

Since the said JSON is beyond our control, we just have to deal with it. There is no escape.

In a dynamically typed language, we do whatever is necessary

```js
function handle(jsonString) {
    let user = JSON.parse(jsonString)

    // `false` just means no preferences
    if (user.preferences === false) user.preferences = []

    // `state` determines what `date` actually means
    if (user.state === 'deleted') user.deletedAt = user.date
    if (user.state === 'active')  user.lastLoginAt = user.date

    store(user);
}

function store({ email, preferences, deletedAt, lastLoginAt }) {
    // do stuff with fields
}
```

In a dynamically typed language, we do whatever is necessary but inside the decoders.

```elm
preferenceDecoder =
    Json.Decode.oneOf
        [ map (always []) decodeFalse -- `false` found? decode as an empty list []
        , list string                 -- otherwise, decode as list of string
        ]

dateDecoder =
    Json.Decode.map2 datesFromState
        -- decode both json fields `state` and `date`
        -- then hand it off to `datesFromState` to decide
        (Json.Decode.field "state" string)
        (Json.Decode.field "date" isoDate)

datesFromState stateString date =
    case stateString of
        "deleted" ->
            { deletedAt = Just date, lastLoginAt = Nothing   }
        "active" ->
            { deletedAt = Nothing,   lastLoginAt = Just date }
        _ ->
            { deletedAt = Nothing,   lastLoginAt = Nothing   }
```

We compose our `userDecoder` with these decoders

```elm
userDecoder =
    Json.Decode.map3 buildUser
        -- decode the fields then assemble with `buildUser`
        (field "email" string)
        (field "preferences" preferenceDecoder)
        (dateDecoder)

buildUser email preferences { deletedAt, lastLoginAt } =
    { email = email
    , preferences = preferences
    , deletedAt = deletedAt
    , lastLoginAt = lastLoginAt
    }

handle jsonString =
    case decodeString userDecoder jsonString of
        Ok user ->
            store user

        Err jsonError ->
            handle jsonError

store { email, preferences, deletedAt, lastLoginAt } =
    -- do stuff
```

> **3. To statically type this is very tedious and the type might not be understandable anymore.**

While there is obviously more lines of code, but note that the _type_ of `User` is as clean.

The messy reality of the JSON rules are captured and compartmentalized inside individual decoder functions. The rest of the system can use this clean `User` type in abandon, with the compiler ensuring there are no stray threads.
