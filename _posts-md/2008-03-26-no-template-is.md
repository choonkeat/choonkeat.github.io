---
layout: post
title: No Template is the Best Template
published: true
category:
- web
---
Update 28 Sept 2008: checkout the working code at [github repository](http://github.com/choonkeat/hquery/tree/master), and a short [video demo on vimeo](http://www.vimeo.com/1836815).

I've been swimming in jQuery-bliss for a few months now - thanks [Divya](http://nimbupani.com/) & [Tien Dung](http://free-and-happy.blogspot.com/) for introducing me to it! I'm yearning to [do it on the server-side](http://ejohn.org/blog/bringing-the-browser-to-the-server/).

But to enjoy the jQuery-bliss (aka "[no special case pattern](http://blog.choonkeat.com/weblog/2007/11/the-unspecial-c.html)"), I'd need to be in a problem where I have a document to sculpt. My recent toys ([cleartz](http://dev.choonkeat.com/js/cleartz/index#,Singapore,San_Francisco_CA,Berlin) and [tryanslator](http://dev.choonkeat.com/js/lang/index).. and actually most Javascript apps?) for example, are built the via sculpting way: a very basic HTML structure, then Javascript comes in to flesh out its form and introduce function. A very pleasant development experience overall.

_Aside: Back in Java days, I remember I used to hate XML DOM parsing a lot. `NodeList`? `hasChildNodes`? But XPath came and suddenly pain became pleasure._

On the server-side, Model (of MVC) stuff seems to fit (maybe `sqlQuery( "people[gender='Male']" ).update({ salutation: "mister" })` ?) but ActiveRecord (& [Ambition](http://errtheblog.com/posts/63-full-of-ambition)?) is already nice to work with, and I have no major problems there.

My gripe is with the View (and consequently the Controller). Views are generally powered by some templating system. These gnarly things are just a pile of bastardized HTML files good for neither designers nor developers. The best templating systems are only best because you'll choke yourself slower by using them. Anyways, pretend you agree that templates == bad.

Wouldn't it be nice if your web framework 1) loads up pure HTML as a document object, 2) you modify them in the jQuery-bliss way in your Controller, then finally 3) the resulting HTML is spit back to the client browser?

No nasty \<? %\> } or custom syntax for dynamic content, or loops, or if-else. Just pure HTML with dummy data baked in.

> # display\_user.html
> \<span class="tel"\>
> \<span class="type"\>home\</span\>:
> \<span class="value"\>+1.415.555.1212\</span\>
> \</span\>

Then modify them before serving:

> # inside controller
> def display\_user(doc)
>  user = User.find( params[:user\_id] )
>  (doc/".tel .value").inner\_html = user.phone\_number
>  return doc.to\_html
> end

And because it is an in-memory tree instead of some opaque String, you can do everything programatically _around_ the document: looping, if-else, removing nodes, replacing sub menus, partials? Furthermore, when you need to do dynamic behaviors on the client-side, the programming paradigm is exactly the same!

Designers can be happy churning out the HTML/CSS in whatever tool they like (be it Dreamweaver or notepad.exe), and developers just poke their DOM.

What say you?

_PS: Oh well, I guess what I'm trying to say is maybe we should not waste time finding better ways of constructing webpages (i.e. templating systems) when we could approach the problem as "modifying a document" - which is much cleaner and (with the [right API](http://blog.choonkeat.com/weblog/2007/11/the-unspecial-c.html)) much easier._

