---
layout: post
title: '"CRUD! CRUD! CRUD!": DHH'
published: true
category:
- rails
---
Well, ok he didn't exactly do a Steve-Balmer-jumping-around-the-stage thing. But what he was driving at this evening's keynote is extremely liberating:

 

_What if every controller does only\* CRUD (create, read, update, destroy)?_

 

(Note: DHH understands that only CRUD is just an ideal and its perfectly necessary to drop out of that when needed. Much like how ActiveRecord optimises to support its ideal, yet allows find\_by\_sql)

 

CRUD is simple and well understood. It is even the only 4 operations baked into the SQL to manipulating data - INSERT, SELECT, UPDATE, DELETE. So if 80% of the web apps are simply database-backed web applications, asking controllers to just revolve around CRUD isn't that demanding is it? [Using HTTP GET, POST, PUT and DELETE.](http://www.loudthinking.com/arc/000572.html) Instead of,

 

    POST /people/destroy/1 

 

it now becomes,

 

    DELETE /people/1

 

Note: Though [technical concerns](http://www.intertwingly.net/blog/2006/03/12/HTTP-Best-Practices) are valid, it doesn't sound like David is looking for protocol purity. Workarounds are acceptable if that's what's required to make this work.

 

Having CRUD-only conventions means not needing to decide method names anymore - this is one of those stupid small things that nibbles at you like deciding the names of foreign keys. Say you have a "Student" controller, but you're adding a "Subject" to him? Hmm... StudentController#take\_subject() or SubjectController#add\_student()? Is it so simple as associating the 2 models? Are there other operations that needs to be done when such association is created or destroyed? (eh? crud verbs sneaking in...) Before you know it... your StudentController would have 4 methods that arguably relates more to Subjects: drop\_subject, show\_subjects, update\_subjects.

 

In a CRUD-only world, since controllers are preferred to operate with CRUD-only constraint - and neither Student's nor Subject's CRUD should handle that - let's create a StudyController instead. Now, operations on this student-subject relation will occur simply as CRUD operations in the StudyController. Makes everything equally simple and awfully consistent.

 

Then he builds on top of "_if its a CRUD-only world anyways_" and introduces the concept that had just hit him [a few days ago](http://www.loudthinking.com/arc/000592.html): Active Resources. Basically, resources which can be operated upon, behind the scenes, via RESTful CRUD URLs. And of cos, with Rails-style conventions, you _KNOW_ it will be easy.

Note: The idea is just to model web resources, not to abstract away the underlying engine (sql or url?) for a single model object. To quote his reply (roughly), "_I don't believe in just flipping a switch and swapping the underlying technology... These things will leak._".

When I saw the slides, I got a flashback to a 2005 Adam Bosworth speech: [MySQL, don't scale like Oracle! Think bigger!  
](http://www.itconversations.com/shows/detail571.html)

If truely scalable data store is what Adam Bosworth has described (and [GData](http://code.google.com/apis/gdata/) is apparently Google's implementation of such infrastructure) then Rails is well on its way. Taking big strides towards it (knowingly or not) while most other frameworks are still grappling over composite primary keys and plural table names controversies. 

Rails 1.2 is going to be very, very interesting.

 

Note: Shucks.. [KRJS](http://choonkeat.svnrepository.com/svn/rails-plugins/krjs/) naming convention needs a new home then?

