---
layout: post
title: Flickr-Style Listing
published: true
category:
- rssfwd
---
For a lack of better phrase, and I don't know who started this - just that I [saw it on Flickr first](http://www.flickr.com/photos/tags) - I've shamelessly copied the presentation of my "List Of Sites" into Flickr-style, instead of the old, boring, usual, row-by-row listing.. \*yawns\*.. anyways, [check it out](http://www.rssfwd.com/)! [Updated link on 26 Apr '06]  
  
Think I may just put the "You may also like.. " feature soon..   
  
Btw, I'm currently using the following MySQL query to rank the feeds -  
  
SELECT

FLOOR(  

SUM(  

my.num\_of\_subscribers \> your.num\_of\_subscribers OR   
(my.num\_of\_subscribers = your.num\_of\_subscribers AND my.id \> your.id)
) / COUNT(\*) \* 25) + 6 AS rank, 
SUBSTRING(my.title, 1, 15) AS abbr\_title,   
my.\* 
FROM   

feeds my, feeds your   

WHERE   

my.id != your.id AND my.title != '' 
GROUP BY my.id   
ORDER BY my.title ASC;  
  
That's a mouthful!.. Roughly translate to: More subscribers always more popular; if not, newer is more popular.   

- rank: The "/ count(\*) ... as rank" is just to make sure that the range is 6 to 31 (font-ready numbers that I can plug directly in the rhtml file)
- abbr\_title: not in use yet.. was going to control, because some ppl's blog titles are just too damn long! :-D
I couldn't really decide what to do with the feeds that has the same number of subscribers (which happens to be '1' in many cases...) so I chose the lazy option: give the wildcard rankings to new feeds (order by id) so that the rankings will shuffle as new feeds are added - which is likely, since somebody out there is always reading something else.. If I'd given the wildcard rankings to the more frequently updated, then the ranking would've been rather stagnant - personal blogs will never outdo news sites, and news sites has naturally more chance of gaining subscriptions.  
