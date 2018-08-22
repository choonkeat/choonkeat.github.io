---
layout: post
title: 'Re: Additional Thoughts on Why Ruby isn''t ready for the Enterprise...'
published: true
category:
- ruby
---
I'm _still_ not going to respond to [the complete (longish) article](http://duckdown.blogspot.com/2006/03/additional-thoughts-on-why-ruby-isnt.html).  
   
 First, some agreements,

> Ruby is going down a path of creating their own Virtual Machine. It seems to me, that they should simply put Ruby on the Java VM and not waste efforts in reinventing the wheel

 VM. Sure. Whatever good stuff that comes. What's for keeps is the Ruby **language**. [Avi Bryant](http://smallthought.com/blog/) had even [contemplated](http://paranode.com/~topfunky/audio/2005/Avi-Bryant.mp3) [mp3] that its highly possible having Smalltalk VM (more mature) running Ruby code. Heck, why not?  
 

> Ruby needs to address multilingualization quickly

 i18n. Definitely. Don't be so sure it ain't coming or nearing. Anyways my 2 cents is, I haven't seen any i18n done right (read: development phase). Runtime support for i18n is mature, and that's the easy part.  
   
 Now the negatives,   
 

> Ruby seems to be missing something that is otherwise fundamental in other languages which is support for Regular Expressions

 Holy cow! Missing [regular expressions in Ruby](http://www.google.com/search?q=ruby%20regular%20expression)? That's funny. Firstly, its a common complain that Ruby inherited lots of stuff (good and bad) from Perl, guess what's included? My other 2 cents says that Java happens to have the worst regex support. Of cos, I'm talking about syntax.  
 

> I also couldn't find the equivalent of instance variables. Wouldn't that make reuse at an enterprise-level somewhat problematic?

> Shouldn't the notion of methods being public, private and protected also be a part of every modern language?

 Missing instance variable? Notion of public, private and protected methods? Boy, this guy needs to sit down with Bruce Eckel (Nothing against Bruce, just thought its a funny [de ja vu](http://www.artima.com/weblogs/viewpost.jsp?thread=146091)) Or more accurately, sit down with Ryan Davis.  
