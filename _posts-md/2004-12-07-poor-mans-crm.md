---
layout: post
title: Poor Man's CRM
published: true
category:
- software
---
Sitting in the cold, cold data centre and supporting just-launched web-based systems isn't my idea of quality time. Calls pours in, asking about "Can you help me check why user XXX isn't being directed to the YYY scenario?", "What is user XXX's current status for YYY module?".. blah blah things you wonder why they never surfaced during UAT... I'm sure some of you will be familiar.  
  
What's a poor dude to do to help himself - if the app wasn't spec'd with CRM modules? Can't add in chunky libraries, can't restart server, or even dream about installing [TOAD](http://www.toadsoft.com/)....   
  
All you need is 1 x JSP file.  
  
For all you poor souls standing in cold datacentres, wielding unfriendly Solaris terminals with touchpads and lousy [sqlplus](http://www.uwp.edu/academic/mis/baldwin/sqlplus.htm)... here's my [Poor Man's CRM v0.1](http://blog.choonkeat.com/files/poorman_crm.jsp) - for you, [free](http://www.gnu.org/copyleft/gpl.html).

[![](http://photos11.flickr.com/16182671_2b6ea93cf9_o.jpg)](http://www.flickr.com/photos/choonkeat/16182671/)

Fill in the JDNI datasource, database owner, table, column and value.. see the "e.g." And click "Display", the script will

1. Find the record you're refering to from the originating table
2. List all constraints pointing in and pointing out of that table, in a html table
3. Display all corresponding foreign-key values, in a html table

This is currently good enough for me. Rightfully, I should recurse down the foreign-keys and do more clean ups.. but this will save my life for now. Hope it does for you.

