---
layout: post
title: 'Rails: Calling render() outside your Controllers'
published: true
category:
- rails
---
I found myself needing to render a .rxml template from my Model today (Ok, stop the MVC preach already...) anyways.. found a few [deadends](http://lists.rubyonrails.org/pipermail/rails/2006-May/043659.html), but finally got down to use method\_missing to see what's needed by ActionViewer::Base. Not sure if there's an easier way...



    # 
    # lib/render\_anywhere.rb
    # 
    # Render templates outside of a controller or view.
    # 
    # Simply mixin this module to your existing class, for example:
    # 
    # class MyTemplater \< ActiveRecord::Base
    # include RenderAnywhere
    # 
    # And you can use render() method that works the same as ActionView::Base#render
    # 
    # obj = MyTemplater.new
    # obj.html = obj.render :file =\> '/shared/header'
    # 
    # 
    module RenderAnywhere
    
    class DummyController
    def logger
    RAILS\_DEFAULT\_LOGGER
    end
    def headers
    {}
    end
    end
    
    def render(options, assigns = {})
    viewer = ActionView::Base.new(Rails::Configuration.new.view\_path, assigns, DummyController.new)
    viewer.render options
    end
    
    def template\_exists?(path, assigns = {})
    viewer = ActionView::Base.new(Rails::Configuration.new.view\_path, assigns, DummyController.new)
    viewer.pick\_template\_extension(path) rescue false
    end
    end
    

Hope this is helpful to someone

