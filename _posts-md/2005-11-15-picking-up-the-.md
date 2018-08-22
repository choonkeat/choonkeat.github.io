---
layout: post
title: Picking up the good habit of Testing
published: true
category:
- software
---
Testing (more accurately, the lack of) has always tugged at my conscience as a software engineer. I never gotten started with the habit of writing test cases. Its always been a manual thing. Furthermore, projects are notoriously good at breaking new grounds in redefining deadlines.. so

"Um.. yeah, writing test cases will be good [to have].. but eh.. lemme finish these first.. mmkay? "   

  
  
[Test-Driven Development](http://en.wikipedia.org/wiki/Test_driven_development) (TDD) says write the tests first, before writing the function. Additionally, when writing the function itself - write it so that it fails - in order to test the test - then debug the function to make it pass. i.e. debugging is hence the default route of development, not something shunned. This is The Right Thing to do... unfortunately like all Right Things (e.g. going for my Tuesdays and Thursdays evening run, [#7 on my todo list](http://www.43things.com/person/choonkeat))... its hard to practise on the ground (defacto response from do-ers when putting off any scholarly advice)  
  
I know myself well enough to know that I really won't be able to get into practising TDD anytime in the near future. Or at least, picking it up just like that. So, I'd decided to tempt myself into TDD,... by doing another easier TDD.. [Test-Driven Debugging](http://radio.weblogs.com/0112098/stories/2003/02/12/testDrivenDebugging.html).  
  
When a bug report is filed, replicate it and confirm the bug report. Next, write a unit test to provoke the occurence of the bug. Only then, do I start fixing the bug and re-run the unit test until it passes. In the past I would've written a fix, and try to replicate the scenario manually and repeat, and repeat until its fixed. Not only does the time spent on replaying the scenario stacks up, the trouble of preparing the test data also invokes another major problem: the flow of programming gets disrupted and I'm out of the zone.  
  
As unit tests gets written bug by bug.. I'd re-run all unit tests and make sure they all passes - before marking a current bug as fixed. This avoids having new fixes breaking old fixes - oh the horror!  
  
Though TDDebugging gives me severely low code coverage, but hey some is better than none. And hopefully by doing TDDebugging, I will build enough good habit to cross the chasm one day, and start doing The Right Thing.  
  
Btw, I find adding new TestCase manually into the TestSuite extremely backward (or maybe I'm doing JUnit wrong, pls correct me). So I'd cooked up [this class](http://blog.yanime.org/src/RunAllTests.java) that automatically picks up (from the classpath) and includes sub classes of TestCase.class and adding them into my TestSuite for execution. Feedback is welcome :-)  
