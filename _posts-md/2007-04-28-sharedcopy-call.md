---
layout: post
title: SharedCopy calls you back
published: true
category:
- sharedcopy
---
SharedCopy launched recently, and today I've released a callback API for it. (See [here](http://sharedcopy.com/public/api))

**What is SharedCopy?**

It is a free webpage annotation tool that just works. Sticky notes on any webpage and share it with anybody by giving the URL. No login required, but account holders get stuff like being able to "lock" and turn off comments, and now setup callbacks.

Latest public comments (from everyone, or from a particular user) is available as a RSS feed.

**What is this callback thing?**

Imagine Sally, the project manager, is checking out out your website mockup. She clicks on a bookmarklet and a toolbox floats over the page on the top-left. She puts a sticky note beside your navigation menu and writes "_TODO: Make this green_", then she clicks "Save". Sally copies the SharedCopy URL, paste it into a new email and say "See here. Do it by next week"

Now, wouldn't it be great if that "_TODO: Make this green_" message magically appears in your Basecamp project as a real TODO item? Or, colleagues can comment on webpages, which gets posted as a real Basecamp "Message" automatically for discussion? Or gets created as a New Bug Ticket? Or gets posted on your blog like a quoted link dump? Or gets bookmarked along with del.icio.us? Or...

That's what a callback is for. When a copy is saved, the comments and etc, are sent (HTTP POST) to a web service for any further processing. As a demonstration, I've actually written the callback integration with Basecamp (see [here](http://sharedcopy.com/public/api)).

But if you're using Basecamp integration for real, I'd advise you host it yourself (for security / privacy reasons), instead of relying on my demo service. My reference implementation is available for download.

