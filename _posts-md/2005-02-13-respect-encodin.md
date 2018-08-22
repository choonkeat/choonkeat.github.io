---
layout: post
title: Respect Encoding
published: true
category:
- rssfwd
---
My colleague has returned me my [software bible](http://www.amazon.com/exec/obidos/ASIN/1590593898/103-9679346-5086206) and I've been revisiting the chapters ever since - I felt I'd read the first pass too quickily... so I'm giving it a second pass in case I missed something.  
   
 After re-reading the chapter on [Unicode](http://www.joelonsoftware.com/articles/Unicode.html), I grew remorseful and updated [RssFwd](http://rails.yanime.org/rssfwd/) to not blatantly ignore the xml encoding attribute. Now non-english sites like [joi ito's](http://rails.yanime.org/rssfwd/preview?url=http%3A//joi.ito.com/jp/atom.xml) can be preview and subscribed to beautifully. Yippie!  
   
 However, I'm still getting some ?? on the email subject even though the email body renders fine. A snippet of the raw email is as shown:

    From: [snipped]
    To: [snipped]
    Subject: �天�夠�
    Content-Type: text/html; charset=UTF-8
    [rest of html content below..]

 Any ideas? Is it because content-type is found below the subject? I can't seem to find a proper way to set content type in [action mailer](http://am.rubyonrails.org/) and I'm manually setting mail['content-type'] = ... before delivering the email :-(  
  
