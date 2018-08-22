---
layout: post
title: JDWP is underrated. Why?
published: true
category:
- software
---
[Java(TM) Debug Wire Protocol](http://java.sun.com/j2se/1.5.0/docs/guide/jpda/jdwp-spec.html) allows a debugger to work from a different machine than the process itself. But that's just a technical benefit.

A server (e.g. [JBoss](http://www.jboss.com/products/jbossas)) started up with JDWP enabled will be ready to be plugged-in for debugging anytime. An [Eclipse IDE](http://www.eclipse.org/) holding a project's source code [can connect to such servers anytime](http://www.eclipse.org/eclipse/faq/eclipse-faq.html#users_18) and start a debugging session. The server is already running the binary classes, the IDE holds the source files.

Let's not treat is like a debugging session (sounds like an 'other thing to do'), take it as a development session...

Through a browser, the developer can go about his routine navigations \*click\* \*click\* and development \*click\*. When required, set a breakpoint in his source code (Eclipse) - back at the browser, do a form post, and Viola! the browser is kept spinning, JBoss comes to its knees, [Eclipse highlights the line-of-code](http://www-128.ibm.com/developerworks/java/library/os-ecbug/) where we've paused and asks, '_The world awaits your wish, sire?_'

At this moment, you can inspect variable values, make changes to the source code and save - Eclipse will compile your code automatically and update the remote class for you. Then you click resume in Eclipse, and everything else springs back to life - with the changes taking effect. Change source codes, save, see effect. In rapid fire succession. JSP already auto-compiles, now I can do the same for controllers. I can live with that.

I think app servers should come default in "development mode" with JDWP enabled (production install in enterprise setting always needs to be tuned anyways). Such things shouldn't be left to be discovered. Or am I missing something here? Or because JDWP doesn't handle _some_ edge cases, so its not _good enough_ to be turned on?

