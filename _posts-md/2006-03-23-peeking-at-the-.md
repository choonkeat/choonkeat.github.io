---
layout: post
title: Peeking at the Browser's History
published: true
category:
- software
---
Web Developer's Quiz: Your website needs to somehow **_know_** what are the other websites a user had already visited. How do you do it? How do you get the information from a browser history?

[Kevin Burton](http://www.feedblog.org/) pulled it off with a neat trick. When the new features of his Tailrank were [released](http://www.feedblog.org/2006/03/tailrank_launch.html). I must've been sleeping or busy, anyways, didn't check out the improvements in Tailrank till now.

Under "[import](http://tailrank.com/import)", a user usually uploads his OPML file (which I'd [previously talked about](../../articles/2006/02/21/tailrank-personalised-google-news-for-blogs)), input some URLs, etc. In his attempt to make Tailrank's import applicable to more layman users, Kevin has a new "Auto Configure" button. Click on it, and a list of popular sites (that you have visited) are found and is ready for import. Damn, how did it know!

I did some view-source hunting and found [document.defaultView.getComputedStyle](http://www.faqts.com/knowledge_base/view.phtml/aid/7157) and [element.currentStyle](http://www.thescripts.com/forum/thread89231.html). Explain: Given that your browser will style visited links differently from link not yet visited, Kevin merely printed a bunch of hidden links and used a javascript to pick out those you have visited! Woot! I can sure find some use for that... hmm.. can't think of any now, but I'm sure there're uses!

That said, I would've preferred if Tailrank actually gave me the option to uncheck some of them from my list (especially since removal of feeds isn't implemented yet)

