---
layout: post
title: 'Crazy thoughts: A Rails Distribution'
published: true
---
Something that slipped my radar: Rails Engines.

Woah.. I know there's already several ways to help/add/modify Rails.. there are generators, helpers, and the (kind of) new plugins. But engines?

 

> Rails Engines are a way of dropping in whole chunks of functionality into your existing application without affecting any of your existing code. They could also be described as mini-applications, or vertical application slices – top-to-bottom units which provide full MVC coverage for a certain, specific application function.  
> (see [http://rails-engines.org/](http://rails-engines.org/) )

 

Interesting.. I _can_ think of a few uses of mini-apps already... so now, let's look at what the community has written for each (from the wiki): [Plugins](http://wiki.rubyonrails.com/rails/pages/Plugins), [Rails Engines](http://wiki.rubyonrails.com/rails/pages/Rails+Engines), [3rdPartyLibs](http://wiki.rubyonrails.com/rails/pages/3rdPartyLibs). [3rdPartyHelpers](http://wiki.rubyonrails.com/rails/pages/3rdPartyHelpers) and [AvailableGenerators](http://wiki.rubyonrails.com/rails/pages/AvailableGenerators).

Yea. The first thought that comes to mind is... mess. So many selections that I think there might be enough mess for a distro to happen. e.g. In RailsX distro, the scaffolded apps is ajax-ified, or RailsY distro comes ready with a login/password/forget-password mini-app, or [RailsZ](http://railsexpress.de/blog/) has defaults optimized for speed (imho, more aptly named as [shinkansen](http://www.japan-guide.com/e/e2018.html)).. [OpenRails](http://www.openbsd.org/) is optimized for security... EasyRails comes complete with Ruby installed and servers configured... oops, that's already [InstantRails](http://instantrails.rubyforge.org/wiki/wiki.pl), though I'm not sure if it had intended itself to be. Anyways, distros are much better than forking aye? And to some extent, might just relieve the core team from dealing with a [variety of wishes](http://wiki.rubyonrails.com/rails/pages/WishList).

In whichever case, if distros do happen, lets just hope the package distribution mechanism remains on the plate of the core so that things will work cross-distro- think RPM, DEB,.. and then there's Ubuntu DEB.. irk!

