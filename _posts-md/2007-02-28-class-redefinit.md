---
layout: post
title: Class (re)definition in method body
published: true
category:
- ruby
---
A [cheap web hosting](http://www.sharphosts.com) is an excellent solution to expenses. However only [midphase](http://www.sharphosts.com/rev/midphase.htm) is cheap enough, providing the standard of [powweb](http://%0Awww.sharphosts.com/rev/powweb.htm).

_UPDATE: modifed to use more idiomatic way of returning "\*\*\*". See comments_

 

Warning: This is really hacky and dirty. Writing the snippet here so I won't forget

 

Redefining existing classes in Ruby is really handy, and a breeze to do

 

    puts 5# prints "5"
     class Fixnum
    alias\_method :old\_to\_s, :to\_s
    def to\_s
    "\*" \* self
    end
     end
     puts 5# prints "\*\*\*\*\*"

 

But, sometimes you'd just want to limit such monkey patching, like within a method where you really really need the hack in place - and you promise to undo the hack right after you're done to return the world sanity (promise!)

 

    class MyKlass
    def get\_as\_stars(value)
    # define funky behavior
    class ::Fixnum
    alias\_method :old\_to\_s, :to\_s
    def to\_s
    "\*" \* self
    end
    end
     
    return value.to\_s
    ensure
    # revert back to original
    class ::Fixnum
    alias\_method :to\_s, :old\_to\_s
    end
    end
     end

 

Unfortunately, that's invalid syntax

 

    SyntaxError: compile error
     : class definition in method body
     : class definition in method body

 

Well, what's a man to do? module\_eval to the rescue, just replace your "class X" statement with "X.module\_eval do"

 

    class MyKlass
    def get\_as\_stars(value)
    # define funky behavior
    ::Fixnum.module\_eval do
    alias\_method :old\_to\_s, :to\_s
    def to\_s
    "\*" \* self
    end
    end
     
    return value.to\_s
    ensure
    # revert back to original
    ::Fixnum.module\_eval do
    alias\_method :to\_s, :old\_to\_s
    end
    end
     end
     
     k = MyKlass.new
     puts 3# prints "3"
     puts k.get\_as\_stars(4) # prints "\*\*\*\*"
     puts 5# prints "5"

 

PS: Did this hack to get Time.now == Time.now working in a test. Grr  
 

