---
layout: post
title: KRJS Explained
published: true
category:
- krjs
---
Regarding KRJS, I've been asked "Hmm.. so you moved the javascript to the controller... what's the benefit?". I'll try to briefly illustrate the benefits here with some Rails/RJS code - **the codes in this example are broken, bugs or simply wrong** but that's not the point - hopefully you'll get the drift.  
  
The Problem: Given a textfield and a blank div in Rails, let's do a [google suggest-ish](http://www.google.com/webhp?complete=1) feature  
\<%= text\_field\_tag 'query' %\>  
 \<div id="placeholder"\>\</div\>  
  
<font><strong>Method #1</strong></font>  
1. observe your textfield with javascript:  
 \<script\>  
 // every 3 seconds, check changes typed into textfield  
  my\_observer('query', 3, 'my\_call\_to\_server');  
  
  // when called, sends server a request and updates HTML with  
 // response data  
  function my\_call\_to\_server(query) {  
 data = Ajax.get("http://host:port/my\_script?query=" + query);  
 getElementById('placeholder').innerHtml = data;  
  }  
\</script\>  
   
But let's be fair, with Rails can cut it down and even get cross-browser compatibility:  
\<%=  
 observe\_field('query',  
 { :url =\> { :action =\> ' my\_script'},   
 :frequency =\> 3,  
  :with =\>'query',  
 :update =\> ' placeholder')  
%\>  
  
2. Next, handle the Ajax.get on server and spits out HTML.   
def my\_script  
 search\_results = search\_for(params['query'])   
 render text: =\> search\_results.to\_html  
 end  
  
Notice the bold portions, these will come back to haunt you when you have many ajax pages - because you're forced to tie up the whole logic (observe 'query' every 3 seconds, send to server 'my\_script', update 'placeholder') all inside the HTML template. Dang! These will haunt you when you need to change or add logic (I'm sure you've experienced it before)   
  
<font><strong>Method #2</strong></font>  
1. Again, observe your textfield (notice the omitted :update option)  
 \<%=  
observe\_field('query ',  
 { :url =\> { :action =\> 'my\_script '},   
 :frequency =\> 3,  
 :with =\>' query')  
%\>  
  
2. Handle the Ajax.get on server and use RJS to spit out JS (calling page will execute):   
def my\_script  
 search\_results = search\_for(params['query'])   
 render update do |page|  
  page.replace\_html :placeholder, search\_results.to\_html  
  
 # 2 new whiz-bang features!   
 page.replace\_html :title, "Suggestions for #{params['query']}"   
 page.hide :advertisement\_div if   
  User.find(@session[:user\_id]).name == 'George'  
  end  
end  
  
Notice lesser amount of bold portions in the template? No more hard coding to update 'placeholder', we're saying it only at the server side. In fact, its so easy to add more / change JS events with RJS, that I had easily added 2 extra features without any the template changes! To introduce / change features in method #1, you would have to modify the html template.   
  
Now, notice that last extra feature... It roughly means "Find current user in database, if the name is George, send an extra javascript event to hide the advertisement div ". Imagine the code you have to juggle if we're doing this on client side (method #1)!!  
  
<font><strong>Method #3</strong></font>  
NOW.. Let's have fun with KRJS  
1.   
2. Handle the Ajax.get on server and use RJS to spit out JS (calling page will execute):   
def on\_query\_change\_3  
 # same code as method #2...  
 end  
  
Hey! There's no Step 1(tm). And step 2 is identical to method #2 (all benefits of RJS) except that our function has a specific naming convention. Absolutely no need to touch your template at all! The necessary javascripts in the HTML are inserted automatically when the template is rendered.   
  
Let's say we decide to change the JS event to onblur instead of observing every 3 seconds... come, think what has to be done if we're using method #1 or #2? Ready? Change 1 file? 2 files? remove observe\_field method, and replace with onblur event?...   
  
In KRJS, you simply rename your controller handler:  
def on\_query\_blur  
  # same code as method #2...  
 end

Now, its not really performant right now... the time-savings is mostly conceptual as well as on the development time. The exact implementation could be evolved, no issue:

- detect external on\_xxx.rjs files instead of clogging the controller with on\_xxx methods
- different behavior when in production mode
- rake task to compile for production (faster to render)

With KRJS, I can see lots of code-cutting with the many [RJS examples](http://weblog.rubyonrails.org/2006/6/13/new-from-oreilly-rjs-templates-for-rails) out there. [Patches are welcome](http://choonkeat.svnrepository.com/svn/rails-plugins/krjs/).

