---
layout: post
title: P2P File Editing Mechanism
published: true
category:
- software
---
"Ah.. why can't we all work on this spec together, in a more efficient manner?" Right now, we're going through some DTD.. options are 1) we gather and discuss the whole spec, 2) 1 person write, distribute, others comment, person consolidate and repeat until done.  
  
Option 1 is going to be a slow baking cake with nobody doing anything constructive for a few days. Option 2 is too slow an iterative process, and more importantly, with nothing usable in the mean-time.  
  
What I want, is multiple, simultaneous editing of a document. We can ICQ each other in real time, keystroke by keystroke.. why can't that asynchronous-ness come into word processing? But there's [Whiteboard](http://www.microsoft.com/windows/netmeeting/features/whiteboard/default.asp), and etc! They're too cumbersome.. Are you asking for [(another) lightweight editor](http://www.writeboard.com/)? But what about my non-text files like .doc, .xls, ... I really don't want to not use my MS Word!   
  
The usefulness must show itself seamlessly. There cannot be an overhaul of applications that existing users are already using. The process of doing must be exactly the same as before this-new-thing was introduced. Minimum disruption = maximum adoption potential. That's why the solution cannot be yet-another-editor. It must be a mechanism.   
  
P2P is chosen not because P2P is a buzz word, but because minimum disruption means no server to setup. No spare machine required. No disruptions....

Mary double-clicks The-New-Thing installer. "Install successful" screen appears and she dismisses it by clicking "Ok". Nothing else happens. And she proceed with her daily tasks..   
  
She opens the company's network folder and double click on the "Company New Benefits Policy - Need Feedback - Pls Edit.doc".   

<font>The-New-Thing creates a hidden file, perhaps with ".edit." + filename format. This little file holds the information of the first editor, Mary. If it helps, you can think of it as a </font>[<font>BitTorrent</font>](http://bittorrent.com/)<font> seed.</font>  
  

She reads and scrolls down.. "dinner allowance $10.., nothing to do with me.." she continues scrolling and something catches her attention. "maternity leave - 2 weeks paid, optional 1 week unpaid? Wha the!" and she edits that line to now read "maternity leave - 6 weeks paid" and lets out a sigh of relief.  
  
A little message [appears sneakily from below](http://www.by-users.co.uk/faqs/otherfaqs/msn/images/msn_alert.jpg), "JOHN-IBM ThinkPad opens Company New Benefits Policy - Need Feedback - Pls Edit.doc". Hm, what's that? As it seem harmless, she ignores it.  

<font>"JOHN-IBM ThinkPad" is the other peer's PC name, or any kind of identification means. The other machine has just opened the same file, detecting the hidden file, has started to communicate with Mary's The-New-Thing - BitTorrent-style.<br>How does The-New-Thing workaround applications (like MS Word) features to make second editor "Read-Only"? Perhaps a sleight-of-hand to make them only edit a copy-of. Other non-The-New-Thing users will still hit the "Read-Only" constraint, but fellow users can edit freely.</font>  

  
Nothing else to feedback on, she scrolls up.. and notice something else has changed, "dinner allowance $".. "$2".. "$20". Its changing! But Mary didn't type anything?! The cursor changing the words isn't Mary's - It has a life of its own.. and carries a translucent tooltip-like tag that says "JOHN-IBM ThinkPad". Surreal!  

<font>For each peer, there a cursor representation. These peer-cursors does not affect the scrolling or current text position of Mary. She page-up, scrolls down as per she normall does. The peer-cursors are only an illusion painted by The-New-Thing.<br></font>
  
[insert possible scenarios where they can chat side by side. but may be out-of-point since chat can/should be done by other means]  
  
Mary saves and closes the document. JOHN-IBM ThinkPad, on the other side of the office types away.. ignoring a little, sneaky message "MARY saved and closed Company New Benefits Policy - Need Feedback - Pls Edit.doc"  

<font>I'm trying to reserve the possibility of one peer not saving, and closing the document. The other peers must rollback the changes done by that user. Too hard? Initial thoughts was to store action-history like Photoshop.. but perhaps, <a href="http://openpgp.vie-privee.org/csdiff.png">a binary diff</a> system will be sufficient and efficient?</font>   

Hmmpossible?

