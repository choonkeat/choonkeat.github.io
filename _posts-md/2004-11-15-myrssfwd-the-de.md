---
layout: post
title: 'myRssFwd: The Desktop Application'
published: true
category:
- rssfwd
---
Despite the initial frustration with the lack of robust, 3rd party Ruby libraries (coming from perl programmer perspective, hey whaddya expect!), I'm beginning to feel fuzzy with my choice to switch from Perl (v0.1a) to using Rails (v0.2). Building [RssFwd](http://rails.yanime.org/rssfwd/) on top of Rails, I get a few things for free. And they prove to be quite useful to extending a quick-hack into something more. Right now, most probably v0.3 will be about "myRssFwd". For running on individual desktops, or a peer server.  
  
Once unzipped, [Rails comes with WEBrick ready-to-run](http://www.chadfowler.com/index.cgi/Computing/Programming/BoringSoftware.rdoc,v). Meaning, having developed RssFwd on my Apache+MySQL+Rails server, I can easily turn it into Rails+SQLite - an distributable unzip-and-run solution. Anyone can then run their own copy on their desktop - just like [popheadlines](http://graemef.com/?q=project/popheadlines) which I was originally using. The same code. Standalone or server-based. Ready to distribute.  
  
Did I mention I love [self-contained, unzip-and-run](http://www.instiki.org/show/HomePage) softwares?

