---
layout: post
title: Retrieving a sensible file extension for a given MIME string in Rails
published: true
category:
- rails
---
Here's a little snippet of code to retrieve a sensible file extension based on a MIME string, using the built-in MIME dictionary in Rails

     module Mime
    class Type
    class \<\< self
    # Lookup, guesstimate if fail, the file extension
    # for a given mime string. For example:
    #
    # \>\> Mime::Type.file\_extension\_of 'text/rss+xml'
    # =\> "xml"
    def file\_extension\_of(mime\_string)
    set = Mime::LOOKUP[mime\_string]
    sym = set.instance\_variable\_get("@symbol") if set
    return sym.to\_s if sym
    return $1 if mime\_string =~ /(\w+)$/
    end
    end
    end
    end 

As mentioned in the comments in the code, you can now give it Mime::Type.file\_extension\_of 'text/rss+xml' and it will return you "xml". Any extension missing, just apply the standard Rails MIME registration steps

     Mime::Type.register "text/vnd.sun.j2me.app-descriptor", :jad
     Mime::Type.file\_extension\_of "text/vnd.sun.j2me.app-descriptor"# =\> "jad" 

The bonus with using the standard Mime::Type.register is that both your MIME lookup and [respond\_to](http://weblog.rubyonrails.org/2007/1/19/rails-1-2-rest-admiration-http-lovefest-and-utf-8-celebrations) gets smarter together.

