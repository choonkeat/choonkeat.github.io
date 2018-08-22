---
layout: post
title: 'CommandLineTask: Running Ant repeatedly without the slow inits'
published: true
category:
- software
---
I'm not sure if this was already out there somewhere. But I sure didn't find it. Anyways, my very slow (0.3GHZ) machine was coughing all the way whilst I'm trying to write some Java program at home, compiling them with [Ant](http://ant.apache.org/). Frustrated with the start-up delays, I wrote this very simple task to allow invoking of ant targets at will - without the slow startup that Ant has, everytime its called - [CommandLineTask.java](http://www.yanime.org/CommandLineTask.java)  
To use, just add a new task definition into an existing build.xml:

> \<taskdef name=" **command**" classname=" **org.yanime.ant.CommandLineTask**" /\>

And add a new target, say "cmd":<!--StartFragment -->

\<target name="cmd"\>  
 \< **command** /\>  
\</target\>  

Easy. Now, run your build, invoking the "cmd" target and you'll get a prompt. Type in any targetname to continue / repeat your process. The command line will remain until you type !. With so much speed up (22secs compile now takes 3 seconds!) for so little work (96 lines), I really wonder why I'd never written this helper earlier. Sigh.  
  
The only caveat is, don't use it if any classes used by Ant is being changed and needs a refresh (e.g. whilst developing CommandLineTask which is part of the taskdef in the build.xml) - but that's pretty rare.  
  
Update: Ok, looks like a decent sized compile eats over 100MB of RAM and that remains used, no matter how many times you recompile. So a best-of-both-world solution will be to exit ANT after every input commandline, but restart ANT to the command task's prompt immediately so that the next compile / commandline can start immediately without waiting for ANT's slow startup - parsing build.xml. At least that seems to improve my edit-compile-test cycle using Ant.

  
