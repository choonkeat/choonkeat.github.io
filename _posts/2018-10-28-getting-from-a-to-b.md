---
layout: post
title: Getting from A to B
published: true
---
> "If you're building a RDBMS backed, CRUD html web application, Rails let you start building from level 30"

I often say. Ruby blocks and meta programming let me do so much with so little code. Go channels are so easy to wield; concurrency made easy. JavaScript's new syntax removed much boilerplates and let us plough forward faster. Whatever code you need, there's probably a ready package that you can install and build on top of. And the list goes on.

Programming tools are mostly measured by how well they can get us from A to B.

When I started to write my first Elm app, I struggled very badly. It's such a departure from all my previous programming languages that I was at a total loss <sup>[[1]](#footnote1)</sup>. Where do I even _begin_? I recall it taking me more than an hour just to figure out how to include "the current time" upon receiving my http api response. 🙈

Measures badly in terms of getting from A to B isn't it?

> "To do anything in Elm, is very hard for me. But when I've finally done it, I like the code very much"

In Elm, I'd spend time getting from A to B. After I solve it, it's like "oh... that's how `Task` works". I actually get somewhere. My efficiency will improve over time. In modern JavaScript, I'd spend arguably similar cycles overcoming config & wiring issues (e.g. webpack) every now and then. However, after I solve it, I didn't actually _get anywhere_. That "knowledge" learnt is more like accumulating magic spells to try the next time I trip over my config wires.

After writing a bit more Elm code, I picked up on some strange patterns. I wasn't sure if I'm imagining things, so I googled a bit and asked around at the local Elm meetup. I'm happy to learn that it's not just me.

> "If it compiles, it probably works"

