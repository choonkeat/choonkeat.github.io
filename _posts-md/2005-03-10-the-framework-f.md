---
layout: post
title: The Framework For Editing XML Document
published: true
category:
- software
---
<font>Warning: This will get a bit technical for <em>some</em> of you.</font>  
  
I was to post this yesterday night, but too tired and sleepy. Anyways.. I have yet to hear a convincing case against this design, so I'm soliciting for one here if any. Let's say you'll need to do a Graphical Editor application allowing users to do some doodle drawing or whatever, and let them save their art as a file an XML file. A few possible patterns comes to mind.. I'll list them in order of working furthest away from XML to the closest working on XML directly.  
  
**The Candidates**  
  
Method #1 Model Only

1. Read XML from file, and instantiate a DOM object.
2. Parse the DOM, look for specific elements (e.g. \<circle /\>, \<square /\>) and instantiate your corresponding objects for them (e.g. new SquareObject, new CircleObject) and copy the values from XML to your object (e.g. SquareObject.x = Square.getAttribute("x"))
3. Parse until you finish all elements in your DOM, and you now have a handful of model objects in memory.
4. Remove the DOM from memory.
5. Now your Graphical Editor application manipulate your Model objects based on the user s inputs.. Draw a line.. Paint as red.. etc
6. User choose to save, you get your Model objects to spit XML back to you,
7. You piece together these XML fragments to create DOM and save the DOM as the file (overwrite the original file)  

