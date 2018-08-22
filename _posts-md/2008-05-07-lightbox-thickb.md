---
layout: post
title: Lightbox, Thickbox, Greybox - Ugh
published: true
category:
- web
---
I dislike the increasing (still?) trend of websites deploying a [lightbox (or thickbox) effect](http://www.front-end-developer.com/2008/04/11/top-17-css-lightbox-variations/). Not so much for the [strobing visuals](http://www.37signals.com/svn/posts/592-been-lightboxed-lately), but more because it is nothing but an irrelevant technique dragged over from the desktop world to the web - just for the sake of familiarity.

> <input>
>  
> 
> > Modal dialog boxes are those which temporarily halt the program in the sense that the user cannot continue until the dialog has been closed[<sup>link »</sup>](http://r2.sharedcopy.com/6e62cu1l#shcp0)
> 
>  
> 
> > Modal dialogs are generally regarded as bad design solutions by usability practitioners, since they are prone to produce mode errors .[<sup>link »</sup>](http://r2.sharedcopy.com/6e62cu1l#shcp1)
> 
> - from [Dialog box - Wikipedia, the free encyclopedia](http://r2.sharedcopy.com/6e62cu1l) via [sharedcopy.com](http://sharedcopy.com)

<script> var json_10954 = { host: 'sharedcopy.com', width: '480px', height: '250px', bgcolor: '#ffffff', background: '#ffffff url(http://en.wikipedia.org.sharedcopy.com/images/loading.gif) no-repeat center center; ', allow_click: false, src: 'http://en.wikipedia.org.sharedcopy.com/embeds/copy/choonkeat/ce3099e0d4c6f37ba4ba2f03c16c2f3b/480.250/ffffff.ffffff.cc0500/false/shcp0.html' };</script><script src="http://sharedcopy.com/static/embed/script.js"></script>

The web is free flowing and has [no vertical](http://twitter.com/choonkeat/statuses/103816122) [constraint](http://blog.clicktale.com/2006/12/23/unfolding-the-fold/). And it's good that way!   
  
My personal preference as a developer is to use div-expansion/collapse **everywhere** possible, until I can't. By introducing new content in-place, and reflowing the rest of the document, a user is not required to take action just to back out. If he choose to proceed, he can interact with the new content (usually a form), or simply continue browsing, scrolling down or click elsewhere.

Even if situation calls for a lightbox-ish design, it isn't too much to ask for [as much of the] surrounding content to be pushed aside whilst showing a thickbox at the centre of the screen. You get to reduce overlap & maintain document flow at the same time.   
  
Try it, click on the Wikipedia quote above. Though the right columns of this blog is obscured by virtue of their floats, the content of this entry will remain in full view.

