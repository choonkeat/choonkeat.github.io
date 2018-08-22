---
layout: post
title: 'RMagick: Rendering a chunk of lengthy text into a fixed size image, with a
  selected font color'
published: true
category:
- ruby
---
Been using RMagick at work, and was required to do something that wasn't supported directly: Rendering a chunk of lengthy text into a fixed size image, with a selected font color. Quite strange actually, because as far as rendering text goes, I would've thought that's a common use case.

1. Selected font color

RMagick provides 2 ways of rendering text: Using the [caption builtin format](http://www.simplesystems.org/RMagick/doc/imusage.html#bi_format_list) or [Draw#annotate](http://www.simplesystems.org/RMagick/doc/draw.html#annotate). Annotate loses since it doesn't do word-wrap, but caption does. So... DIY word-wrapping with annotate? Ugh. The kick is, I could get "annotate" to set the font color, I couldn't make "caption" do the same though the documentation says it can.

Tip #26 from the very valuable [Pragmatic Programmer](http://www.pragmaticprogrammer.com/ppbook/extracts/rule_list.html) book is

> "select" Isn't Broken  
> It is rare to find a bug in the OS or the compiler, or even a third-party product or library. The bug is most likely in the application.

This refers to programmers jumping to conclusion that some strange bug is caused by bugs in the lower-level library / operating system just because he cannot figure how his own code would be faulty. When you can't find the bug in your code, operating under "select is not broken" mode means that you "look again" in your own code, turn it over, around and shake out the loose bits - you'll usually find its actually your own fault.

Operating under this mode has a few benefits. First, your colleagues will stop avoiding you. Secondly, you'll learn a hell lot about your own code, debugging and the underlying library you are using.However, when you've tried different ways, with the simplest possible piece of code (out of the context of your application) and it still doesn't work, it wouldn't hurt to question.  
  
 Lucky me, the proverbial "[select](http://en.wikipedia.org/wiki/Asynchronous_I/O#Select.28.2Fpoll.29_loop)" was indeed broken and Tim Hunter was blazing fast in his response. RMagick::Image::Info.fill= wasn't working in "caption" mode, but now it does. My rendered, word-wrapped text now has colors.

2. Rendering into a fixed size

Word wrap allows me to constrain my text into a specific width, however it doesn't trim my text properly height-wise. If the image height is shorter than the rendered result, text gets clipped mercilessly - sometimes halfway across the font, depending on your image height and font size. I didn't find any option for such trimming, neither could I google an off the shelf solution. So I wrote my own. And since I felt that this "rendering a chunk of lengthy text into a fixed size image, with a selected font color" thingy is a rather common use case, I guess I might as well put the code out. Feel free to contribute any suggestion to speed up the trimming:

    #
    # Generate Magick::Image objects from text
    # \* wraps text around width\_constraint (pixels)
    # \* cuts off text (and appends '...') if it goes beyond height\_constraint (pixels)
    #
    # Example
    # \<code\>
    # require 'rmagick\_text\_util.rb'
    # include RMagickTextUtil
    # some\_text = "Hello world. This is a rather lengthy line " +
    # "and I'm not very sure how much will be cropped, " +
    # "and how much will be left over. So, here goes!"
    #
    # image = render\_cropped\_text(some\_text, 100, 50)
    # image.write "example\_without\_block.jpg"
    #
    # image = render\_cropped\_text(some\_text, 100, 50) do |img|
    # img.fill = "#ff0000" # this won't work until RMagick v1.15.3
    # img.pointsize = 15
    # end
    # image.write "example\_with\_block.jpg"
    # \</code\>
    #
    require 'RMagick'
    
    module RMagickTextUtil
    def render\_cropped\_text(caption\_text, width\_constraint, height\_constraint, &block)
    image = render\_text(caption\_text, width\_constraint, &block)
    if height\_constraint \< image.rows
    percent = height\_constraint.to\_f / image.rows.to\_f
    end\_index = (caption\_text.size \* percent).to\_i# takes a leap into cropping
    image = render\_text(caption\_text[0..end\_index] + "...", width\_constraint, &block)
    while height\_constraint \< image.rows && end\_index \> 0 # reduce in big chunks until within range
    end\_index -= 80
    image = render\_text(caption\_text[0..end\_index] + "...", width\_constraint, &block)
    end
    while height\_constraint \> image.rows# lengthen in smaller steps until exceed
    end\_index += 10
    image = render\_text(caption\_text[0..end\_index] + "...", width\_constraint, &block)
    end
    while height\_constraint \< image.rows && end\_index \> 0 # reduce in baby steps until fit
    end\_index -= 1
    image = render\_text(caption\_text[0..end\_index] + "...", width\_constraint, &block)
    end
    end
    image
    end
    
    def render\_text(caption\_text, width\_constraint, &block)
    Magick::Image.read("caption:#{caption\_text.to\_s}") {
    # this wraps the text to fixed width
    self.size = width\_constraint
    # other optional settings
    block.call(self) if block\_given?
    }.first
    end
    end

Update: fixes infinite loop when empty string cannot satisfy height and width constraint

