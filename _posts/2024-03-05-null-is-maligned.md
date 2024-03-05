---
layout: post
title: "Null Is Maligned"
published: true
---

For the longest time, I was told `Null` was bad: “Null the billion-dollar mistake”

But... doesn't database tables have nullable columns? And when there _is_ no value, I put `NULL` in it? If using `NULL` is a billion-dollar mistake there, then what _do_ we use instead?

Cue programmers of various unpopular languages to sweep in, _“come! there’s no Null here, maybe”_

```
type Maybe a = Nothing | Just a

message1 = Just "Hello, world!"
message2 = Nothing
```

So... `Null` is a mistake but `Nothing` is alright? Yes. No.

You see `Null` itself is not the problem: When something has no value, it _is_ `Null` <sup>[[1]](#footnote1)</sup>. That is _correct_. It ISN'T better if we ignored that correctness and use a `0` instead, or `""` empty string, or `0001-01-01 00:00:00 +0000 UTC`!

> ASIDE: Go programmers, life is not a binary choice between "uninitialized C variable causes core dump" vs "implicit zero values then"! <sup>[[2]](#footnote2)</sup> Zero values are not our friend: When we unmarshal a json string without error and some numbers are `0`, how do we know if the values were missing (not good) or the decoder saw `0` in the json string and decoded it (good) ? We don't know <sup>[[3]](#footnote3)</sup>. Null errors can still be located and fixed, but we can't locate zero value data corruption like this. And if you argue _"Oh but there's no difference between an absent value and 0"_ 👀 you should know that's your Stockholm syndrome talking. <sup>[[4]](#footnote4)</sup>

`Null` becomes a problem ONLY IF your language lets you use it like it isn't

```
maybeUser = findUser users 42 // a nullable reference to User value
maybeUser.name                // your compiler is happy; runtime not so much
```

This convenience of referrencing the `name` attribute on a possibly null `user` — THAT is the billion-dollar mistake: the null _reference_. Not `Null` itself.

Back to the example of `Nothing` being the same as `Null` (they are!). The difference is that, in some languages, we can't use a `maybeUser` value like a `User`

```
maybeUser = findUser users 42
maybeUser.name
^^^^^^^^^---- compiler error!
```

The only thing we can do with a `Maybe` value is to deal with each specific code path

```
case maybeUser of
    Just u ->
        "Winner is " ++ u.name # guaranteed safe access

    Nothing ->
        "Nobody won"
```

Inconvenient, but the guarantees are bliss.

So, boys and girls, don’t avoid `Null` itself. Don’t make your table column `NOT NULL` because of the reputation. Don’t use an inaccurate zero value in place of the correct one. If a column is indeed nullable, be brave and make it nullable.

Add a Null check linter? Change your programming language? Anything palatable to you, but let the Nulls be Nulls.

<sub><a name="footnote1">[1]</a> Or Nothing, nil, et al.</sub><br/>

<sub><a name="footnote2">[2]</a> The simplest correct solution to “uninitialized C variable causes core dump” is to require initialization. A little bit of typing goes a long way.</sub><br/>

<sub><a name="footnote3">[3]</a> Unless you look into the json string again. 🤦‍♂️</sub><br/>

<sub><a name="footnote4">[4]</a> After all these sacrifices of correctness for implicit zero values to protect against core dump, Go programmers _still_ have to grapple with the nil zero value and all the same nasties as Null... and worse: [why is my nil error value not equal to nil?](https://go.dev/doc/faq#nil_error). 🤣</sub><br/>
