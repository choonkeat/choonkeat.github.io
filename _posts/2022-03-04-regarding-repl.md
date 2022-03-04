---
layout: post
title: "Re: REPL"
published: true
---

_This is a followup to [Re: The User Wizard Scenario](/weblog/2022/03/regarding-the-user-wizard-scenario.html) and [Re: Statically Typing Big Erratic JSON](/weblog/2022/03/regarding2-statically-typing-big-erratic-json.html)_

> [I like the idea of using a Dict until you're ready to enforce types. It's similar to what I suggest at the end....](https://twitter.com/ericnormand/status/1499053983050125315)
> In the second post, it seems like you haven't addressed what I consider the root of the problem, which is discovery....
> But it is one of the pains that Clojure addresses by bundling dynamic typing with REPL-driven development.

I realise we were almost talking past each other! I [had noted in passing](/weblog/2022/03/regarding2-statically-typing-big-erratic-json.html) the advantage of dynamic types during exploration, citing `JSON.parse` and Eric Normand mentioned liking the idea of using a `Dict` until we're ready to enforce. But those two points carry more significance for each party than the other acknowledged! Let's dig into it instead!

But first,

**Q: Does Elm come with a powerful library for working with Dict values (like Clojure does)?**

Unfortunately though the [functions](https://package.elm-lang.org/packages/elm/core/latest/Dict) are [enough](https://package.elm-lang.org/packages/elm-community/dict-extra/latest/), the ... \*drum roll\*... _type_ is not flexible enough 🙈. Keys are limited `comparable` types (hardcoded in Elm), and since values must be the same type, nesting `Dict` requires wrapping with something like `Tree a = Node a | Tree a`.

#### **REPL**

It's definitely more productive in a dynamic language especially with one equipped with a more powerful repl than usual, eg Clojure. I imagine asking the repl to assign the response into a variable. Then work on this variable until I get what I want from it, and when it worked, copy/paste/save the repl code into my app, done!

For my workflow, I use the raw JSON to TDD my decoder as [Eric Normand had described](https://twitter.com/ericnormand/status/1499055989240176642). However, the feedback loop on test-on-file-save, at least for Elm, is not shabby <sup>[[1]](#footnote1)</sup>.

I suspect the main difference could be this:
- the repl dev is happy to get working code speedily by the end of it (getting from A to B fast)
- whereas decoder dev feels happy to have an external input defined as type by the end of it (sure-footed).

However I feel the speed difference of this activity is in _minutes_<sup>[[2]](#footnote2)</sup>, but the speed difference later on can easily be _hours_...

**Q: How do we deal with changes after that?** e.g. some fields turns out to be optional, etc.

For decoder dev, errors happen when decoder reaches unexpected character of the input. So errors can state how their expectation failed: expect "email" field to be string (but it wasn't). This allows us to zoom in to the "email" field decoder and start TDDing with the new input variant. Fixed.

For repl dev, if we jump immediately to thinking about fixing the parsing function, the difference there isn't huge either. While manually stepping through the _function body_ (or comparing old json with new json) to locate the problem is a little tedious but that's still the happy scenario.

The real scenarios that decoder devs are fending off are all those runtime errors that pops up in places that doesn't make sense. Tracing why such values are in a bad state takes a lot of time & effort in a dynamically typed system: there are so many code paths? across subsystems? It can take hours before we discover the particular parsing function to fix.

#### **Boundary**

> I like idea of using a Dict until we're ready to enforce

This is more significant to me than an idea to apply for a particular scenario: It's the fact that entire system is enforced: every tiny part is always locked in and enforced with other tiny parts regardless whether I remember to do it or not. I'd mentioned "sure-footed" in an earlier paragraph, but [here's my longer description of what that meant](https://discourse.elm-lang.org/t/what-are-your-favorite-things-about-elm/6947/71):

> With Elm, I could take a sure-footed approach to problems that I might have previously felt is too hard for me. **My Elm solution to each small part cumulates to the final solution without requiring me to keep revisiting at every step (because it’s “proven”)**. And the best part is, after I’ve crossed the finishing line & gotten everything working, tidying up my entire solution is a safe and mechanical process. Confidence++

This applies to both getting things to work _in the first place_ but especially to _managing changes later_; no unnecessary revisits. That's what I'm giving up the discovery speed for.

Then again "giving up" sounds harsh since I _can_ improve and reach _reasonably good productivity_ for discovery too. On the other hand, I _feel_ without such pure & statically typed language supporting me so completely, the sure-footedness described above cannot be achieved by myself.

---

<sub><a name="footnote1">[1]</a> I was developing a Slack bot in a place with no wifi, and I just wrote decoders based on JSON samples I'd downloaded earlier from their docs site, then I write code that worked with those types, fixing bugs along the way until it compiles. When I'm finally back online, I tried my bot... and it worked the first run! I'm not such a meticulous person so credits totally goes to the Elm compiler and its type system.</sub><br/>

<sub><a name="footnote2">[2]</a> This should possibly be the understatement akin to SVN users downplaying the speed of Git, while Git rightfully claims [it's so freaking fast that you actually use it differently](https://youtu.be/4XpnKHJAok8). Must be giddying! I should want to experience such repl workflow someday.</sub><br/>
