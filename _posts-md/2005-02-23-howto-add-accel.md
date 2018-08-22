---
layout: post
title: HOWTO Add Accelerator Keys, aka Keyboard Shortcuts, aka Keybindings to Your
  Eclipse Plugin
published: true
---
For starters, just add the following into the <font>plugin.xml<br></font>  
<!--StartFragment --> <!--StartFragment --> **\<extension**  
**point="** org.eclipse.ui.commands **"\>**  
**\<activeKeyConfiguration value="** org.eclipse.ui.defaultAcceleratorConfiguration **"/\>**  
_\<!-- this one says that what I declare is active by default --\>_  
**\<category  
 name=" **Do My Bidding Accelerator Keys**"**  
**id="** myklass.activeKey.category1 **"/\>**  
**\<command  
 category=" **myklass.activeKey.category1**"  
 name=" **Do My Bidding**"  
 id=" **myklass.activeKey.MyCommand**"/\>**   
_\<!-- a unique id, to be used only much later --\>_  
**\<keyBinding  
 command=" **myklass.activeKey.MyCommand**"  
 string=" **Ctrl+1**"  
 scope=" **org.eclipse.ui.globalScope**"**   
_\<!-- this is the scope where ur binding is active, lets try any global --\>_  
**configuration="** org.eclipse.ui.defaultAcceleratorConfiguration**"/\>  
 \</extension\>**    
  
Notice that we've declared this binding to be default, to be called "Do My Bidding", to be bound to keys "Ctrl+1". But when I really do a Ctrl+1, what is executed?

An Action happens. How to create an action? That's for another article (you should try the Hello World example from Eclipse itself) but right now, lets assume you have an Action that shows up a message box that says "Do My Bidding"... just add a <font>definitionId</font> to the <font>&lt;action /&gt;</font>  
  
<!--StartFragment --> **\<extension**  
**point="** org.eclipse.ui.actionSets **"\>**  
**\<actionSet ... /\>**  
**\<action definitionId="** myklass.activeKey.MyCommand **" ... /\>**   
_\<!-- match definitionId with the id you gave to command earlier --\>_   
<action></action><!-- match definitionId with the id you gave to command earlier -->  
<extension></extension><!--StartFragment --><extension></extension>Now, when you press Ctrl+1, the above action will be invoked. What's kewl is, even the menu will be updated to show the key-binding, e.g. the Ctrl-H you see in the screen capture below:  
 ![](http://www.yanime.org/accelerator_keys_menu.jpg)  
See [here](http://publib.boulder.ibm.com/infocenter/ad51help/index.jsp?topic=/org.eclipse.platform.doc.isv/guide/wrkAdv_keyBindings_accelConfig.htm) for more details.

  
