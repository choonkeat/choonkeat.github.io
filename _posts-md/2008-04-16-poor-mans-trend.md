---
layout: post
title: Poor Man's Trends
published: true
category:
- rails
---
I've just released my [Poorman's Trends](http://github.com/choonkeat/poormans-trends/tree/master) Rails plugin as an excuse to do something with my GitHub account. Much like its distant cousin, [Poor Man's CRM](http://blog.choonkeat.com/weblog/2004/12/poor-mans-crm.html), this software aims to be plug-and-play, self-sufficient and useful enough to make sense of existing data.

3 Steps to get it:

1. Install into vendor/plugins with   
`./script/plugin install git://github.com/choonkeat/poormans-trends.git`
2. Add 1 line into your existing controller, e.g. `admin_controller.rb`  
`include Poormans::Trends`
3. Point your browser to `http://yourserver/admin/poormans_trends` and Viola!

You should see a simple page greeting you, like in this screenshot:

[![](http://farm3.static.flickr.com/2342/2417672499_920e605a2e.jpg)](http://www.flickr.com/photos/choonkeat/2417672499/)

Pick a Model class, and you should see some pretty graphs making their AJAXy entrance:

[![](http://farm4.static.flickr.com/3162/2417672369_6e8bfc3f7b.jpg)](http://www.flickr.com/photos/choonkeat/2417672369/)  
[![](http://farm3.static.flickr.com/2057/2418488312_c5d2a27c42.jpg)](http://www.flickr.com/photos/choonkeat/2418488312/)

What's happening is that a few interesting columns are picked up from the Model's table and a few popular values are picked up from those columns. A count is done for all of them, divided up by weeks and spitted out as HTML tables. These tables are then turned into pretty charts using the nice _HTML-table-to-canvas_ javascript library [from Filament Group](http://www.filamentgroup.com/lab/creating_accessible_charts_using_canvas_and_jquery/).

Without configuration nor knowledge of what your application does, is there any hope that it can make sense?

That's where the "picking of interesting columns" come in. Assuming zero domain knowledge of your application, I'd say the foreign keys are most interesting (in Rails convention, any column ending with "\_id"), together with sub-classes ("type" and any columns ending with "\_type"). The time aspect relies on the Rails convention of using "created\_at".

The end result actually looks pretty good for something requiring no configuration! :-)

