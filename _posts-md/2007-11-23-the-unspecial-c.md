---
layout: post
title: The "No Special Case" Pattern
published: true
category:
- software
---
Very often I'll write (or use) APIs that look like this (translate accordingly for Ruby / Javascript code)

> **Thing** findOneThing( **Key** key);  
> // if nothing is found, throw an Exception or return null
>         
> **Collection** findManyThings( **Collection** keyList);
> // if nothing is found, return null

All well and good? I'd known the textbook-bullet-points for this, but for the longest time, I didn't realize how much tax I'm paying subconsciously.. and just how many APIs are ignoring this wisdom:

> > Nulls are awkward things in object-oriented programs because they defeat polymorphism.[<sup>link »</sup>](http://r9.sharedcopy.com/1nvbt#shcp1)
> 
>  
> 
> > Instead of returning null, or some odd value, return a Special Case that has the same interface as what the caller expects.[<sup>link »</sup>](http://r9.sharedcopy.com/1nvbt#shcp2)
> 
>  
> 
> Not all language can do this easily[<sup>link »</sup>](http://r9.sharedcopy.com/1nvbt#shcp3)
> 
> - from [P of EAA: Special Case](http://r9.sharedcopy.com/1nvbt) via [sharedcopy.com](http://sharedcopy.com)

<style>#shcp_37fafa3939147b8e0f4926089cac28b7 blockquote blockquote { margin-left: 1.5em; font-style: italic; }; #shcp_37fafa3939147b8e0f4926089cac28b7 .html_gist { display: none; }</style><script> var json_37fafa3939147b8e0f4926089cac28b7 = { host: 'sharedcopy.com', width: '480px', height: '250px', bgcolor: '#fff', background: '#fff url(http://martinfowler.com.sharedcopy.com/images/loading.gif) no-repeat center center; ', src: 'http://martinfowler.com.sharedcopy.com/embeds/copy/choonkeat/37fafa3939147b8e0f4926089cac28b7/480.250/e3f0f6.fff.cc0500/shcp1.html' };</script><script src="http://sharedcopy.com/static/embed/script.js"></script>

Finding yourself having to check for null return values? That's not "the way it is", that's tax.

Ruby helps _a bit_ by making "nil" an object, paving way for the much loved duck-typing. Whereas some languages settle for dead bodies equivalent nulls. Especially in these languages, having to "_return a empty object with the same interface_" is a real chore. Person? EmptyPerson. Record? EmptyRecord.. ad infinitum

Still, a language can really only help so much. And it is up to the library authors (i.e. you) to put this wisdom into practice. "Practice?". Now comes the funny part.

When talking about "design patterns", usually images of "Enterprise", "UML", "Configuration files" start appearing in my mind. So I find it ironic that the best real example of this pattern comes from the lowly-regarded (by many "real" engineers) realm of Javascript. Its called [jQuery](http://jquery.com/blog/2006/08/20/why-jquerys-philosophy-is-better/).

In fact, jQuery takes it even further by simplifying Martin Fowler's pattern into a single practical use-case: Returning 1 object is equivalent to returning a List containing 1 object. By **always** returning a List (which can be empty, duh), it has even avoided the need to conjure special "null object with equivalent interface"! And most importantly, "practical" because all languages can do empty list.

Its amazing how simple your train of thought (and code!) becomes when everything is a list (_tiny voice: uh.. Lispers knew that since before you were born... blah blah_). There's nothing to decide, you always loop through the return value. 0 time? 1 time? N times? Imagine all those other idioms & body of code, now becoming unnecessary... its applying liposuction for your source code!   
  
I don't suppose its too far fetched to apply some jQuery-ism to ActiveRecord API is it?

Update: Changed title from "Unspecial Case" to the "No Special Case", which is more correct.

