---
layout: post
title: Loremipsumizer
published: true
categories:
- javascript
- software
- Web/Tech
---
I had the need to show some folks example screens of webapps I'm working on recently. Using those screenshots, the other party could have a better feel of things, we could have a clearer discussion. But the irritation [for me] is always the setup

1. The app I'm working on is still in flux, i.e. design & data attributes will likely change, often
2. The content I have is often imported from real data sources, and hence is somewhat private & sensitive
3. I'm too lazy to think up fake names, fake scenarios, fake photos to fill my database, just so I could have a fragile, demo screenshot (I'd need to redo / update later)

What I'd _really_ like is

1. To be able to use my current webapp, as-is
2. To be able to use my current data, as-is
3. To protect private & sensitive data

Smells like a bookmarklet? So here it is[Loremipsumizer.js](http://gist.github.com/585708). After installing it, I can anonymize any webpage instantly (then take a screenshot, annotate or print & discuss with somebody else, without worrying about the sensitivity of content)

[Click here](javascript:(function(u)%7B%20c=document;b=c.body;s=c.createElement('script');s.src=u+'?r='+(new%20Date()).getTime();b.appendChild(s);%7D)('https://raw.github.com/gist/585708/925d9d98ab459feacf3d17568d2d1499157f4970/loremipsumizer.js');void(0);) to try it on this webpage!

The Loremipsumizer will anonymize all text, scramble all numbers, replace images, flash embeds (& video tags?) with wireframe-ish cross-boxes (via data uri). Unfortunately I didn't have an elegant solution to anonymize background images (css sprinting, image size, etc) so I'll need suggestions there.

In any case, here are a few screenshots of webpages I've anonymized. No prizes for guessing which websites:

<object width="400" height="300"> <param name="flashvars" value="offsite=true&amp;lang=en-us&amp;page_show_url=%2Fphotos%2Fchoonkeat%2Fsets%2F72157624856834061%2Fshow%2F&amp;page_show_back_url=%2Fphotos%2Fchoonkeat%2Fsets%2F72157624856834061%2F&amp;set_id=72157624856834061&amp;jump_to="> <param name="movie" value="http://www.flickr.com/apps/slideshow/show.swf?v=71649"> <param name="allowFullScreen" value="true">
<embed type="application/x-shockwave-flash" src="http://www.flickr.com/apps/slideshow/show.swf?v=71649" allowfullscreen="true" flashvars="offsite=true&amp;lang=en-us&amp;page_show_url=%2Fphotos%2Fchoonkeat%2Fsets%2F72157624856834061%2Fshow%2F&amp;page_show_back_url=%2Fphotos%2Fchoonkeat%2Fsets%2F72157624856834061%2F&amp;set_id=72157624856834061&amp;jump_to=" width="400" height="300"></embed></object>

Note: Loremipsumizer does not require any JS library, and have not been tested on irritating browsers. Patches are welcome.

