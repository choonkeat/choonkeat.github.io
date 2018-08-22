---
layout: post
title: What's the Big Deal that Rake is expressed in Ruby, not XML?
published: true
---
This post will probably only make sense to my friend whom I'm responding to his queries "_I need to see some examples to appreciate the impact_".   
  
When I read Martin Fowler's [Rake intro](http://www.martinfowler.com/articles/rake.html), I got a moment of Ohhhhhhh... that I'd have never known , sitting in [Java-cafe](http://www.jroller.com/page/dgeary/20050714). Which also explained why Guido used the words your data when he talks about Python. Different mindset. Different approach.  
  
I'm going through JSF and there's this XML definition.. Don't fight me, I'm not talking specifically about JSF, nor the inputText tag in particular, just using this specific tag as an example:

> \<h:inputText value="#{personBean.personName}" required="true" /\>

  
  
Focus on required attribute and value true. Yes, the designers of tag h:inputText has wisely forseen (can anyone forsee everything?) the need for validation and added a required attribute as a hook. However, since this is just a format (templating language), not the real programming language itself.. you can only say true or false.. in text. The tag would only understand the text true or false.  
  
This is the problem with yet-another-language layered on top of your development language - its never quite full blown. What do I mean? If this definition is in a real language, instead of a XML format.. it would've been possible to, and without any participation from wise designers:  

> \<%= inputText( {"value" =\> personBean.personName, "required" =\> personBean.getRegisteredYear() \< 2000} ) %\>

  
  
Ignore the actual syntax, its my version of script-ish Java.., the main different here is I'm passing in a real boolean value. In fact, I'm passing in an expression.   
  
For expressions to happen in XML-based definitions need to,  

> \<h:inputText value="#{personBean.personName}" required="\<%= (booleanValue ? "true" : "false") %\>" /\>

  
or,  

> String tf = (personBean.getRegisteredYear() \< 2000) ? "true" : "false";  
> ...  
> \<h:inputText value="#{personBean.personName}" required="\<%= tf %\>" /\>

  
etc etc..   
  
For any workaround I can cook up... it must've been catered for by designers of the h:inputText or the XML format. Can I even do '\<%= .. %\>' within attribute values? The answer to the question is not important, the real problem is having to ask it in the first place! Does your templaing language / XML format allow me to do so? If its "yes", you've just been blessed by the almighty designers whom've intently allowed you to. And whatever flexibility they can allow, will always be lesser subset of a full language. In using the invented-for-this-purpose XML-format (e.g. taglibs), you're limited to do whatever they can think of, not whatever you can or need.  
  
Being able to express in a real language is awfully empowering. In this aspect, Rake's approach (think Python-ist subscribes to this notion too) of defining data structures in actual code wins Ant in this aspect, as Ant will always be held back by the XML format that it needs to interpret. Empowerment and flexibility.  
  
Another thing, h:inputText tag may contain some wickedly cool algorithm inside and after all its fancy processing, it prints a \<input type="text".. /\> HTML string. That's it. Can I use that output for other purpsoe? Before it sees the light of day? Can I make it say.. add an onClick attribute to it? Again, the answer itself is non-important. The issue is, the designer of h:inputText must have thought of, and implemented for you some crutch you can use. e.g. creating an extra attribute where u can say   

> \<h:inputText value="#{personBean.personName}" required="true" extra="onClick=\"alert('hello');\" "/\>

  
  
But giving the extra attribute crutch only solves one scenario and definitely pales in comparison to being able to give me back the full string with which I can solve an infinitely more possible twisted scenarios. I can take the generated \<input .../\> string, print it to browser, log it (debugging?), add onClick attribute to it, change all to upper case (for draconian clients), output an encrypted string instead, or eat it and spit it back out. Anything! Power in my hands.  
  
Yes, designers of h:inputText can also give me crutches like print="true", log="stdout", upperCase="true", encryption="blowFish".. but if you seriously take that as equivalent, you're totally missing the point.   
  
Being able to express in a real language is awfully empowering. So. Helper methods rule, templating libs suck because they're inherently single purpose, single environment.  
  
Update: [Similar thoughts on Ant and its XML](http://www.vanderburg.org/Blog/Software/Development/build_languages.rdoc).  
  
Update: Found [this old post from creator of Ant](http://x180.net/Journal/2004/03/31.html).  
  
Update: Another good example of real-language describing template is [Builder](http://builder.rubyforge.org/%20). See [example](http://www.clarkware.com/cgi/blosxom/2005/07/12)  
  
