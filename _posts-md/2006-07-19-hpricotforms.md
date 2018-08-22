---
layout: post
title: HpricotForms
published: true
category:
- rails
---
Since the introduction of [Hpricot](http://redhanded.hobix.com/inspect/hpricot01.html), the snazzy and fast Ruby parser for HTML, I've been meaning to give it a whirl - the API looks yummy. Now, as I'm doing more testing and validation stuff at work, such a need has come. Back in Javaland, when I need to navigate or test web apps by code, submit forms and do other web bot stuff, I turn to [HtmlUnit](http://htmlunit.sourceforge.net/gettingStarted.html). The api is simply awesome and won me over immediately. So if you're still stuck in Java, do give it a look.

 

Anyways, though the whole testing harness of Rails is a godsend, I started to miss some of those HtmlUnit goodies - pulling out a Form object from a visited page, setting the fields values and submitting it.. and getting back a Page. So, this is what I've come up with for use in functional tests:

 

    def test\_login\_logout
    page = get :new# first, let's get to the login page
    form = page.forms.first# next, get a reference to the form
    # form.field\_names =\> ["user[login]", "user[password]"]
    # form.field\_names returns you the input fields
    # available in the form
     
    form["user[login]"]= "Joe"
    form["user[password]"] = "topsecret"
    page = form.submit(self)# after setting the form values, submit it
    # 'page' now references the page after login
    assert\_response :success
    # page.links # returns you an array of links found on the page
     
    page = page.links("@id='signout'").click(self)
    # locate the sign-out link by its html id
    # and click it
    assert\_response :success
     end 

 

Can't say its a replica of HtmlUnit... but it does meet my needs for now. Notice we didn't need to explicitly handle things like session or where the form submits to. It simply goes to where its supposed to go - as rendered by the view. And yes, as you do submit() and click() you might actually cross different controllers. [HpricotForms](http://choonkeat.svnrepository.com/svn/rails-plugins/hpricot_forms/) handles that for you.   
   
 The main thing I like about this API is that the field names in the form are real. If you're careless like me, and modify your action templates (.rhtml files) but forgot to change both your controller and test, traditionally your test will still pass because you were passing in parameters explicitly, e.g.

 

    post :login, {:user =\> {:login =\> "Joe", :password =\> "topsecret"}}
     

 

even though your HTML form fields were changed to "account[login]" and "account[passwd]". But [HpricotForms](http://choonkeat.svnrepository.com/svn/rails-plugins/hpricot_forms/) will raise an exception when you try to set values into fields that does not exist in the rendered form.

 

[HpricotForms](http://choonkeat.svnrepository.com/svn/rails-plugins/hpricot_forms/) doesn't add new assert\_xxx methods to your test environment since I personally think we've had enough already. It merely deals with navigation. I'm sure programmers out there are capable enough to do their own assertions when they need it.

 

    script/plugin install [http://choonkeat.svnrepository.com/svn/rails-plugins/hpricot\_forms](http://choonkeat.svnrepository.com/svn/rails-plugins/hpricot_forms) 

Note: It appears that HpricotForms only work on [Edge Rails](http://wiki.rubyonrails.com/rails/pages/EdgeRails), with [simply\_restful](http://svn.jamisbuck.org/rails-plugins/simply_restful/) plugin. This is due to the routing changes. Works with Rails 1.1.4 and Edge Rails. [Feedback](http://choonkeat.svnrepository.com/rails-plugins/trac.cgi) is welcome.

**Update**

 

Added form.extend!(partial) to allow extending the formfields with a separate HTTP request. i.e. if your form appends fields via xmlHttpRequest, you can now say

    form = page.forms.first
    form.field\_names# =\> ["email[0]"] 
    # the original form only has 1 field
    form["email[0]"] = "email1"
    
    form.extend!(get :on\_security\_options\_clicked) do
    form.field\_names# =\> ["email[0]", "ssl"] 
    # the new fields from the partial is 
    # appended into our form object. 
    form["ssl"] = "true"
    end
    page = form.submit(self) # the combined form will be submitted

Also, to help kick off the writing of code, form.to\_code will print out a series of variable assignment satements based on the default values from the form, e.g.

    form = page.forms.first
    puts form.to\_code
    
    # this prints lines of Ruby code like:
    # 
    # form["from"] = "sender"
    # form["email[0]"] = "email1" 
    # form["options[]"] = ["html", "read-receipt"]

