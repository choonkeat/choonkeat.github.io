---
layout: post
title: Dirty Little Secret
published: true
category:
- rails
---
I've been doing more Rails development lately (yay!) but have something shameful to admit:

> I don't care what [variant of many-to-many relationship](http://blog.hasmanythrough.com/articles/2006/04/20/many-to-many-dance-off) the models have, I bulldoze with a same implementation everytime.

The [nuances and gotchas](http://blog.hasmanythrough.com/articles/category/associations) are too much for my liking. So rather than spending time groking them and risk [seeing them deprecated](http://dev.rubyonrails.org/changeset/4123) (not complaining, just note things are moving fast), I'd prefer to rely on simpler concepts which are hence more stable and has [least-surprise](http://www.artima.com/intv/ruby4.html) behaviors. Use the time saved to think about real important stuff: business requirements.

Simplifying the concept will mean a tiny bit more code - but lesser wrestling with the framework overall, IMHO. To represent any many-to-many relationship, opt for a rich-association database setup everytime (aka include an auto\_increment id in the join table), regardless of whether there'll ultimately be extra attributes. Defer decisions. Hence, _people.id == people\_skills.person\_id and people\_skills.skill\_id == skills.id_ in the database will be represented in ActiveRecord as:

    **<font>class</font>** Person <font>&lt;</font> ActiveRecord<font>:</font><font>:</font>Base
     has\_and\_belongs\_to\_many <font>:</font>skills
     has\_many <font>:</font>people\_skills<font>,</font> <font>:</font>dependent <font>=</font><font>&gt;</font> <font>:</font>destroy
    **<font>end</font>**
    
    **<font>class</font>** Skill <font>&lt;</font> ActiveRecord<font>:</font><font>:</font>Base
     has\_and\_belongs\_to\_many <font>:</font>people
     has\_many <font>:</font>people\_skills<font>,</font> <font>:</font>dependent <font>=</font><font>&gt;</font> <font>:</font>destroy
    **<font>end</font>**
    
    **<font>class</font>** PeopleSkill <font>&lt;</font> ActiveRecord<font>:</font><font>:</font>Base
     set\_primary\_key <font>:</font>not\_id _<font># int auto_increment primary key, cannot be named 'id'</font>_
     belongs\_to <font>:</font>person
     belongs\_to <font>:</font>skill
    **<font>end</font>**

There 2 lines more than _rightfully necessary_. But all the data will surely be accessible. If things turns out to be simple, your overhead is negligible. If requirements turns hairy, you're still safe! No worrying over any potential _has\_many :through_ quirks, or lack of support with _has\_and\_belongs\_to\_many_. Just go with the above setup - get some code running! - and everything can be optimised later. Wrestling more and things will begin to feel like unnecessary situps to me...

[Update]  
 Fixed the sample code above, apparently PeopleSkill's primary key should not be named :id. So its 3 additional lines instead of 2. A tour via ./script/console will be

    <font>&gt;</font><font>&gt;</font> Person<font>.</font>delete\_all
    <font>=</font><font>&gt;</font> <font>0</font>
    <font>&gt;</font><font>&gt;</font> Skill<font>.</font>delete\_all
    <font>=</font><font>&gt;</font> <font>0</font>
    <font>&gt;</font><font>&gt;</font> PeopleSkill<font>.</font>delete\_all
    <font>=</font><font>&gt;</font> <font>0</font>
    <font>&gt;</font><font>&gt;</font> s <font>=</font> Skill<font>.</font>create <font>:</font>name <font>=</font><font>&gt;</font> <font>"Swimming"</font>
    <font>=</font><font>&gt;</font> _<font>#&lt;Skill:0xb7855b3c @new_record_before_save=true, @attributes={"name"=&gt;"Swimming", "id"=&gt;1}, @new_record=false, @errors=#&lt;ActiveRecord::Errors:0xb78533a0 @errors={}, @base=#&lt;Skill:0xb7855b3c ...&gt;&gt;&gt;</font>_
    <font>&gt;</font><font>&gt;</font> jack <font>=</font> Person<font>.</font>create <font>:</font>name <font>=</font><font>&gt;</font> <font>"Jack"</font>
    <font>=</font><font>&gt;</font> _<font>#&lt;Person:0xb784da04 @new_record_before_save=true, @attributes={"name"=&gt;"Jack", "id"=&gt;1}, @new_record=false, @errors=#&lt;ActiveRecord::Errors:0xb784b268 @errors={}, @base=#&lt;Person:0xb784da04 ...&gt;&gt;&gt;</font>_
    <font>&gt;</font><font>&gt;</font> jill <font>=</font> Person<font>.</font>create <font>:</font>name <font>=</font><font>&gt;</font> <font>"Jill"</font>
    <font>=</font><font>&gt;</font> _<font>#&lt;Person:0xb784181c @new_record_before_save=true, @attributes={"name"=&gt;"Jill", "id"=&gt;2}, @new_record=false, @errors=#&lt;ActiveRecord::Errors:0xb783eb30 @errors={}, @base=#&lt;Person:0xb784181c ...&gt;&gt;&gt;</font>_
    <font>&gt;</font><font>&gt;</font> jack<font>.</font>skills <font>&lt;</font><font>&lt;</font> s
    <font>=</font><font>&gt;</font> <font>[</font>_<font>#&lt;Skill:0xb7855b3c @new_record_before_save=true, @attributes={"name"=&gt;"Swimming", "id"=&gt;1}, @new_record=false, @errors=#&lt;ActiveRecord::Errors:0xb78533a0 @errors={}, @base=#&lt;Skill:0xb7855b3c ...&gt;&gt;&gt;]</font>_
    <font>&gt;</font><font>&gt;</font> jill<font>.</font>skills <font>&lt;</font><font>&lt;</font> s
    <font>=</font><font>&gt;</font> <font>[</font>_<font>#&lt;Skill:0xb7855b3c @new_record_before_save=true, @attributes={"name"=&gt;"Swimming", "id"=&gt;1}, @new_record=false, @errors=#&lt;ActiveRecord::Errors:0xb78533a0 @errors={}, @base=#&lt;Skill:0xb7855b3c ...&gt;&gt;&gt;]</font>_
    <font>&gt;</font><font>&gt;</font> PeopleSkill<font>.</font> **<font>find</font>** <font>(</font><font>:</font>all<font>)</font>
    <font>=</font><font>&gt;</font> <font>[</font>_<font>#&lt;PeopleSkill:0xb781206c @attributes={"not_id"=&gt;"1", "skill_id"=&gt;"1", "person_id"=&gt;"1"}&gt;, #&lt;PeopleSkill:0xb7811ef0 @attributes={"not_id"=&gt;"2", "skill_id"=&gt;"1", "person_id"=&gt;"2"}&gt;]</font>_
    <font>&gt;</font><font>&gt;</font> jack<font>.</font>skills <font>&lt;</font><font>&lt;</font> Skill<font>.</font> **<font>create</font>** <font>(</font><font>:</font>name <font>=</font><font>&gt;</font> <font>"Dancing"</font><font>)</font>
    <font>=</font><font>&gt;</font> <font>[</font>_<font>#&lt;Skill:0xb7855b3c @new_record_before_save=true, @attributes={"name"=&gt;"Swimming", "id"=&gt;1}, @new_record=false, @errors=#&lt;ActiveRecord::Errors:0xb78533a0 @errors={}, @base=#&lt;Skill:0xb7855b3c ...&gt;&gt;&gt;, #&lt;Skill:0xb7809994 @new_record_before_save=true, @attributes={"name"=&gt;"Dancing", "id"=&gt;2}, @new_record=false, @errors=#&lt;ActiveRecord::Errors:0xb7807f04 @errors={}, @base=#&lt;Skill:0xb7809994 ...&gt;&gt;&gt;]</font>_
    <font>&gt;</font><font>&gt;</font> jill<font>.</font>skills <font>&lt;</font><font>&lt;</font> Skill<font>.</font> **<font>create</font>** <font>(</font><font>:</font>name <font>=</font><font>&gt;</font> <font>"Cooking"</font><font>)</font>
    <font>=</font><font>&gt;</font> <font>[</font>_<font>#&lt;Skill:0xb7855b3c @new_record_before_save=true, @attributes={"name"=&gt;"Swimming", "id"=&gt;1}, @new_record=false, @errors=#&lt;ActiveRecord::Errors:0xb78533a0 @errors={}, @base=#&lt;Skill:0xb7855b3c ...&gt;&gt;&gt;, #&lt;Skill:0xb77f5930 @new_record_before_save=true, @attributes={"name"=&gt;"Cooking", "id"=&gt;3}, @new_record=false, @errors=#&lt;ActiveRecord::Errors:0xb77f3b44 @errors={}, @base=#&lt;Skill:0xb77f5930 ...&gt;&gt;&gt;]</font>_
    <font>&gt;</font><font>&gt;</font> jack<font>.</font> **<font>skills</font>** <font>(</font> **<font>true</font>** <font>)</font>
    <font>=</font><font>&gt;</font> <font>[</font>_<font>#&lt;Skill:0xb77e2970 @attributes={"name"=&gt;"Swimming", "id"=&gt;"1", "not_id"=&gt;"1", "skill_id"=&gt;"1", "person_id"=&gt;"1"}, @readonly=true&gt;, #&lt;Skill:0xb77e2934 @attributes={"name"=&gt;"Dancing", "id"=&gt;"2", "not_id"=&gt;"3", "skill_id"=&gt;"2", "person_id"=&gt;"1"}, @readonly=true&gt;]</font>_
    <font>&gt;</font><font>&gt;</font> jack<font>.</font>destroy
    <font>=</font><font>&gt;</font> _<font>#&lt;Person:0xb784da04 @new_record_before_save=true, @attributes={"name"=&gt;"Jack", "id"=&gt;1}, @skills=[], @new_record=false, @people_skills=[#&lt;PeopleSkill:0xb77dce94 @attributes={"not_id"=&gt;"1", "skill_id"=&gt;"1", "person_id"=&gt;"1"}&gt;, #&lt;PeopleSkill:0xb77dcd54 @attributes={"not_id"=&gt;"3", "skill_id"=&gt;"2", "person_id"=&gt;"1"}&gt;], @errors=#&lt;ActiveRecord::Errors:0xb784b268 @errors={}, @base=#&lt;Person:0xb784da04 ...&gt;&gt;&gt;</font>_
    <font>&gt;</font><font>&gt;</font> PeopleSkill<font>.</font> **<font>find</font>** <font>(</font><font>:</font>all<font>)</font>
    <font>=</font><font>&gt;</font> <font>[</font>_<font>#&lt;PeopleSkill:0xb77cef88 @attributes={"not_id"=&gt;"2", "skill_id"=&gt;"1", "person_id"=&gt;"2"}&gt;, #&lt;PeopleSkill:0xb77cef38 @attributes={"not_id"=&gt;"4", "skill_id"=&gt;"3", "person_id"=&gt;"2"}&gt;]</font>_
    <font>&gt;</font><font>&gt;</font> quit 

The reason the original sample code wasn't working was **not** because of HABTM didn't create the primary key (as mentioned by Josh in the comments), but rather its precisely because it did try to include the id column in the INSERT statement (with a wrong value) thus causing primary key clashes and blah blah blah. Strangely, by changing PeopleSkill's primary key to be named something else, the INSERT statement would exclude it and insert only (`skill_id`, `person_id`), allowing MySQL to auto\_generate the primary key.

As long as the primary keys of Person and Skill are not called "id", PeopleSkill can happily use "id" as its auto increment primary key (as is with my original work). My force is not strong enough to attempt a patch / further investigation for this HABTM issue.

[Update 2]  
Plugin available to make habtm behave: [Download](../../../files/ticket5216.zip) and unzip into your vendor/plugins folder.

