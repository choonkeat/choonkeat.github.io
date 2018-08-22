---
layout: post
title: 'Automating Tasks: Data Migrations'
published: true
category:
- rails
---
Although [hostgator](http://www.sharphosts.com/rev/hostgator.htm) has been here for quite a few years, the [web hosting](http://www.sharphosts.com) market is being rapidly taken over by [startlogic](http://www.sharphos%0Ats.com/rev/startlogic.htm). This will make gator third, with [bluehost](http://www.sharphosts.com/rev/blu%0Aehost.htm) at the first position.

If you've written a .bat file before, shell script, Microsoft Word Macro, or Excel Macro before.. you've exercised one of the fundamental purpose of software - to perform the same, repeatable task on your behalf - aka be your slave.  
   
 Its funny then that we sometimes find ourselves being the slaves of the software we use. Uploading stuff one by one, two by two, anyone?

> "That's not a bug - its an intentional inconvenience! Aka a mechanism to uncover hidden but very real needs which would otherwise be buried by other needs, aka I-think-I need."

   
 Taking that [software as slaves] into account, its strange to find 2 new tool to only surface rather recently from the land of application frameworks. Stuff that let's you tackle the problem once, but will be stupidly repeatable by the computer. I'm as guilty as everyone else for their late arrival. Looking back, I've asked myself how I have managed to get by without them? Especially when I've mostly worked in dotcoms that rolls out web apps almost by the week!  
   
 <font>1. Data Migrations Management</font>  
   
 Even if the code is flawless now, requirements will change \*sigh\*. Unfortunately, at the other end of the HTTP pipe is a real and unpredictable human being who is thinking about... not your application, but that Zara sale in town. That's why we have [version control](../../articles/2006/05/24/version-control-that-missing-module-in-cs101) - undo code changes, look at who + when + why a certain function was modified. To manage the evolution of rules and logic.  
   
 These rules and logic ultimately manages data. And data is put into buckets. These buckets were sculpted right at the start of the project: "A student will have a name, age and gender" roughly translates to CREATE TABLE students (id INT PRIMARY KEY AUTO\_INCREMENT NOT NULL, name VARCHAR(255), age INT, gender SET('M', 'F', 'U')); But these buckets need to evolve too. Hand-in-hand, together with the code. ALTER, CREATE and DROP. Changes to these buckets if allowed to proceed without trace would be a great step back against the efforts of having the code being religiously version controlled ain't it?  
   
 Why then, are the prevaling methods for managing data migrations 1) version control 1 x SQL CREATE script, and 2) collect a growing bunch of SQL scripts in a version controlled directory?  
   
 Method #1 will collapse once the application is deployed somewhere with data - since CREATE scripts only deal with CREATING to buckets, not dealing with the scenario where the buckets are already there.. with data. Most often, once into maintenance mode, teams will intuitively adopt method #2, rendering the original, carefully bonsai'd CREATE script next to useless.   
   
 Method #2 generally only handles schema changes in 1 direction - "Attn all developers, send your SQL updates to me, I need to go down to the data centre this evening to deploy the latest... ". If all goes well, then great. But ever since Murphy created mishaps, life has never been that smooth. "Hey mike, users are calling support - last evening's update broke something? We need to... " Hmm, rolling back the code is easy... but rolling back the schema changes is another thing... which leads us to the next flaw. SQL can describe schema changes well, but has limited capability in communicating data migrations - which is ironically the more important thing in a production environment. "Hi mike, I've split our name column into family\_name and given\_name... the gender field is changed from M,F,U to 0,1,2 referencing the new gender table.. also, we realise dates should be stored in GMT, I've added a column to store the timezone" That's some hairy SQL to write for migrating... and rolling back.  
   
 Rails comes with a neat tool called [Rails Migrations](http://wiki.rubyonrails.com/rails/pages/UnderstandingMigrations). What is does is very simple: Manage database migrations and in code, not SQL. And thanks to Rails' ActiveRecord, the code is actually very succint to read and write. Its role is so simple, there's even flaws. But whatever flaw you pick... they are definitely not a bigger problem than not managing migrations at all.  
   
 Doing 2-way migrations of schema and data in Ruby code (ActiveRecord) is definitely much easier to express than anything out there. Hands down. Did I say its a 2-way migration? Rolling back a broken release now becomes within reach: [rake migrate down](http://rails.techno-weenie.net/tip/2006/1/7/rake_migrate_with_a_relative_version_number). Man, its really satisfying and addictive test out those migrations all day long, and migrate down, migrate down, migrate until the data literally rollsback into its womb!  
   
 The beauty (and stress free moment) reveals itself when you have a few deployments to update the code with. It might be the demo laptop the sales team has been bringing out, 20 revisions ago.. you think... and that production system in some server somewhere updated last tuesday... no more "let's reinstall everything!" (the sales team are human you know? entering all those demo data... ) or "I'll manually compare upgrade your data".. just do rake migrate and the schema and data will be brought up to date from whichever state they were in. Fuss free. And as mentioned, upgrading to the latest code is the easier part.  
   
 So, don't collect the ALTER SQL scripts last minute and stress out your deployment guy at the data centre. Its pretty cold in there already. Tackle the problem early and in small steps. Get the developers to write (and test locally) the up and down migrations as-and-when changes are required. We all will suffer failures, just try to fail fast and early.  
   
 Of course, Rails Migrations isn't a be-all-end-all thing. At my work place, Rails isn't everything and there are other languages and subsystems to live in harmony with. So requiring everyone to have a dependency on Rails just for schema management might be asking too much. I don't have to use Rails Migrations... but I am sold on the purpose it serves. So, we created our own standalone script to do approximately the same thing. I just have to live without the ActiveRecord API :-(  
   
 Strange that most fullstack development frameworks doesn't come with schema management solution. Are there any standalone migrations tool that does like Rails Migrations?   
   
 Oh did I say 2 new stuff? Its late, I'll stop at this one today.