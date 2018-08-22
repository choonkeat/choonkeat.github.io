---
layout: post
title: Are you an elephant in a circus too?
published: true
category:
- ruby
---
Years ago I suffered from insomnia and quite often I'd watch TV Media (commercials) just to pass my time. Not all of them feature excited housewifes holding detergents as you'd think. There was this particular commercial (selling motivation tapes) that was quite memorable:

It narrates a story of a boy who saw that the big circus elephant tied to a pole by only a thin rope. "Surely, the elephant could just break its bondage and run away free! Why didn't she?" the boy asks. The father replied, "You see, when the elephant was little they'd tie her up in huge chains instead of this rope. The baby elephant would try with all her might to escape but in vain. Years of trying (and failing) has etched a strong message into her head: _I'm tied here. I can't get away_. So now, the circus only has to use a thin rope. She won't be trying to go anywhere."

I'm reminded of this story just last night, after realising that I'm like the elephant in the circus.   
  
<font>Warning</font>: This is not a shining example of _best practices_! Do not meddle with production systems in situ! ?”?”æœ‰ç»ƒè¿‡çš„!  
  
Problem: I have a command line script doing some processing in a running system, but I wish to experiment a new little feature without impacting the existing system. What are my options?  
  
Normally I might prepare another copy of the same system (i.e. staging area), make code modifications and try running the new feature in the staging environment. Once things looks ok, I'll patch the running system with the new code, and hence roll out the changes. In systems where the setup involves a few external systems, setting up a staging area can be a pain.

I was too tired and lazy to prepare a staging area last night. Then, it occurred to me (ok, i'm slow) that with Ruby, I have [open classes](http://onestepback.org/articles/10things/page024.html) - something I that do not have in my previous life! I've already been bathing in [the goodness of open classes](http://onestepback.org/articles/depinj/classesareopen.html) while developing Rails apps - when I use the test and plugin framework, etc - but I was still dutifully going through the staging environments way.

So I made a copy of the script (the main logic is in the other parts of the system, this script is merely the entry point to kick off the whole process). And in this new script, I added code that redefines the behavior of a class in the system:

    _<font># import libraries above</font>_
    
    **<font>class</font>** FeedTodo
    **<font>def</font>**  **<font>deliver_emails</font>** <font>(</font>emails<font>,</font> forced<font>=</font> **<font>false</font>** <font>)</font>
    **<font>save_to_disk</font>** <font>(</font>emails<font>)</font> _<font># instead of sending the mails directly.</font>_
    **<font>end</font>**
    **<font>end</font>**
    
    _<font># actual execution below</font>_ 

When executing from this particular script, FeedTodo objects would no longer be delivering emails directly because I've redefined them to save onto the disk instead. The other parts of the system would happily continue to call FeedTodo#deliver\_emails() as usual, invoking the new routine unsuspectingly. Also, the existing system which doesn't use this new script would not have this modification in their runtime - hence, no impact to production system!  
  
In my past life, I would have to change the actual code for FeedTodo class and risk breaking the production system. Blasphemy! Occasionally, when I do, I'd even take pride that I can make such in situ changes backward compatible - feels like Indiana Jones swapping the weighted stone...

I've realised I'm not chained like I thought I was. I don't think I'll ever need to take such stone age risks anymore.

