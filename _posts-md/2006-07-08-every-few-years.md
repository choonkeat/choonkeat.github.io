---
layout: post
title: Every few years, some shit must happen
published: true
category:
- ruby
---
Bitten by a 32-bit bug today when my colleague decided to have 3006 as his end-date in the database.... BOOM.

Apparently, the upper limit is closer than a thousand years. Its [2038](http://en.wikipedia.org/wiki/Year_2038_problem) to be exact. Damn. That's within a lifetime.

<iframe src="http://groups.google.com.sharedcopy.com/embeds/copy/choonkeat/5bceff739f0c5f7d8c51cef213488560/480.250/e3f0f6.fff.cc0500/shcp1.html"></iframe><noframes>Your browser does not support frames, but you can still read the <a href="http://r0.sharedcopy.com/2rprvn7">sharedcopy content here</a>.</noframes>

Cold cold warning. Monkey-patched a few classes and the situation seem under control. We'll see.

