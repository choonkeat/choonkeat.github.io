---
layout: post
title: Tryanslator2!
published: true
---
Finally! Google Translate [gets API-ed](http://www.readwriteweb.com/archives/google_releases_ajax_language_api.php). I was glad to see a "detect" method provided - meaning you tell what language a piece of text is in. Weird that the actual Google Translate service _still doesn't_ use it to improve their form defaults.

So I gave my old "[Tryanslator](http://blog.choonkeat.com/weblog/2005/12/translate-from.html)" (try and translate) an update, and [a new home](http://dev.choonkeat.com/js/lang/index):  
[![](http://farm4.static.flickr.com/3189/2351050091_ea47be79f3.jpg)](http://www.flickr.com/photos/choonkeat/2351050091/)

Few notes

- No asking of "Translate From?" - if you don't know how to read it, you probably don't know what it is written in.
- Language to "Translate to" defaults to user's browser language.
- Language options are written in their own language (duh).
- Google provides a rigid list of "translation pair" (i.e. English to Chinese, but not Chinese to Spanish). Tryanslator2 does an extra bounce to Google's server, using English as the mid-way to obtain a any-to-any translation.
- No submit button, just type and wait.
- All important text on the page auto-translate themselves to the reader's language, including "Please wait..." :-)

[Give it a try](http://dev.choonkeat.com/js/lang/index)!

  
