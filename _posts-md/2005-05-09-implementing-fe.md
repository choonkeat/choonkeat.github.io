---
layout: post
title: Implementing Feature Project add-on to an Eclipse Plugin Project
published: true
---
I may be ill-informed, but to me implementing a Feature means getting an icon at the Help \> About Eclipse Platform dialog. An icon beside the default, blue Eclipse icon. An icon for the developer to click on and bring up yet-another-dialog, listing the plugins my Feature contains.. together with some professional looking details about the whole thing.  
  
But, getting that icon to appear apparently isn't easy. For a start, I couldn't find much (any!) details on the bare minimum stuff I need to specify. Now, before I forget.. I'll better write them all down. Prequisites:

1. A plugin project in your workspace that is working fine. (Let's call it plugin id org.yanime.plugin)
2. Create a Feature Project via File \> New \> Projects \> New Feature Project
3. Feature ID: Preferably the same ID as your plugin (org.yanime.plugin)
4. Feature Name: anything goes
5. Version: anything goes
6. Provider Name: I haven't investigated, but I'd assume it should be the same as your intended plugin
7. Branding Plugin: Apparently, if your Feature ID != plugin id.. you'll have to state your plugin id here. Else, just leave it blank.
8. Banner Image: any 32x32 gif image, put at the root folder of your Feature Project
9. Go to "Build" tab and make sure your image and feature.xml is included in the binary build.
10. Go to "Content" tab and include your plugin (org.yanime.plugin)
You've completed your Feature Project. You can now Right Click \> Export \> Deployable features \> ... and have a nifty .zip file to install. But, does it work? No! Who the hell knows you've to add more stuff into your plugin? So now, go back there to your workspace and open up your plugin project..  
  

1. Copy these set of files from other existing plugins (e.g. eclipse/plugins/org.eclipse.jdt\_3.0.1)

- about.ini
- about.mapping
- about.properties
- eclipse32.gif
- I forgot, but in case it doesn't work, grab welcome.xml and about.html as well.
- Inside about.mapping, there is only 1 effective line, 0=xxxxx, don't change the 0=. the xxxxx is what will appear in place of {0} inside about.properties (by default, used for Build id)
- Now, edit your plugin.xml \> build (or edit build.properties directly) and make sure these files are all included in your plugin's binary build.
Only now, then you can truely export your Feature Project.. (it'll produce 1 x zip file including your Feature and Plugin project files). The above only includes the bare minimum of getting your own little feature icon appearing on the About dialog of Eclipse. Play around with those files and values and images to customize to your liking.  
  
And also, I think as long as the Feature's Provider Name is the same, they'll share the same icon. Upon clicking that, the list you see is the list of Features under that Provider Name. So, if you have 10 plugins and 1 feature, you'll only see 1 listed. If you want all of your plugins to show up with the descriptions and all, you'll have to create a Feature for each plugin.  
  
  
