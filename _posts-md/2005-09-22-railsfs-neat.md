---
layout: post
title: RailsFS! Neat!
published: true
category:
- life
---
Imagine, mount a database as a file system (e.g. D:\ ). Inspect your data and edit it in yml (yml is a less verbose xml)  
  
Kewl?

> Now, run mkdir ~/railsmnt. Then, script/filesys ~/railsmnt. The rules are as follows:  
>   
> 
>   
> 1. ls ~/railsmnt will give you a list of tables.
>   
> 2. ls ~/railsmnt/table will list IDs from the table.
>   
> 3. cat ~/railsmnt/table/id will display a record in YAML.
>   
> 4. vim ~/railsmnt/table/id to edit the record in YAML!
>   
>   
>   
> - [why the lucky stiff](http://redhanded.hobix.com/inspect/railsfsAfterACoupleMinutesOfToolingWithFuseWhoa.html) (that's his real name, btw)

  
  
<center> <a href="http://www.robbyrussell.com/albums/Desktops/railsfs.jpg"><img src="http://www.robbyrussell.com/albums/Desktops/railsfs.sized.jpg"></a> </center>   
Note: I know it doesn't work on windows, yet, the example D:\ is chosen because it'll relate to more people.  
  
