---
layout: post
title: I *Heart* Scripting Language
published: true
category:
- software
---
When I first found Perl, coming from C/Java world... I fell in love with it. Writing in perl was snappy. No beatin' them round those bushes when looking for money:

> open(FILE, "bushes.txt");  
> while (\<FILE\>) {  
>  printf if (/money/); # prints all lines that has 'money' in it..   
> }  
> close FILE;

   
Fresh from school of C/C++, I'd never knew working with files was so easy and concise! Then came the real addictive @arrays.. [push, pop, split, join, each, splice](http://www.pageresource.com/cgirec/ptut11.htm),... life was good! (and I haven't even mentioned %hashes!) In fact, it was so good I started writing myself helper classes in Java just so I can think naturally - and giving runtime performance the middle finger, "Development time costs more than CPU cycles" I'd say and only did optimisation when there's production need - which turns out rarer than I'd expected. Not all of us work in million-hits-per-second mega online store. And as history goes, Java did eventually come cosy up with split as well. Only split.   
  
And when I first saw Ruby it was the each syntax that caught my eye. I could only say OMG! But Martin Fowler has articulated [the power combo of closures and collections [very good read]](http://martinfowler.com/bliki/CollectionClosureMethod.html) very well. Even recently as I was showing [The Rails video](http://weblog.rubyonrails.com/archives/2005/07/08/new-rails-movie-with-sound-and-sugar/) to some colleagues, I find myself repeating this disclaimer each time: Oh, this [benefit] is Ruby - not Rails per se - a scripting language's arrays is always more powerful.  
  
Was at a Java event a few months back where the presenter was talking about Java 1.5 features. Most of the stuff were so-so to me, until he said something like (not quoting here): We did not introduce a 'foreach' keyword because we're very careful not to break existing codes,... then goes on to introduce the new enum keyword. Duh. How is foreach more probable to break existing codes than enum? I'd even bet its totally the other way round.  
  
Btw I haven't investigated enum, but my gut feel tells me - its an unnecessarily complex beast that is only waiting to contribute to [anti-patterns](http://www.antipatterns.com/thebook.htm).  
  
enum. foreach. I can't understand [why the priorities are such](http://blog.yanime.org/articles/2004/11/22/pet-peeves-and-java). really.  
  
update: yea, I know the stuff mentioned above were wee bit outdated. but reading martin fowler did me in. i'm hoping [an open source movement](http://developers.slashdot.org/article.pl?sid=05/07/22/145210&from=rss) will put enough pressure to steer the language's priorities.  
  
update: its my hypothesis that a language needs only to provide good grammer for list and strings (includes regex) to be useful. runtime performance should be dealt with aside of grammar.