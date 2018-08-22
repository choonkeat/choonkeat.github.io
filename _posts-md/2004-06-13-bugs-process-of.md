---
layout: post
title: Bugs. Process of Testing
published: true
category:
- software
---
Fiddling with bugzilla just now.. and was contemplating on creating a button for our QA team to click on (instead of going to Bugzilla's enter bug directly)  
  
This button will trigger a process to

1. Place a unique stamp on log
2. Generates a URL (to view the log at the stamp, and -500 lines before it)
3. Redirects to bugzilla's enter new bug page, with the URL pre-filled into the bug description field.
Kewl.. this would be awfully useful to the developer receiving the bug.. Rather than trying to replicate the error and looking at the logs he'd _generated_ for answers.. the developer might as well visit the log of the _original_ incident directly..  
  
But...  
  
 Not all bugs would potentially have useful hints in the logs ya?.. what if the log rotates dammit.. my viewer has to cater to that - dammit.. my viewer/stamper would be deployment specific.. and also, while I'm at saving the developer's time (avoid having to repeat the steps described)... I might as well save the QA's time in describing his steps in the first place?  
  
I mean, the QA is using a computer ya? A computer knows and can record everything that goes through it, ya? Why not have a  

1. Middle-layer sniffer to capture all to-fro traffic.. and a viewer counterpart that is able to (guess-timate) reproduce each originating (form fields prefilled)/resultant HTML page.. (how about javascripts on forms?)  
2. QA-specific-browser that records the buttons clicked, etc.. (how about browser compatibility?)
3. QA-tool that wraps any browser to collect data.. (big engineering effort? how about playback?)  
4. Plugins to browsers to collect such data and counterpart plugins to playback such data?
The QA's steps would thus be reduced to  

1. Click 'Start Test Case'
2. Go about doing his thing,.. and some error occurs  
3. Click 'Report Bug'   
4. Go back to Step #1 to proceed with other things  
All the back-end Bugzilla-like stuffs of opening bug, issue tracking, logging, recording steps, notifying developer could be automated at Step #3.. I'm not seasoned in the field of testing.. I haven't even tried \*gasp\* JUnit.. and I'm not sure if a company like Mercury Interactive would've already had something like that..   
  
But I would believe I can use something like that.  
