---
layout: post
title: Learning Web Development
published: true
category:
- software
---
Much in the spirit of "Skinny Controllers and Fat Models", I'm coming round to the fact that Single-Table Inheritance for is the evil best avoided.

All that code-reuse might look sexy and get all the OOP noddings. But in the longer run, the risk is that my code (esp. domain/business logic) end up as [big balls of mud](http://www.laputan.org/mud/). But this "risk" is taken in the bid to stave off something more imminent - code repetition. SQL everywhere? No, wrap in a function! No, wrap in a Class! No, inherit from that BaseClass! Fewest blocks to build the tallest cathedrals - architectural elegance.

But buildings don't evolve. When requirements evolve, aka "reveal their true selves", the models start to diverge bit by bit and my OOP-instinct intuitively hold them together. Then one day, often when its too late or a new team member joins, I realise the models are really not of the same family anymore. To my chagrin, the glue holding the inheritance were more about preventing them from stepping over each other. And the result is worse than the repetition I'd avoided.

Another related issue is RESTful controllers - "Oh, so 2006" you say. Sorry I'd only drank half the CRUD kool-aid. Now I'm feeling the pain on those parts where I'd chosen to go the other way when there's a Model involved. Its the kind of pain you know only when you're straddling between 2 worlds. Bottom line: not worth over-thinking about controllers. I'm also certain those content-type negotiation can be abstracted out of sight. What's the fun in repeating this:

> responds\_to do |format|
>  format.js { render :json =\> @object.to\_json }
>  format.xml { render :xml =\> @object.to\_xml }
>  format.html { }
> end

And if I jump both feet into doing "Presentation Layer" in CSS/Javascript only, a lot of "view" can actually go away - leaving only layouts.

So yes, bliss will be the day I only define schemas, write Models, sprinkle CSS and my app is done. Like my [colleague](http://khigia.wordpress.com/) (and [Prolog](http://en.wikipedia.org/wiki/Prolog) admirer) always say, "_we only need defined data; everything else is easy_".

PS: I used to roll my eyes at that, saying it is too academic. In the real world, we often don't have the luxury of data being fully & correctly defined for us. Requirements change, stay agile, live with it! But I should've looked at it in another way: "_we only need defined [to be defining] data; everything else is easy [can always write themselves]_"

