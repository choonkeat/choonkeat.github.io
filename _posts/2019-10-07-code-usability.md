---
layout: post
title: Code Usability
published: true
---
There's a great talk by [Richard Feldman](https://twitter.com/rtfeldman) making the rounds: [Why Isn't Functional Programming the Norm?](https://www.youtube.com/watch?v=QyJZzq0v7Z4)

There's a slide that says

> ```
> circle.grow(3)
> grow(circle, 3)
> ```
>
> "Objects and methods" are syntax sugar for structs and procedures.

I use to agree: they are _just_ syntax sugar, where "syntax sugar" imply something inconsequential or communicates a lack of importance.

But in [recalling my stumbles](/weblog/2019/09/the-elm-json-decoder-object.html) learning Elm -- and given the fact that the talk is about our we wish FP was the norm; winning market share -- I think we should appreciate the difference from another angle: usability. Appreciate maybe why OOP (syntax) has even slightly more users because of that usability win.

Hey it all adds up right?

> Affordance describes all actions that are made physically possible by the properties of an object or an environment. A bottle screw cap affords twisting. A hinged door affords pushing or pulling. A staircase affords ascending or descending.
>
> [https://uxdesign.cc/affordance-in-user-interface-design-3b4b0b361143](https://uxdesign.cc/affordance-in-user-interface-design-3b4b0b361143)

So, in the code snippet above, what does the variable `circle` afford us to do? and how does a programmer find out?

> NOTE: Keep in mind that the variable could be of a less straightforward type than a `Circle` or `Shape` (e.g. `UnnormalizedMeterReading`), or the programmer might be new to the codebase, or be the original author but had [forgotten all the details after a hiatus](/weblog/2018/08/rails-hiatus.html).

What does an OOP programmer do? I'll just type c-i-r-c-l-e-. and after that period `.` my code editor will show a handy dropdown list of possible actions, along with documentation snippet, specifically catered for the variable:

```
circle.
       color(c Color)       : set foreground color to c
       grow(n Integer)      : increases diameter by n
       moveTo(x, y Integer) : place the circle on specified x,y coordinate
```

Contextual help. Perfect. Basically an equivalent in GUI would be the wizard dialog and its "next" "next" "finish" buttons.

On the other hand, what does an FP programmer do? Assuming I can figure out what type the variable is, I'll open the documentation in my browser, press `CMD-F` and try my luck with "Find on page" with some guess words... say... `resize`? no?

> When you design user interfaces, it's a good idea to keep two principles in mind:
> 1. Users don't have the manual, and if they did, they wouldn't read it.
> 2. In fact, users can't read anything, and if they could, they wouldn't want to.
>
> -- [https://www.joelonsoftware.com/2001/10/24/user-interface-design-for-programmers/](https://www.joelonsoftware.com/2001/10/24/user-interface-design-for-programmers/)

The first step is admitting you have a problem.

What's the next step? A function signature search perhaps? A bit out of the way, but more importantly, it needs precision to yield results [fail example](https://klaftertief.github.io/elm-search/?q=Json.Decode.Decoder%20a%20-%3E%20String%20-%3E%20a) vs [success example](https://klaftertief.github.io/elm-search/?q=Json.Decode.Decoder%20a%20->%20String%20->%20Result%20Error%20a).

_"Can any function from any module that can receive this Shape value, along with any other arguments, please stand forward? Curried functions in the current closure?"_

Maybe something for the code editor community to think about.

---


_FWIW, the SQL syntax has the same problem too: you type `SELECT ` and wait there.. no code editor can help you very much since nobody knows what you are trying to select `FROM` yet. If that syntax had just switcheroo, `FROM ... SELECT ...` the more usable SQL syntax could've driven SQL adoption even higher ;-)_
