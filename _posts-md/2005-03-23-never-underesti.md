---
layout: post
title: Never Underestimate The Power Of 'It Just Works'
published: true
category:
- rssfwd
---
_Update: Rectified the title of this entry \*sheepish\* Didn't realised it was truncated by plog_

In a perfect world, a user will give RssFwd a feed url [[example](http://blog.yanime.org/xml/rss/feed.xml)] and RssFwd will display a nicely formatted preview [[example](http://rails.yanime.org/rssfwd/preview?url=http%3A//blog.yanime.org/rss/rss20/1)]. At the bottom of the preview page, the user can choose to subscribe by entering his email and submitting a form. Q.E.D.  
  
However, this isn't a perfect world, and instead of the feed url, users often give the main url of the site [[example](http://blog.yanime.org/)] or anything they see in their browser location bar. For such cases, RssFwd chokes and show an unfriendly page, "You \*\*\*\*\*! That's an invalid RSS/Atom feed url!", and prompts the user to try another url... as if he'll understand now that he's been lectured. And as far as I know, this is apparently the usual behavior of most rss applications - stopping at the scary, but friendly-worded error message.  
  
But educating newcomer folks on "How to locate the xml/rss/atom icon", or "Right-click \> copy link" (for feeds that show 'Download/Save-As?' when you click on them [[example](http://www.joelonsoftware.com/rss.xml)]) seem like an awfully uphill task; On the other hand, sitting back and relying on the masses to catch-up will only hinder adoption of that RSS thing. Unnecessary delays.  
  
So, I guess the easier way is to educate the web-publishers. Since you are publishing feeds already, I'd figure you'll care more. Publishers, (most major blogging tools already does so) make sure your pages carry the link ref=alternate tags. Btw, this same tags that lets Firefox show that orange icon on the bottom-right. Such tags allows programs to know that your page has feeds, and what are the feeds.  
  
Now, if RssFwd cannot preview a given url, it will autodetect for hidden link ref=alternate tags and check to find the actual feed on behalf of the user. Meaning, [previewing (a main page)](http://rails.yanime.org/rssfwd/preview?url=http%3A//blog.yanime.org/1) will just work ([Rule #1](http://www.reemer.com/archives/2005/03/17/etech_joel_on_misattribution/index.php)). No more errors\*.  
  
Initially this was done for the benefit of RSS-challenged folks... but I'm beginning to find that.. I'm liking the convenience myself. So, for any webpage, you can dive straight into [preview](http://rails.yanime.org/rssfwd/#previewform) - If there's a feed, it'll pick up for ya. No more icon hunting.  
  
\*Disclaimer: Websites with no RSS/Atom feeds at all [will still not render](http://rails.yanime.org/rssfwd/preview?url=http%3A//www.google.com/).

  
