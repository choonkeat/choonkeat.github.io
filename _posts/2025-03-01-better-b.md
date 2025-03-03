---
layout: post
title: "Better B"
published: true
---

### High output

I used to work with this young leetcoder. He is smart and fast. He can whip out code double quick time. Sometimes when I’m looking at his PR, I’m in awe. In awe at how a requirement could be followed to the letter, yet doing the wrong thing 😭 The angle of how his code can be incorrect catches me off guard.

The current AI coding agent reminds me of him: one moment exceeding expectations one-shot-ing an entire feature, another moment stumbling over the weirdest rabbit hole. We are in the era of high output programmers <sup>[[1]](#footnote1)</sup> <sup>[[2]](#footnote2)</sup> <sup>[[3]](#footnote3)</sup> <sup>[[4]](#footnote4)</sup> <sup>[[5]](#footnote5)</sup>, so everyone gets to work with my young leetcoder now:

- Reading _all_ their code _all_ the time is unsustainable and quickly becomes a bottleneck
- Not verifying is even more reckless; what is clearly X to you might be clearly Y to them

We need all the help we can get to verify quickly & sustainably.

### Triage

1. What did they say they're _going_ to do? If that's wrong, interrupt and course correct. **1 unit of my time & effort spent; 0 of theirs.**

    > Best time to fix a bug is before it's written.
    >
    > AI coding agents are _really_ good at this: explaining their plan and verbalizing what they're doing. They are basically the model pair programmer interviewees. Puts us human programmers to shame.
    >
    > Pro-tip is to have them write down their plan in a `tasks/{pending|doing|done}-{task}.md` file. It leaves good documentation, helps reel them in when they go down test-fix rabbit holes losing the plot, and even lets us switch between AI models & humans easily.
    >
    > The finishing touch is to have them `[x]` check off the sub-tasks inside the file as we verify their progress.

1. Can it compile? If not, short circuit; no need to look at anything else until this is fixed. **1 unit of time & effort spent.**

    > Good type systems in the category of "if it compiles, it works" really shine when wielded by high output coders.
    >
    > Make bugs into type errors<sup>[[6]](#footnote6)</sup>.
    >
    > The more we can express in the type system, the more we can catch super fast, the lesser we need to verify by running code (last bullet point; orders of magnitude more time & effort).

1. Does the db schema, type definition, type signature changes make sense? If not, short circuit. **1-5 units of time & effort spent.** <sup>[[7]](#footnote7)</sup>

    > Anything else is more verbose, less precise, and less trustworthy than these gems.
    >
    > Look ma, no schema? Implicit function arguments? Such ergonomic conveniences now hurt more than help. Just pass the arguments explicitly, and let the type system do the rest.
    >
    > As the saying goes, _"Show me your flowchart and conceal your tables, and I shall continue to be mystified. Show me your tables, and I won't usually need your flowchart; it'll be obvious."_

1. What does PR description or inline comments say / show? If that's wrong, short circuit. **5-10 unit of time & effort spent.**

    > Again, AI coding agents put most human Pull Request descriptions to shame.
    >
    > Finding a problem here is often faster than finding a problem from test scenarios.

1. Are tests passing and do the scenarios cover what's needed? If not, short circuit. **20-100 units of time & effort.**

    > Humans: are there even tests?

6. Run the code in our head and/or on a machine. **100-1000 units of time & effort.**

### Getting from A to B

I know many teams prefer to use a language & framework to get from A to B fast: it is easy to hire for, easy to learn, easy to write & read. You need to staff up quickly, or if your engineers are already familiar with some tech stack.

Moving forward, we are all augmented with new age high output programmers that don't have these problems: they already know the languages, write them quickly, translate them effortlessly, document them even better. What they need from us is to verify their work quickly & sustainably.

In this new world, are there legitimate reasons to hold on to a codebase

- that doesn't<sup>[[8]](#footnote8)</sup> have sound type checking<sup>[[9]](#footnote9)</sup>?
- that cannot<sup>[[10]](#footnote10)</sup> do parse don't validate<sup>[[11]](#footnote11)</sup> nor make illegal states unrepresentable<sup>[[12]](#footnote12)</sup>?
- that isn't memory safe<sup>[[13]](#footnote13)</sup>?
- that is memory hungry<sup>[[14]](#footnote14)</sup>?
- that is slow<sup>[[15]](#footnote15)</sup>?

Do we prefer something that is good to hire for? Or something that is good to work with?

### Getting to a better B

We are finally truly able to walk the talk of choosing the best tool for the job. I am once again<sup>[[16]](#footnote16)</sup> looking forward to getting to “a good B” fast, instead of only getting from A to B fast.

---

<sub>
<a name="footnote1">[1]</a> [Anthropic Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)
<br>
<a name="footnote2">[2]</a> [Cursor](https://www.cursor.com/en)
<br>
<a name="footnote3">[3]</a> [Codeium Windsurf](https://codeium.com/windsurf)
<br>
<a name="footnote4">[4]</a> [GitHub Copilot - The Agent Awakens](https://github.blog/news-insights/product-news/github-copilot-the-agent-awakens/)
<br>
<a name="footnote5">[5]</a> [Aider Chat](https://aider.chat)
<br>
<a name="footnote6">[6]</a> [Make Bugs Into Type Errors](https://x.com/mattoflambda/status/1008735243581288449)
<br>
<a name="footnote7">[7]</a> Historically, when my leetcoder gets the wrong idea, this is usually where I really find out.
<br>
<a name="footnote8">[8]</a> [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
<br>
<a name="footnote9">[9]</a> [TypeScript](https://www.typescriptlang.org)
<br>
<a name="footnote10">[10]</a> [In Go, the best you can do is make it hard (but never impossible) to produce an invalid value.](https://chatgpt.com/share/67c2900e-6074-8008-9c6b-cf50a9a5adef)
<br>
<a name="footnote11">[11]</a> [Parse Don't Validate](https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/)
<br>
<a name="footnote12">[12]</a> [Make Illegal States Unrepresentable](https://www.youtube.com/watch?v=IcgmSRJHu_8)
<br>
<a name="footnote13">[13]</a> [C++](https://cplusplus.com)
<br>
<a name="footnote14">[14]</a> [Java](https://www.java.com/en/)
<br>
<a name="footnote15">[15]</a> [Ruby](http://ruby-lang.org)
<br>
<a name="footnote16">[16]</a> [Getting to a Better B](https://blog.choonkeat.com/weblog/2018/10/getting-from-a-to-b.html#a-better-b)
<br>
</sub>
