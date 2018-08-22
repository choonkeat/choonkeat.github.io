---
layout: post
title: html2text function in Ruby
published: true
category:
- software
---
Whilst adding text-email feature in [RssFwd](http://www.rssfwd.com/) (Ruby on Rails app), I had some problems looking for a html2text ruby library that'll do what I need - simple, clear text output, so I wrote my own.  
  
So, in case somebody else is looking for this little function (but irritating to be missing) here's my shot at getting a similar-to-[lynx](http://lynx.browser.org/)-dump kind of output:  
  
The code:

> require 'cgi'  
>   
> def html2text html  
>  text = html.  
>  gsub(/(|\n|\s)+/im, ' ').squeeze(' ').strip.  
>  gsub(/\<([^\s]+)[^\>]\*(src|href)=\s\*(.?)([^\>\s]\*)\3[^\>]\*\>\4\<\/\1\>/i, '\4')  
>   
>  links = []  
>  linkregex = /\<[^\>]\*(src|href)=\s\*(.?)([^\>\s]\*)\2[^\>]\*\>\s\*/i  
>  while linkregex.match(text)  
>  links \<\< $~[3]  
>  text.sub!(linkregex, "[#{links.size}]")  
>  end  
>   
>  text = CGI.unescapeHTML(  
>  text.  
>  gsub(/\<(script|style)[^\>]\*\>.\*\<\/\1\>/im, '').  
>  gsub(/\<!--.\*--\>/m, '').  
>  gsub(/\<hr(| [^\>]\*)\>/i, "\_\_\_\n").  
>  gsub(/\<li(| [^\>]\*)\>/i, "\n\* ").  
>  gsub(/\<blockquote(| [^\>]\*)\>/i, '\> ').  
>  gsub(/\<(br)(| [^\>]\*)\>/i, "\n").  
>  gsub(/\<(\/h[\d]+|p)(| [^\>]\*)\>/i, "\n\n").  
>  gsub(/\<[^\>]\*\>/, '')  
>  ).lstrip.gsub(/\n[]+/, "\n") + "\n"  
>   
>  for i in (0...links.size).to\_a  
>  text = text + "\n [#{i+1}] \<#{CGI.unescapeHTML(links[i])}\>" unless links[i].nil?  
>  end  
>  links = nil  
>  text  
> end

  
  
Sample html input string:  
  

> \<h1\>Title\</h1\>  
> This is the body. Testing \<a href="http://www.google.com/"\>link to Google\</a\>.\<p /\>  
> Testing image \<img src="/noimage.png"\>.\<br /\>  
> The End.

  
  
The generated output string:  
  

> Title  
>   
> This is the body. Testing [1]link to Google.  
>   
> Testing image [2].  
> The End.  
>   
>  [1] \<http://www.google.com/\>  
>  [2] \</noimage.png\>

  
  
Comments are welcome.   
  
Note:   

  
1. The \<\> around the list of links at the bottom? they supposedly helps more arcanic e-mail programs understand that they should not be broken up into multiple lines.   
  
2. The HTML entities aren't fully converted by CGI.unescapeHTML(e.g. &mdash;) if there's a better method to use, lemme know
  
  
  
