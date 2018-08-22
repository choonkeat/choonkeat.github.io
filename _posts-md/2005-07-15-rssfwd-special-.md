---
layout: post
title: 'Rssfwd: Special treatment for laggards'
published: true
category:
- rssfwd
---
I didn't notice when but the number of feeds subscribed in Rssfwd seem to have jumped a couple of hundreds since I last counted (quite a number of Bittorrent sites.heh) Unfortunately, that also kind of brought Rssfwd to a crawl. So, in order to minimize the impact of us regular users, I've decided to separate the slower feeds (i.e. huge feeds takes a long time to parse in DOM) from the normal sized feeds.

Normal feeds: 2 hours interval.  
Slower feeds: 6 hours interval.  

  
  
Hope things return to normal hence. Anyone can suggest a faster XML library than [REXML](http://www.germane-software.com/software/rexml/)? Or maybe I should just re-do in SAX.. \*groan\*.  
