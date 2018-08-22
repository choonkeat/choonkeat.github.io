---
layout: post
title: Just another day in paradise
published: true
category:
- rails
---
Sometimes it takes talking to somebody new to Rails to recall the little blessings that I've come to take for granted (which I use to be doing by myself over and over and over again...) For example, these HTML inputs

> \<input name="person[0][name]" /\>
> \<input name="person[0][email]" /\>
> \<input name="person[1][name]" /\>
> \<input name="person[1][email]" /\>
> \<input name="person[2][name]" /\>
> \<input name="person[2][email]" /\>

when submitted, simply gives me regular, hierarchical hashes (not custom classes like PersonFormArray)

> params["person"]["0"] # { "name" =\> ..., "email" =\> ... }
> params["person"]["1"] # { "name" =\> ..., "email" =\> ... }
> params["person"]["2"] # { "name" =\> ..., "email" =\> ... }

Some might disagree and say its simpler in _some_ JEE framework where inputs and objects are paired for you automatically. What usually goes on, is that the binding is opaque and couples the implementation on two sides (view/controller or view/model). Stifling.

In Rails (ActionPack), the "binding" is only a transparent naming convention. Hence, there is no coupling and more flexibility.

> \<input name="person[2][silly\_requirement]" /\>

Will make the hash, without fuss, become

> params["person"]["2"] 
> # {"name" =\> ..., "email" =\> ..., "silly\_requirement" =\> ...}

