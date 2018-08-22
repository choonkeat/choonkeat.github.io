---
layout: post
title: 'KRJS: RJS without messing the Views'
published: true
category:
- krjs
---
RJS is great and awesome. I use it quite regularly now. With RJS, I don't have to deal with _which parts of the page to update_ in the rhtml files - I get to decide whilst in my controller using the nice and elegant [render :update](http://codefluency.com/articles/2006/05/27/rails-views-render-update-not-rjs/). Sweet.

But part of me wished I didn't have to even decide _which page elements are to be ajaxified_. I'd wish I could more easily enable a link, form or button to make ajax calls without going back and touching my html...

Oh well.

Introducing the [KRJS plugin](http://choonkeat.svnrepository.com/svn/rails-plugins/krjs/), with less than 60 lines of patch to Rails' ActionPack itself (which probably means bugs are aplenty, would slow production sites to a crawl, and that its fresh from the oven too)

To see KRJS in action (_so what does it do?_), generate a blank controller and index action:

    <font>.</font>/script/generate controller Sample index

Give it a decent layout (include javascripts) by creating the file app/views/layouts/sample.rhtml

    <font>&lt;</font><font>!</font>DOCTYPE html PUBLIC <font>"-//W3C//DTD XHTML 1.0 Transitional//EN"</font>
    <font>"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"</font><font>&gt;</font>
    <font>&lt;html&gt;</font>
    <font>&lt;head&gt;</font>
    <font>&lt;</font><font>%</font><font>=</font> javascript\_include\_tag <font>:</font>defaults <font>%</font><font>&gt;</font>
    <font>&lt;/head&gt;</font>
    <font>&lt;body&gt;</font>
    <font>&lt;</font><font>%</font><font>=</font> <font>@content_for_layout</font> <font>%</font><font>&gt;</font>
    <font>&lt;/body&gt;</font>
    <font>&lt;/html&gt;</font> 

Create a sample form:

    <font>&lt;</font><font>%</font><font>=</font> **<font>form_tag</font>** <font>(</font><font>{</font><font>:</font>action <font>=</font><font>&gt;</font> <font>'submit'</font><font>}</font><font>,</font> <font>{</font><font>:</font>id <font>=</font><font>&gt;</font> <font>'form'</font><font>}</font><font>)</font> <font>%</font><font>&gt;</font>
    <font>&lt;</font><font>%</font><font>=</font> text\_field <font>'account'</font><font>,</font> <font>'login'</font><font>,</font> <font>:</font>id <font>=</font><font>&gt;</font> <font>'account-new-login'</font> <font>%</font><font>&gt;</font><font>&lt;</font>br <font>/</font><font>&gt;</font>
    <font>&lt;</font><font>%</font><font>=</font> submit\_tag <font>'Login'</font> <font>%</font><font>&gt;</font>
    <font>&lt;</font><font>%</font><font>=</font> end\_form\_tag <font>%</font><font>&gt;</font> 

This will be the last time we're touch the Views. If you visit the page now, you should see a simple form. This is the most basic Rails app. It will be our mickey mouse app for this session:

[![](http://static.flickr.com/49/165073750_19cba41a79_m.jpg)](http://www.flickr.com/photos/choonkeat/165073750/)

Clicking on Login leads you to an even simpler error page:

[![](http://static.flickr.com/64/165073835_c5d9f5608a_m.jpg)](http://www.flickr.com/photos/choonkeat/165073835/)

This is because we didn't have any code to handle the form submit. Don't let that stop us web2.0-ers, let's ajaxify it anyways! First, install the [KRJS plugin](http://choonkeat.svnrepository.com/svn/rails-plugins/krjs/)

    <font>.</font>/script/plugin install http://choonkeat.svnrepository.com/svn/rails-plugins/krjs/

and **restart your server**.

Now, try to view the page, and click on the Login button.... same error page. Good! That means KRJS didn't mess up the original app. Now let's add a new method into the controller, app/controllers/sample\_controller.rb

    **<font>def</font>** on\_form\_submit
     render <font>:</font>update **<font>do</font>** <font>|</font>page<font>|</font>
     page<font>.</font>insert\_html <font>:</font>after<font>,</font> <font>'form'</font><font>,</font> CGI<font>.</font> **<font>escapeHTML</font>** <font>(</font>params<font>.</font>inspect<font>)</font>
    **<font>end</font>**
    **<font>end</font>**



Refresh the page, and click on Login

[![](http://static.flickr.com/45/165073881_98a6576eac_m.jpg)](http://www.flickr.com/photos/choonkeat/165073881/)

As you can see, the form has become ajaxified - to update the page instead of sending the browser to a new location - by merely adding a new corresponding method in the controller! How about adding this to the controller:



    **<font>def</font>** on\_account\_login\_blur
     render <font>:</font>update **<font>do</font>** <font>|</font>page<font>|</font>
     page<font>.</font>insert\_html <font>:</font>after<font>,</font> <font>'form'</font><font>,</font> CGI<font>.</font> **<font>escapeHTML</font>** <font>(</font>params<font>.</font>inspect<font>)</font>
    **<font>end</font>**
    **<font>end</font>**



Refresh the page, type something into the textfield and TAB away from the field:

[![](http://static.flickr.com/44/165073907_898d68f271_m.jpg)](http://www.flickr.com/photos/choonkeat/165073907/)

Yea, KRJS registers onBlur events as well. In fact, it'll register onClick, onSubmit, onWatever, onYouwant because it doesn't really care. All that matters is your HTML element's ID attribute. [KRJS](http://choonkeat.svnrepository.com/svn/rails-plugins/krjs/) currently identifies xhr actions by naming conventions, hence it will probably be most convenient to be used with [dashed\_](http://choonkeat.svnrepository.com/svn/rails-plugins/dashed_dom_id/)[dom\_id plugin](http://choonkeat.svnrepository.com/svn/rails-plugins/dashed_dom_id/).

Go ahead, give it a spin. I'm going to sleep.. hope I don't wake into a world of horror...

[Updated plugin links]