[![](http://photos11.flickr.com/16182853_f094b5fe5e_o.jpg)](http://www.flickr.com/photos/choonkeat/16182853/)

Method #2 Model (Reuse DOM)

1. Read XML from file, and instantiate a DOM object. 
2. Parse the DOM, look for specific elements (e.g. \<circle /\>, \<square /\>) and instantiate your corresponding objects for them (e.g. new SquareObject, new CircleObject) and copy the values from XML to your object (e.g. SquareObject.x = Square.getAttribute("x")) 
3. Parse until you finish all elements in your DOM, and you now have a handful of model objects in memory. 
4. Remove the DOM from memory. 
5. Now your Graphical Editor application manipulate your Model objects based on the user s inputs.. Draw a line.. Paint as red.. etc 
6. User choose to save, you get your Model objects to spit XML back to you set their values back to the DOM  
7. You piece together these XML fragments to create DOM and save the DOM as the file (overwrite the original file) 
  

[![](http://photos13.flickr.com/16182854_3d18b47f17_o.jpg)](http://www.flickr.com/photos/choonkeat/16182854/)

Method #3 Model (XPath DOM)

1. Read XML from file, and instantiate a DOM object. 
2. Parse the DOM, look for specific elements (e.g.\<circle /\>, \<square /\>) and instantiate your corresponding objects for them (e.g. new SquareObject, new CircleObject) and copy the values from XML to your object (e.g. SquareObject.x = Square.getAttribute("x")) 
3. Parse until you finish all elements in your DOM, and you now have a handful of model objects in memory. 
4. Remove the DOM from memory. 
5. Now your Graphical Editor application manipulate your Model objects based on the user s inputs.. Draw a line.. Paint as red.. etc 
6. User choose to save, you get your Model objects to spit XML back to you, 
7. You piece together these XML fragments to create DOM and save the DOM as the file (overwrite the original file) 

[![](http://photos13.flickr.com/16182855_7afb6b788b_o.jpg)](http://www.flickr.com/photos/choonkeat/16182855/)

Method #4 - DOM only

1. Read XML from file, and instantiate a DOM object. 
2. Parse the DOM, look for specific elements (e.g.\<circle /\>, \<square /\>) and instantiate your corresponding objects for them (e.g. new SquareObject, new CircleObject) and copy the values from XML to your object (e.g. SquareObject.x = Square.getAttribute("x")) 
3. Parse until you finish all elements in your DOM, and you now have a handful of model objects in memory. 
4. Remove the DOM from memory. 
5. Now your Graphical Editor application manipulate your Model DOM object based on the user s inputs.. Draw a line.. Paint as red.. etc 
6. User choose to save, you get your Model objects to spit XML back to you, 
7. You piece together these XML fragments to create DOM and save the DOM as the file (overwrite the original file) 

[![](http://photos12.flickr.com/16182856_4552708fec_o.jpg)](http://www.flickr.com/photos/choonkeat/16182856/)

**The Analysis**  
  
**Method#4:** You don't have to be an expert and will be able to tell by the strike-out that Method #4 seems most straight-forward. The only thing is, Step5 (manipulate the DOM) directly in your interface layer just won't cut. That'll be doing classic [XML situps](http://www.rubyonrails.com/). So this is out - unless your editor requires blazing speeeeeed.

**Method#1:** This seem the most common that I've seen. On the hindsight, its surprising to be common. The bad about this design is that values are copied to-and-fro the XML itself. This poses some problems in flexibility in development. You'll need to have **ALL** of the Model classes written and working properly before you can even open-edit-save your first document (Step#7 collects all fragments into 1 XML, missing models == missing fragments == invalid XML).

If you're writing your own Microsoft Word editor ([WordML-based](http://rep.oio.dk/Microsoft.com/officeschemas/welcome.htm)), nobody can ever open-edit-save their Word document until you've 100% finished with your code - if they try before you've done that Model class for less-common features like "themes".. they'll get rubbish XML file that Microsoft Word can't open anymore. Your XML file isn't correct. Misses out on an attribute. Misses out on that Element. Render their data to trash - what's a worse nightmare for beta testers? So you say, To Hell with the testers! "[and we'll ship when we're good and ready](http://www.joelonsoftware.com/articles/fog0000000036.html)" ! This ultimately mean: no early feedback, no rapid application design, no iterative releases, no early adopters, no extreme programming. ZIP.

Don't care about those things? Say after 3 months and you'd sold a million copies. You think about adding this spiffy feature to blink text will sell another million. You change the XML format of your document, update your Model classes and releases V1.1. Will everyone upgrade? No. Tom uses V1.1 creates blinky text, saves, sends to friend with V1.0, opens no blinky text, edits typo, saves, sends back to Tom, open, no more blinky text. Tom asks you "WTF?"

For a moment, drop all arguments of "other people's application also like that" and listen to me: If you can get Tom to see his blinky text - for negligible development effort - why not? Now bring back your "other people" argument - you now have an application that handles backward compatibility like non-other. So if you agree with me that Method#1 is A Bad Thing (yes, you agree), we'll proceed with alternatives..

**Method #2:** To solve the bad of Method #1 (losing unimplemented data), we can keep the original document intact. Upon saving the models objects copy their values back to the DOM and the DOM saves itself. Only the modified portions are modified and everyone is happy. Yay! Yay? No. The only reason anyone would do this, is because they _feel_ too much work has been done using Method #1, they've realised the bad too late and this is simply a work-around.

**Method #3:** The models in this design doesn't hold the values at all. When you getXXX() or setXXX(), the Model objects locate the precise spot in the DOM (using Xpath) and get or set **the values in the DOM directly**. So it doesn't suffer from the bad of Method #1. Your model objects are now just Proxies, or Helpers. You'll only need 1 x XPath-based super class to do your XML sit-ups (trust me, with XPath.. XML ain't situps), creating the individual Models subsequently are just a matter of defining the relative paths (String) in each Model. There isn't any XML to do after the super-class.

Models performing XPath at runtime to get/set values too slow? You can always implement some form of caching there. Remember, writing the models are just specifying strings of paths. No more XML loops, nodes, get text element, hasAttribute.. all these are done by XPath engine and your base class. Development time hastens, users can open-edit-save using your application once you have some of the Models done. If you'd complete the common Models required by your users, they'll be happily using your app whilst you slowly finish off with those unless-but-there features.

**Conclusion**  
  
So, amuse me. Why not Method #3.

PS: Don't give me edge what-if-scenarios and say Method #3 can't handle this - Heck! I never said its silver bullet - if other methods can't handle them too, drop it.

