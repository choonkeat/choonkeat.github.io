---
layout: post
title: Migrating Typo to Typepad
published: true
category:
- life
---
I've just migrated this blog from old Typo to [Typepad](http://www.typepad.com/), and hence completing my technology adoption cycle (for this area):

> Phase 1: Unexplored realm! Read  
> Phase 2: Hands-on. Learn  
> Phase 3: Move on

Phase 2 often implies acts of compiling, scouring forums, reading HOWTOs, configuring and hosting my own, e.g. Qmail, blog, etc. Phase 3 doesn't always imply learning _everything_ about it, but usually learning enough to be reserving time & resources for other unexplored technologies.

So, apologies for raising false alarms in feed readers of new posts. Isn't the point of Feedburner to make blog hosting migration seamless?

Anyways, I'd secretly been wanting a Wordpress blog for a while now (only because it has a beautiful interface and big serif fonts. I'm soooo superficial!), so was checking out Wordpress.com for a while. Unfortunately, they don't do Feedburner and, to make things worse, [they just killed their own feed statistics as well](http://wordpress.com/blog/2007/06/13/retiring-feed-stats/).

Next, Blogger.com - with a name like that, you just know they're the right choice aye? Blogger has Atom APIs (cue Phase2) and Feedburner integration ([of course](http://www.techcrunch.com/2007/05/23/100-million-payday-for-feedburner-this-deal-is-confirmed/)). Great! But they have butt ugly templates. I convinced myself that can change later and I proceeded to write a little Typo2Blogger importer using [GData-Ruby](http://rubyforge.org/projects/gdata-ruby) (Phase2!).   
  
1... 2.. 3... 40... 41.. Beep! I was stopped before attaining [the meaning of life](http://www.google.com/search?q=answer%20to%20life%20the%20universe%20and%20everything)! The script ran smoothly but everything after 41st import was ignored. [They think I'm spam](http://help.blogger.com/bin/answer.py?answer=42578). Lots of people were apparently bitten by this as well. One user suggested contacting the Admins, and subsequently migrating only 5 post a day to keep Blogger.com happy. Kowtow? Tsk tsk. If migrants are not welcomed, then fine. Without proper comments import, the prospects weren't too hot in the first place \*sour\*

That leaves us with [Typepad](http://www.typepad.com/). Feedburner, [check](http://www.sixapart.com/typepad/news/2006/06/typepad_and_feedburner.html). Full import, [check](http://support.typepad.com/cgi-bin/typepad.cfg/php/enduser/std_adp.php?p_faqid=197) (the prehistoric, non-XML format worked flawlessly on first try). Can't be that bad. At least [Amber](http://ambermac.typepad.com/) seems happy using it.

