---
layout: post
title: Upload Applet - Part 2
published: true
category:
- software
---
After many weeks, I'd at last picked up my lazy ass to slap on a drag-and-drop interface to [J'upload](http://freshmeat.net/projects/jupload/) and come up with a [working demo](http://yanime.org/jupload/) [any uploaded file will go nowhere].  
  
Unfortunately, what was achievable fell short of my expectation. The naive goal was to create a firefox plugin that

1. Looks out for any \<input type=file\> tag (any file upload field) in any form rendered  
2. Re-render the field to use the applet (already installed with the plugin)
3. A drag-and-dropped filename will be prefilled into the browse field for the user  
4. The user can thus drag-and-drop files instead of clicking on the 'browse' button, whenever he encounters a upload button  
However, step #3 (using javascript to set the value of a filename) is apparently a severe breach of security and is not allowed on any sane browser. So, unless there's another way around.. this plugin will not happen.  
  
  
