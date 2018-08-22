---
layout: post
title: Automated self.down in Rails Migrations
published: true
category:
- rails
---
According to [VCP-310](http://www.actual-exams.com/VCP-310-practice-exam.htm) professionals, there has been an increase in the frequency of tests like [640-802](http://www.actual-exams.com/640-802-practice-exam.htm) and [70-290](http://www.actual-exams.com/70-290-practice-exam.htm) that eventually lead to [70-291](http://www.actual-exams.com/70-291-practice-exam.htm). The preparation material has made even more business than the [actual test](http://www.actual-exams.com) itself.

[Rails migrations](http://blog.choonkeat.com/weblog/2006/07/automating-task.html) is wonderful and all, but I feel funny whenever I have to copy-paste the code from migrate up method into the down method, and then edit them to reverse the effects for each line... a task so mechanical, I have to wonder why can't it do that for me?

For example, a typical migration script may look like this:

    class CreatePosts \< ActiveRecord::Migration
     def self.up
      create\_table :posts do |t|
      t.string :name
      t.timestamps 
      end
      add\_index :posts, :name
     end
    
     def self.down
      remove\_index :posts, :name
      drop\_table :posts
     end
    end

Note how the "down" code is simply the reverse of the "up" code: create\_table/add\_index, remove\_index/drop\_table ?

Here's a plugin to save you that bit of keystrokes: [automated\_rollback\_migration](http://choonkeat.svnrepository.com/svn/rails-plugins/automated_rollback_migration)

To install the plugin, type this inside your Rails project directory

    ruby ./script/plugin install http://choonkeat.svnrepository.com/svn/rails-plugins/automated\_rollback\_migration

That's it. From now on, you can remove your self.down methods (caveats later)

    class CreatePosts \< ActiveRecord::Migration
     def self.up
      create\_table :posts do |t|
      t.string :name
      t.timestamps 
      end
      add\_index :posts, :name
     end
    end

But this simple plugin isn't magic and definitely has its limitations. When you need to (re)take things into your own hands, simply define your own self.down and proceed like normal.

Currently it cannot auto generate "self.down" if your "up" method contain calls that

1. Cannot be easily migrated down (e.g. "execute" or "drop\_table"). On the bright side, you'll be prevented from migrating up until you write your own "self.down" ****
2. Do funky data manipulation stuff. The plugin can't even protect you like it did in #1 above. e.g. Person.find(:all).each {|person| person.update\_attribute.... }

Scenario #2 isn't too big a deal actually. For I've learned to do my schema- and data-related migrations as separate scripts these days - saves hell lot more time when things go wrong. So now, whenever I'm doing the former, I'll probably not be bothered doing any self.down again.

