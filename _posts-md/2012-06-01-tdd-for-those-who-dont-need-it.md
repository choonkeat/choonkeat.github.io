---
layout: post
title: TDD for Those Who Don't Need It
published: true
---
A public service announcement: There’s still a lot of pretty good programmers who don’t write tests… and programmers who write tests are not necessarily any good.

It is easy to forget that. [BDD](http://en.wikipedia.org/wiki/Behavior_Driven_Development)/[TDD](http://en.wikipedia.org/wiki/Test-driven_development) propaganda can be a thick fog.

A year ago the only “BDD” I’d done was “Bug Driven”, i.e. “Bug in production? Add a test & fix it”. There were no test culture from where I began writing code and we write code by simply writing the code. New, file, tap tap tap, run; That’s how we do it, that’s how we’ve been doing it, work gets done, everyone is happy.

Nowadays, there’ll be TDD folks sweeping in to shame you into writing tests. “Oh, you DON’T write tests? Then how can you possibly be sure your code is correct?!11 Fwahahahaha.” “I did test it myself. It’s in production and it works.” Still, you might eventually succumb to such peer pressure and decide to “write some tests” in your next project… only to find it tedious, distracting, cumbersome & standing between you and your deadline. No more tests in the next project.

My issue is, every sell for TDD has to do with some future benefit: Tests give you confidence to refactor [next time]. Writing tests makes your design better [you’ll be thankful next time]. Tests serves as documentation [for the next developer, or yourself next time]. Untested code is legacy code [when you have to touch it again, next time].

Well, [YAGNI](http://en.wikipedia.org/wiki/You_ain't_gonna_need_it) is a good principle too, and it can apply here.

Perfectly capable programmers, who don’t currently write tests, are not actually _against_ having confidence to refactor, _against_ better api design, _against_ having documentation, or _against_ maintainable code. It is pointless trying to convince them the benefits of that. In fact, chances are (believe it or not) they strive for that harder than you might imagine - they probably know their patterns of refactoring, may have solid habits of writing javadoc/rdoc/etc doc, and are likely to leave great commit messages too. They have different [arguably inferior] means at their disposal, that’s all.

On the other hand, something that’s not YAGNI, and a very real issue of writing software, is the amount of information you have to hold in your head at the same time. Writing a feature of many moving parts is almost magic, this piece here, that piece there, fits perfectly somehow and everything works. On a good day, the programmer is in The Zone, pieces fit effortlessly. On a bad day, maybe nothing gets done. That’s why the headphones. That’s why the night shift, morning shift. And if you’re not a programmer, that’s why your programmers bite when you approach their desks - you missed the sound of a thousand and one intricately placed detail crashing down like a house of cards, when you slap their back, “Hey, how’s it goin?”

What eventually got me into writing tests, was a point about TDD that is often buried, not clarified & maybe mentioned in passing. (On hindsight, I realise most TDD materials are meant to convert TDD folks of a different sect, and not really meant to get outsiders _into_ TDD) An example is in [this RailsCast, at the 4m37s mark](http://railscasts.com/episodes/275-how-i-test), Ryan Bates made a throw away comment, _“I really like this approach of testing, it just walks you through: what’s the next step I have to do to get this working.”_. Though this may seriously not be the most important benefit for most TDD advocates, but as a reason to start adopting TDD…

That. Was. It.

Writing your test first is like putting a golf flag at the hole.

<figure><div><table><tr><td><pre><code><span>it "emails user when requesting password reset" do
</span><span> user = Factory(:user)
</span><span> visit login_path
</span><span> click_link "password"
</span><span> fill_in "Email", :with =&gt; user.email
</span><span> click_button "Reset Password"
</span><span>end</span></code></pre></td></tr></table></div></figure>

Now that the flag is planted, the actual work of “writing the code” becomes an almost mindless stroll of hitting the ball towards the flag - fixing the next error thrown from the test: _“error: no link with title, id or text ‘password’ found”_ ok, let’s add that ‘password’ field; _“error: `new\_password\_reset\_path’ undefined”_ ok, let’s add that ‘new\_password\_reset\_path’ route; etc until there’s no more errors. Then you’ve reached the flag. The feature is done. And chances are, you haven’t even needed to launch that browser to “check”.

_(If your test code can’t produce “reads like english” code like the above sample, then just write your steps in prose first. You can add test code next to the [then commented out] prose later. The end result is the same, and fwiw I actually do prefer test code to read like code than english-y dsl)_

This approach addresses the “house of cards” issue by helping you persist details quickly, and often, into writing. Interruptions are still annoying of cos, but you can survive them better now: the next error is always clearly in sight, just solve it to move on to the next error. Next boss to kill, in a mindless arcade. In fact, you can leave it “half done” and come back tomorrow without missing a beat, or requiring “boot up time” (recalling & loading details back into your brain) before you get started.

Certainly this isn’t a silver bullet for all scenarios, but it’s been effective enough for me. I’d found myself ploughing through features steadily despite being drowsy from flu medication or being interrupted by loud wails across the room (I’m also a stay-home dad to my 4-month old baby).

So, if you’re a good programmer but not writing tests yet, hopefully this can strike a chord with you and get you started. A word of caution: there is just TOO MUCH testing libs out there, learning about most them is simply a waste of time. Just use the bare minimum & get going.

PS: This is known as the “red/green/refactor” mantra, which like a company mission statement, fail to appeal to me in _any_ way. [Wikipedia](http://en.wikipedia.org/wiki/Test-driven_development), ”_TDD constantly repeats the steps of adding test cases that fail, passing them, and refactoring. Receiving the expected test results at each stage reinforces the programmer’s mental model of the code, boosts confidence and increases productivity._” zzzzz zones out… um, watever.

[Update 27 Sept 2012]

> Working in the head doesn’t scale. The head is a hardware platform that hasn’t been updated in millions of years. To enable the programmer to achieve increasingly complex feats of creativity, the environment must get the programmer out of her head, by providing an external imagination where the programmer can always be reacting to a work-in-progress.
> 
> – “Learnable Programming: Create by reacting”, [Bret Victor](http://worrydream.com/LearnableProgramming/)

