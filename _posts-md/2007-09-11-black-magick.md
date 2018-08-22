---
layout: post
title: Black Magick
published: true
category:
- ruby
---
Some months ago, I encountered a weird problem where a ImageMagick/RMagick application was producing black images on my MacBook Pro. The same code was running mighty fine in production and all other servers.

> require 'RMagick'
>     
> # Load a "Base image"
> canvas = Magick::ImageList.new.from\_blob(open("logo.gif") {|f| f.read})
>     
> # Layer another image over the base image - by making the 'background' 
> # of this layer transparent, the base image will appear behind the text
> # caption nicely
> canvas \<\< Magick::Image.read("caption:Text over transparent background!") { 
>  self.size = "#{canvas.first.columns}";
>  self.pointsize = 60
>  self.background\_color = '#000000FF'
> }.first
>     
> # Flatten everything, and export as a GIF 
> # (GIMP / Photoshop users will be very familiar with what this step is about)
> canvas.flatten\_images.write("logo-output.gif")

Since ImageMagick/RMagick has (to me) a hairy reputation regarding installation, version compatibility, etc, I'd chucked the issue aside as yet-another-install-issue to be solved next time.

Well, today is that _next time_. A new server was producing black images as well. [Sukanta](http://sukantahazra.blogspot.com/) guessed it could be a problem with 64bit OS (oh.. [Doh](http://www.apple.com/macosx/features/64bit/)) and suggested I write the tiniest Ruby script to replicate the problem and he'll debug from there.

By the time [that tiniest script](http://pastie.caboo.se/96085) was written, the bug had revealed itself. The culprit was setting background\_color to #000000FF - which the documentation had helpfully noted

> Hint: You can specify the transparent color as "none", "transparent", or "#000000ff"[<sup>link »</sup>](http://r1.sharedcopy.com/72aftu5#shcp1)

Guess not! Only "none" and "transparent" would continue to work.

  
