---
layout: post
title: Batteries Not Included
published: true
category:
- life
---
Am looking into databases that can be easily distributed with our company product. Fuss free, worry free, blah. The current product relies on Oracle/MySQL setup. It stores many states/configs etc stuff. But the question is, why does an app server require a database? Applications requires database, that's understandable.. but the app server? Install is not enough? I need a something else (db) installed and configured before this thing runs??  
  
So, I embark on a (personal?) journey to pick the lightest, appropriate solution to act as the app server's internal datastore - separate from the datastore that the application developers will be using. The aim is to magically remove dependency of a database (perception) but still continue to operate as-per-normal.  
  
First I found [Cloudscape and IBM's big-fan-fare release](http://developers.slashdot.org/developers/04/10/27/0459213.shtml?tid=221&tid=198&tid=136&tid=108&tid=8&tid=2) of [Derby](http://incubator.apache.org/derby/).. then [HSQLDB](http://hsqldb.sourceforge.net/) starts propping up from under the carpet (eh, its inside my JBoss directory.. didn't know that).. then I'm greatly humbled and eternally grateful for [this article](http://technology.amis.nl/blog/index.php?p=203), "Talk on Open Source Databases". Anyone shopping for a DB should look through the slides.

