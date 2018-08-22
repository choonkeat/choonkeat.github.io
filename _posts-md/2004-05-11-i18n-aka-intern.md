---
layout: post
title: i18n.. aka Internationalisation
published: true
category:
- software
---
I'm mainly involved in Java programming, hence the ResourceBundle is synonymous to i18n. Its a good framework at runtime (when the program is running).. but one's gotta admit is a very expensive process at codetime (when writing the program). Its a pain to introduce the map languages, strings, keys for the sake of "multi-lingual support should the product ever go into the China/India/<insert></insert>(insert your favourite country) market"..   
  
GUI IDE (integrated development environment) only takes 1 step closer by helping you with GUI tables for managing the i18n text.. but its still a very painful process.  
  
Luckily there is a better way!  
  
Why not do i18n as a post-thought. i.e. Write applications like they're only for your native language (that's how everyone intuitively does it anyways).. and only add i18n support when you need to the product to do so. It can be a pretty GUI ant-task that parses the source code, looks for static strings (for HTML codes, any text that is not embraced within angled brackets) and checks with the user how the string should be i18n. The user-experience to run such a post-production process would greatly mirror those doing a spell checker in Word (-gasp- i'm quoting MS again.. i must be defecting) The i18n-checker goes through the source and resources, and prompts for replacements.. it should handle things like:  
  
- "Apply changes to all" to not ask the same things again.. or a select from list of translations for easy re-usability.  
- Support placing of arguments, e.g. "Hello, {0}" and "{0}, 你好", in a intuitive manner  
- Support multi-pass parsing. i.e. the user may not have the time to sit and translate the whole source tree in 1-pass. Subsequent patches to the code should be parsable without re-parsing the old portions.  
  
I think its very do-able (at least in the preliminary).. by looking for static text and changing them into ResourceBundle calls (after prompting for user input)..   
  
Doing i18n in any other way, IMHO, is simply a waste of the developers' man-hours.

