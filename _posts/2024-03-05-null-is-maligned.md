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

alice = Just "somebody"
bob = Nothing

case alice of
    Just s ->
        "We got " ++ s

    Nothing ->
        "Got nought"
```

So... `Null` is a mistake but `Nothing` is alright? Yes. No.

You see `Null` itself is not the problem: When something has no value, it _is_ `Null`. That is correct. It ISN'T better if we ignored that fact and used a `0` instead, or `""` empty string, or `[]`, or `0001-01-01 00:00:00 +0000 UTC`!

Go programmers, life is not a binary choice between "uninitialized C variable causes core dump" vs "initialize as zero values then"! Zero values are not your friend: When you decode json without error and the value is `0`, how do we know the value was missing or we saw `0` in the json string and decoded it? We don't. Our programs got bugs.

`Null` becomes a problem ONLY IF your language lets you use it like it isn't

```
user = findUser 42 // 💣
user.name          // 💥
```

This convenience of calling `name` method on a possibly null `user` object — THAT is the billion-dollar mistake: the null _reference_.

So, boys and girls, don’t avoid `Null`. Don’t make your table column `NOT NULL` because of the reputation. Don’t use an inaccurate zero value in place of the correct one. If a column is indeed Nullable, be brave and make it Nullable.

Add a Null check linter? Change your programming language? Anything palatable to you, but let the Nulls be Nulls.