Unbeknownst to me, that's a common phrase used on Haskell (Elm's direct ancestor). There are ways to dissect and argue that the phrase is inaccurate (e.g. _"you can compile and still get Fizz Buzz wrong!"_), but fact _is_ I'd never developed that level of confidence when working with anything else. Ever. And I didn't even know to be looking out for it. (Sorry if you didn't know too... now you know the spoiler.)

When faced with "will it work?", we might think it's mostly a question of correct logic (e.g. Fizz Buzz). But for every day code, whether something "works" is also as much about whether we had wired things correctly: _when user does A, did B trigger C to update D into E? How about unhappy paths?_ Turns out, frontend software is full of wires. Turns out, such uncertainties are avoidable.

When I first learnt Custom Type (better known as Union Type, Algebraic Data Types, or ADTs), I was 😻. A friend told me to check TypeScript, "it has union types". I looked and found it half true: missing the important second half (which is also the sad recurring theme song of _"{mainstream imperative language X} adopted {functional language feature Y}"_)

First half: yes, you can define a union type, `type Shape = Square | Rectangle`. But the more important second half: When we add `Circle` to the mix, what breaks in your codebase at compile time? In TypeScript or Flow, you have to go out of your way to have compile-time guarantees. In Elm, you have to go out of your way to escape it.

> "Break everything"

When I need to make changes (e.g. turns out this remote api is often slow, better account for slow loading) I'd usually look at the edge regions, refactor and propagate fixes "backwards" until done. Initially, I'd do the same in Elm. After few laps of Elm, I found I often began my fix from "the model" (aka the application's state; model of the world; the data; the inside) and then propagating the fix _outwards_.

Backwards, outwards, sounds like we could do this in our existing languages too, right?

When we fix backwards, we usually break the caller and we fix that, and maybe breaks its caller, and repeat until it compiles again (or tests passes). This workflow is more manageable to perform, but is essentially a "patch" on our modelling of the problem domain (adding another edge case to an elegant model)

When we fix outwards, we revisit how we model the problem domain and change that central model _first_ <sup>[[2]](#footnote2)</sup>. That'll usually break everything, everywhere, all at once. This is more chaotic, potentially rendering swaths of code irrelevant. Tests might even be easier to rewrite than "fixed up". Without good tooling to help us mere humans, it is hard to tackle such a reckless mess; code compiles (or tests passes), but we remain suspicious; deploy and monitor sentry? I suspect this chaos is one reason why we naturally avoid the approach.

With the Elm/Haskell compiler, in their "if it compiles, it probably works" world, when we do see our code compile, it means our wires are solid and our unhappy paths are laid. We have a really strong signal that our fix is complete.

> "Refactoring easy"

Pure functions are just inputs and return values (no side effects, no global references). Turns out, they are really really maintainable building blocks. When you're looking at a pure function, it doesn't matter if your project is 10, 1000 or 10,000,000 lines of code, your mind can focus on the pure function alone: nothing outside can affect it, it can affect nothing else. Who would've thunk that helps?

In Go, it is already idiomatic to prefer a bit of verbosity in exchange for a more straightforward code that "do things right there", flowing simply from top to bottom. If we so desire, couldn't we just write pure functions in our favourite mainstream imperative language instead of abandoning ship and going into obscure ML land?

We could. But I suspect building an entire app out of pure functions is a real struggle, made worse when the imperative language provide 101 ways to get from A to B. I get seduced by _"how to do functional programming in [your imperative language]"_ too, but the oft overlooked second part of that sad recurring theme song is: what we _cannot do_ is more important. If your language isn't going to stop you, all you've got are just soft agreements by linters, coding convention, and best practices.

What I _do_ know is, I find refactoring code in Elm relatively more enjoyable. I suspect that being composed from pure functions has a lot to do with it. Also, there are little language level features that do make pure functions nicer to wield in ML and are cumbersome or missing in imperative languages <sup>[[3]](#footnote3)</sup>.

> "Use the compiler"

Usually the compiler is just a means to an end: it translates our english-y text into (virtual) machine code. A compiler is good when it translates correctly, fast, and produces efficient (virtual) machine code. Similar measure for dynamic language interpreters. The only time I think about my compiler, is when I'm trying squeak some "creative" syntax past it (could this "dsl" work? ugh!)

On the other hand, the Elm compiler, is truly in a different league. Not only is it your code translator, but it is also your linter, formatter, TDD tester, extra pair of programmer eyes, patient explainer, and edge-case-catcher all rolled into one! As such, I do find myself sometimes leaning on the Elm compiler to tease code out: _I have X, my target function uses Y, I'll call them wrong anyways then my compiler will guide me on what I need to do_ 🤯 I know right?

### A Better B

Regardless of whether Elm is "the answer" (it's young and evolving), I'm happy to be seeing what life is like over there in the pure, statically-typed, functional programming world. I'd never known such guarantees exists <sup>[[4]](#footnote4)</sup>, and these uncertainties are actually avoidable. This world isn't even new 🤦 <sup>[[5]](#footnote5)</sup>

Now that I've seen what's possible, I'm looking forward to learn about things that can get me to "a good B" instead of just getting me from A to B faster.

<sub><a name="footnote1">[1]</a> I learnt Lisp in school and thought I'd already covered FP. Understanding ML method signatures and knowing how to use a function was a surprising struggle, e.g. what am I supposed to do with a [`succeed : a -> Task x a`](https://package.elm-lang.org/packages/elm-lang/core/latest/Task)?</sub><br/>
<sub><a name="footnote2">[2]</a> Instead of working with "array of tweets", let's model them as a "remote array of tweets"; see [RemoteData](http://blog.jenkster.com/2016/06/how-elm-slays-a-ui-antipattern.html)</sub><br/>
<sub><a name="footnote3">[3]</a> See [currying]({{ site.baseurl }}{% post_url 2018-09-12-currying %}).</sub><br/>
<sub><a name="footnote4">[4]</a> [Making Impossible States Impossible](https://www.youtube.com/watch?v=IcgmSRJHu_8)</sub><br/>
<sub><a name="footnote5">[5]</a> ["If type functional programming is so great, how come nobody uses it"](https://www.youtube.com/watch?v=oYk8CKH7OhE)</sub><br/>
