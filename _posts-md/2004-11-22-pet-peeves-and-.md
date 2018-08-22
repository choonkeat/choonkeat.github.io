---
layout: post
title: Pet Peeves and Java
published: true
category:
- software
---
Had short chat with a colleague this afternoon. She was talking about some pet peeves of hers, regarding Java programming...  
   
 Wai: "I hate it when people (write functions that) return object [] arrays. If you are returning [] arrays, most probably you'd used some kind of Collections to manipulate and finally, return using toArray right? If I need to check that something exists in that array, now I have to (write the code to) iterate or wrap it with another Collection class instance. And then, there's [][]"  
   
 Me: "Its actually Java's fault. It doesn't have native arrays, like Perl. If the language has native arrays, that'll be the default array type everyone uses and you won't have the problems you say. Default hash types, default string types, default numeric types."  
   
 Wai: "No. Its the fault of the schools. They don't teach java.util properly. I mean, you use java.lang and you don't realise it."  
   
 "Hmm", I ate my fried chicken and let it sink in.   
   
 Now.. i think i'll answer, "Not". Its not education, the language should make life easier; not education to teach us how to accept life's like that. If Java can let me write String s = "Hello" instead of enforcing String s = new String("Hello"); Why can't it give me,

 // all examples not limited to Strings of cos, Objects!  
Array list = ["Happy", "Go", Lucky.instance()];  
 list[1]; // gives me "Go"  
 Map keyValue = ["first\_name" =\> "Elvis", "last\_name" =\> "Presley"];   
 keyValue["last\_name"] // gives me "Presley"  
 list.each (String s) { // typecast for me (i'm infected with a bit of ruby here)  
 System.out.print(s + ","); // prints "Happy,Go,Lucky,"  
 }  

   
Obviously somebody's pet peeve was ironed out for Strings..   
  
 Ten years and several versions later, [Tiger](http://java.sun.com/j2se/1.5.0/) is a pat on the back. Its a letdown. If Java was open sourced, the language's grammatical pet peeves would've been addressed by now. Darwin, Darwin.. but, if its so un-darwinian, why is Java still around at all?  
  
10 years, no syntax change, no pointers to explain. What could be easier? I don't even have to zap new notes for the new batch of kids - Yippie! Unless there were deals struck by Sun with all education facilities, that I don't know of, it would appear that the schools unorchestrated-ly robbed the industry by going Java-only...  
  
We've been duped - Tammy Lee, Apprentice  
  
Update:   
[Closures](http://martinfowler.com/bliki/Closures.html)  

[How C# does it](http://joe.truemesh.com/blog//000390.html)  
[How Python does it](http://ivan.truemesh.com/archives/000392.html)  
[How Java does(n't) it](http://article.gmane.org/gmane.comp.lang.lightweight/2274)  

  
  
