---
layout: post
title: 'ActiveRecord: Optimistic Offline Lock'
published: true
category:
- rails
---
Find of the day for me: Rails' ActiveRecord [supports Optimistic Offline Lock via lock\_version column](http://www.ruby-forum.com/topic/61754#62324). i.e. [this](http://www.martinfowler.com/eaaCatalog/optimisticOfflineLock.html)

    \>\> duck1 = Duck.find\_by\_name "Daffy"
    =\> #\<Duck:0xb75d2f64 @attributes={"name"=\>"Daffy", "lock\_version"=\>"0", "id"=\>"1"}\>
    \>\> duck2 = Duck.find\_by\_name "Daffy"
    =\> #\<Duck:0xb75cd08c @attributes={"name"=\>"Daffy", "lock\_version"=\>"0", "id"=\>"1"}\>
    \>\> duck1.name = "Daffy le duck"
    =\> "Daffy le duck"
    \>\> duck2.name = "Donald"
    =\> "Donald"
    \>\> duck1.save
    =\> true
    \>\> duck2.save
    ActiveRecord::StaleObjectError: Attempted to update a stale object 

