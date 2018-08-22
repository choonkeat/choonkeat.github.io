---
layout: post
title: Most basic, foundation understanding of Eclipse framework before diving to
  anything else..
published: true
---
> **FAQ 305 How do I access the active project?**  
>   
> This question is often asked by newcomers to Eclipse, probably as a result of switching from another IDE with a different interpretation of the term project. Similarly, people often ask how to access the active file. In Eclipse there is no such thing as an active project or file. Projects can be opened or closed, but many projects may be open at any given time.   
> - [Eclipse FAQ](http://eclipsefaq.org/chris/faq)

There is no current project or active project. If you're doing an editor, retrieve your IProject reference from your edited file, see IResource.getProject(). If you are doing a directories modification, search - refer to the last selected resource in the package explorer. Or detect the active editor (does this even work?) and get the IFile from that editor, and do IResource.getProject() using this file.

Always treat as if you're "currently" at another "active project", and have to switch to the one of your intent. That'll be safest.

