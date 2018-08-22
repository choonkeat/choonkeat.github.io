---
layout: post
title: Browser-based Application
published: true
category:
- software
---
Its quite common to mis-position a new technology (e.g. [paper](http://educ.ubc.ca/courses/lled301/textbook/multimedia/timeline.html) was first used for wrapping, only later for writing). Rails and Ajax could be one of them.   
  
A wrong battle is being fought out there - and this one is probably as wrong as how we were once sold on an interactive technology called the Java Applet.  
  
Some might scoff at Web2.0 attempts like [Writely](http://www.writely.com/) to replace MS Word, or [NumSum](http://numsum.com/scratch/new) replacing Excel. I believe its not about whether they can match feature for feature (they can't) since good enough is often good enough, and people will be willing to settle for common features. But rather, its more against the idea of using a somewhere-out-there 3rd party tool - Hey, can I trust them with my confidential data? Also, I do need it tomorrow noon ya know? "We're currently down for maintenance" will be the last thing I want to see. Its the same distrust that some people still have, that they'd print out on paper even if when they own the softcopy: its somewhere-out-there in that harddisk, I'd rather file a physical copy in the cabinet.  
  
This generation think-gap can be bridged. If you can use Writely as a desktop word processor, would you? Network connectivity is optional (for some online-payable services, watever), but not necessary. If its in my computer and I can use it as and when I like, what do I care if its actually "browser-based" or a "native window" application? When I click save, the file is saved in my folder, in my harddisk. Mine. Mine, mine, mine.  
  
The good thing about deploying web technology on desktop is the recycling of skillset and technology - regardless of writing for desktop or the web, a developer would never have to leave his comfortable browser + database technologies. The same app can be hosted (newer generation: my data is always-on, yippie!) or run as plain-old Mac app, Windows app, or Unix app. OpenOffice, for example, uses [HSQLDB](http://hsqldb.org/) as its storage so its not news that traditionally client-server technologies are finding their way to the desktop. Why bother with platform dependent widget libraries (gtk? qt? swt, swing, cocoa?) when there's the omnipresent HTML + browser combo, readily available even in handhelds? Without a network roundtrip, the UI will be responsive. For a number of applications, such a setting is probably good enough.  
  
So, in such a desktop app, the underlying web platform would preferably be light-weight instead of scalable N-tiered. No kitchen sink Weblogic, sorry. Webrick or Lighty will do just fine. Served from flexible ports please, we don't want to see port-already-in-use when its just me trying to edit my spreadsheet. No Oracle-the-overkill too, not even MySQL. Sqlite will suffice - something with no extra config, cross platform and doesn't require a separate install.   
  
Hence, regarding the "wrong battle", the impact of Rails + Ajax might not be in the JEE or .Net realm after all. [Rails'](http://www.rubyonrails.org/) strength is in providing a productive, consistent and simple platform. Ajax pursues to deliver [complex, responsive UI](http://www.backbase.com/) via the browser. Riding on the re-ignition of browser technologies, the real playground, as the famous saying goes: [Its the desktop, stupid](http://www.google.com/search?q=Its%20the%20desktop%2C%20stupid).

