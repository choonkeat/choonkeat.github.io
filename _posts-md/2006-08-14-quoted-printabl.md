---
layout: post
title: 'Quoted-Printable: Bitten for the N-th time!'
published: true
category:
- ruby
---
I knew I'd handled this before, but still I'd forgotten what was going on. Searching the web was [fruitless](http://www.google.com/search?q=tmail%20unquote%20body%20quoted-printable%20) - everyone seem happy to simply use str.unpack("M\*") (aka TMail::Mail.unquoted\_body when "quoted-printable") for getting unquoted body from an email part that is "quoted-printable".

 

Perhaps I'm just searching for the wrong terms... if so, then to ensure I'll hit my own result next time, I might as well be the one to put up a post using these terms that I might use: tmail unquote body quoted-printable decode truncated

 

The problem is, I have a email.body (e.g. variable str) that looks like this:

 

    irb(main):002:0\> puts str
     This is a
     =20
     multiline te=
     xt
     =20
     string text
     =\> nil

 

So far so good. Now I perform an unpack (aka email.unquoted\_body)

 

    irb(main):003:0\> puts str.unpack("M\*") # aka TMail::Mail.unquoted\_body when "quoted-printable"
     This is a
     
     multiline te
     =\> nil

 

WTF? What happened to the 3rd line of text? \*shrugs\* but if I do some dos2unix on the string...

 

    irb(main):004:0\> puts str.gsub(/\r\n/, "\n").unpack("M\*")
     This is a
     
     multiline text
     
     string text
     =\> nil

 

Bah! The email did come from hotmail.com so I'm biased to think _they_ got it wrong instead of the stdlib.

 

Update: [Hmmmmmm..](http://www.freesoft.org/CIE/RFC/1521/6.htm)

 

    Note that many implementations may elect to encode the local
    representation of various content types directly, as described in
    Appendix G. In particular, this may apply to plain text material
    on systems that use newline conventions other than CRLF
    delimiters. Such an implementation is permissible, but the
    generation of line breaks must be generalized to account for the
    case where alternate representations of newline sequences are
    used.

    quoted-printable := ([\*(ptext / SPACE / TAB) ptext] ["="] CRLF)
     ; Maximum line length of 76 characters excluding CRLF

Update 2: Ruby stdlib is broken [for unpack](http://72.14.235.104/search?q=cache:dAM_bdbXon8J:blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/28601%3Fhelp+ruby+unpack+CRLF&hl=en&lr=&strip=1).

 

    

