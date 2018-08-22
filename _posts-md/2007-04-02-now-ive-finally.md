---
layout: post
title: Now I've finally gotten this out of the way...
published: true
category:
- rails
---
I've always wanted to produce semantically correct HTML forms. But sometimes, life gets in the way, styling incompetence, laziness, and I end up having forms that look like:

    \<form ... \>
     \<b\>Name:\</b\>\<input ... /\>\<br /\>
     \<b\>Email:\</b\>\<input ... /\>\<br /\>
    \</form\>

Yuck.

I recently got around to clarify what is the more "_correct"_ markup to use at the [WebSG](http://websg.org/) mailing list, and this is the one I settled with

    \<form ... \>
     \<fieldset\>
      \<legend\>Some Context\</legend\>
      \<dl\>
      \<dt\>\<label for="someid"\>Name\</label\>\</dt\>
      \<dd\>\<input id="someid" ... /\>\</dd\>
     \<dl\>
     \</fieldset\>
    \</form\>

Ok. But that'll be a pain to write. Even if something generated the HTML files for me, there is still a lot of markup noise in there to be comfortable maintaining. So I'd set out to define what I'd like to write for Rails to render the above HTML

    \<% form\_for :some do |f| %\>
    \<% f.fieldset 'Some Context' do |f| %\>
    \<%= f.text\_field :name %\>
    \<% end %\>  
    \<% end %\>  

Tighter code, less HTML noise in the file to distract me from the task at hand (the attributes, values, etc). Once I cook up a base style for this form, CSS will save me from all future look & feel changes... \*blissful expression\*

     1. cd $RAILS\_ROOT # your current Rails app
     2. svn export [http://choonkeat.svnrepository.com/svn/rails-plugins/web\_sg\_form\_builder](http://choonkeat.svnrepository.com/svn/rails-plugins/web_sg_form_builder) . --force
     3. ./script/server
     4. Go to [http://localhost:3000/web\_sg\_form\_builder](http://localhost:3000/web_sg_form_builder)

And you should get this page of instruction / demo:

[![](http://farm1.static.flickr.com/188/443416920_8b0c6bc015.jpg)](http://www.flickr.com/photos/choonkeat/443416920/)



