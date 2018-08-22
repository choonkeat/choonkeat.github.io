---
layout: post
title: 'Yanime: Now, Its Purely Code'
published: true
---
Got this link on Friday, forgot from which of my rss feeds: [Towards Open Source Flash Development](http://www.actionscript.com/index.php/fw/1/towards-open-source-flash-development/)  
  
The article brings together several technologies, that basically gives you: Flash (SWF) development without using Macromedia Flash! For the mavens, this may be old news, but since I'd last touched Yanime... its new to me and better late than never!  
  
Briefly, the article's method uses [MTASC](http://www.mtasc.org/) (a fast, open source action script compiler that produces SWF files. KEWL!) as the main compiler, and Eclipse IDE (armed with 2 plugins: ASDT and [Flashout](http://www.potapenko.com/flashout/)) I could also develop in pure text and produce SWF apps - without ever launching Flash MX2004 :-D  
  
And I did. The just re-written Yanime engine consists of only 1 x ActionScript file. To use a embedded yanime engine, create your own Flash file, and put the following action script:

> loadMovie("yanime.swf");  
> var yanime = new Engine(\_root);

  
  
And pump XML messages to yanime to render avatars or map:  

> yanime.sendXML(xml\_map);  
> yanime.sendXML(xml\_avatar);

  
  
I'll port over those missing features (e.g. speech bubble, networking with XMLSocket) real-soon-now! Source codes and project details... For now, please download here (Update: get from [SourceForge](http://sourceforge.net/projects/yanime/) instead). [Subscribe for subsequent updates](http://www.rssfwd.com/rssfwd/preview?url=http%3A//blog.yanime.org/xml/rss/yanime/feed.xml)!  
