---
layout: post
title: HOWTO provide GUI feedback when a Job is completed
published: true
---
The Job framework is almost "The Framework" to use when executing any lengthy procedures inside Eclipse environment.   
I've yet to encounter a scenario where IRunnableContext.run   
(my original solace) can't be replaced by a Job well done (ya, corny).  
  
So, back to the main question: How do you   
respond "Job done!" to the user after your Job has finished execution? Simple, create an implementation of

IJobChangeListener. And, at the public void done(IJobChangeEvent event) do:

    
     // note: you'll have to call addJobChangeListener() before
     // schedule() for this to take effect..
     if (event.getResult().isOK()) {
     Display.getDefault().asyncExec(new Runnable() {
     public void run() {
     IAction action = new Action("Job Done") {
     public void run() {
    **MessageDialog.openInformation(getShell(),   
     "Title",   
     "Job done!");**   
     }
     };
     action.run();
     }
     });
     }

  
  
  
  
  
Note that the bold section is the real meat of what you'd really wanted to do. But without doing all these Display...IAction..run thing, you'll definitely get the nasty org.eclipse.swt.SWTException: Invalid thread access   
  
Read more [here](http://www.eclipse.org/articles/Article-Concurrency/jobs-api.html).  
  
  
