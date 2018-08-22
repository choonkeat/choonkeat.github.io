---
layout: post
title: Ruby for Rails Beginners
published: true
---
I've been doing this exercise for a few Rails beginners (or non-rubyists who glanced at Rails a bit before) and the general feedback is that they learn Rails but not Ruby, and this is new to them. So I suppose I should just write it down to save future effort.

If you already know Ruby you'd want to stop reading here.

### **"Computer, book me on the cheapest flight to Mexico for tomorrow!"**

The unfortunate thing is, most folks' first contact with Rails will be some short code snippets like

    class Comment < ActiveRecord::Base
      belongs_to :user
    end
    
    class User < ActiveRecord::Base
      has_many :comments
      validates_uniqueness_of :username, :case_sensitive => false
    end

Very succinct. Looks like english and could even appear friendly to non-programmers. It doesn't look "_real_" and has "_toy_" written all over it. The jaded programmer will see "_config file_", "_no real syntax_", "_fragile_", "_abitrary subset_", "_haml_" (_zing!_) or "_not powerful_" as if a guy in grey suit just demoed how he told his computer what to do verbally - "_How sustainable can such fake syntax be?_". And perhaps beginners might go, "_Rails lets me write english-ish code! Wow wee!_"

### **Let's start somewhere else**

In mainstream OO languages like Java, you can't really write Java code anywhere you like. "_Huh?_" Yes, you just don't usually think about it this way. For example you can't simply insert Java code anywhere, say…

    System.out.println("here?");
    public class Hello {
      public static void main(String [] argv) {
        System.out.println("world!");
      }
      System.out.println("or here!");
    }

It's not allowed and you'd get errors

    $ javac Hello.java
    Hello.java:1: class, interface, or enum expected
    System.out.println("here?");
    ^
    Hello.java:6: <identifier> expected
      System.out.println("or here!");
                        ^
    Hello.java:6: illegal start of type
      System.out.println("or here!");
                         ^
    3 errors

In Ruby, however,you_can_write Ruby in weird places:

    puts("here?")
    class Hello
      def self.main(argv)
        puts("world!")
      end
      puts("or here!")
    end
    Hello.main(ARGV)

Which runs like this instead

    $ ruby hello.rb
    here?
    or here!
    world!

### **So? Big deal**

Taking another step back, let's look at this Ruby class

    class Hello
      def an_instance_method()
        puts("This is inside an_instance_method")
      end
      def self.a_class_method()
        puts("This is inside a_class_method")
      end
    end

If you're a programmer you'd have ascertained`def`defines a method (or function). Now, the difference between`def an_instance_method()`and`def self.a_class_method()`is that`a_class_method`is a class method (or Java programmers like to say "static method") and is used like this

    Hello.a_class_method()

which prints`This is inside a_class_method`whereas`an_instance_method`is an instance method that you can call on instances of the`Hello`class,

    x = Hello.new()
    x.an_instance_method()

### **So? Big deal**

Say we define our Ruby class like this, with a`puts`statement at the bottom

    class Hello
      def an_instance_method()
        puts("This is inside an_instance_method")
      end
      def self.a_class_method()
        puts("This is inside a_class_method")
      end
      puts(self)
    end

Running it would produce

    $ ruby hello.rb
    Hello

Notice`puts(self)`has printed the name of our class`Hello`. **This means we are referring to the Class which we're still in process of defining!** And since we can refer to it, we can also use it (as much of it as we've defined so far)

    class Hello
      x = self.new()
      puts(x)
    
      def an_instance_method()
        puts("This is inside an_instance_method")
      end
      x.an_instance_method()
    
      def self.a_class_method()
        puts("This is inside a_class_method")
      end
      self.a_class_method()
    end

Running it would produce

    $ ruby hello.rb
    #<Hello:0x0000010084f778>
    This is inside an_instance_method
    This is inside a_class_method

Notice how instance`x`obtains an instance method after the fact! Let's clean up our class: rename it as`User`, and rename the class method to`validates_uniqueness_of`, and add some arguments to the class method…

    class User
      def self.validates_uniqueness_of(what, options)
        puts("This is inside validates_uniqueness_of #{what} and #{options}")
      end
      self.validates_uniqueness_of('username', Hash['case_sensitive',false])
    end

The`#{blah}`syntax is string interpolation, allowing Ruby code to run within a string, like`"Five plus One is equal to #{5 + 1}"`. So, running this file would produce

    $ ruby hello.rb
    This is inside validates_uniqueness_of username and {"case_sensitive"=>false}

In Ruby, Hash objects (or associative arrays) can be defined literally as`{'case_sensitive'=>false}`; (brackets) and {curly braces} are largely optional;`self`is implied; You can also use`:symbols`to denote things you'd usually use enums or constants for

    class User
      def self.validates_uniqueness_of(what, options)
        puts "This is inside validates_uniqueness_of #{what} and #{options}"
      end
      validates_uniqueness_of :username, :case_sensitive => false
    end

We can use the`<`syntax to denote inheritance and define the class method elsewhere

    class Base
      def self.validates_uniqueness_of(what, options)
        puts "This is inside validates_uniqueness_of #{what} and #{options}"
      end
    end
    
    class User < Base
      validates_uniqueness_of :username, :case_sensitive => false
    end

We could stash more methods into our`Base`class

    class Base
      def self.has_many(what)
        # some code
      end
      def self.validates_uniqueness_of(what, options)
        # some code
      end
    end

Or we could use`Mixins`to organize them neatly into standalone modules and compose them together

    module Relation
      def has_many(what)
        # some code
      end
    end
    
    module Validation
      def validates_uniqueness_of(what, options)
        # some code
      end
    end
    
    class Base
      extend Relation
      extend Validation
    end

Either way, we can now have something that looks familiar

    class User < Base
      has_many :comments
      validates_uniqueness_of :username, :case_sensitive => false
    end

So you see, the toy looking code is not Rails-specific, nor is it some limited-capacity syntax for PPT & luring beginners.

### **Came for Rails? Stay for Ruby**

And that's it. If this has piqued your interest, you might want to investigate how Ruby lets Rails get away with the syntax of`config/routes.rb`and how Ruby makes`has_many`and`validates_uniqueness_of`possible to implement.

