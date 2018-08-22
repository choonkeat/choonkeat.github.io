---
layout: post
title: Unproductive Day
published: true
---
I did nothing yesterday... because [James](http://james.seng.sg/2007/09/24/home-sweet-home-2/) delivered a surprise (I'd forgotten about the purchase) from his Techcrunch trip during lunch:

[![](http://farm2.static.flickr.com/1412/1436475484_de059e6a19.jpg)](http://www.flickr.com/photos/choonkeat/1436475484/)

The picture here shows iPhone running a VT100 terminal, executing "ps" command. Neat.

The SIM card is [working](http://modmyiphone.com/wiki/index.php/IPhone_unlock_OS_X_Part_1). Contact list imported via the long way: [Nokia 6233](http://www.nokia-asia.com/nokia/0,,85259,00.html) -\> [PhoneDirector](http://www.macmedia.sk/download.htm) -\> Address Book -\> iTunes -\> iPhone (all this trouble b'cos iPhone's Bluetooth is crippled... for now)

The display is **very** bright, brilliant and colorful. Basically, its like holding a fishtank of widgets. Reading and nudging the email with my finger feels like I'm pushing a piece of real paper. Very nice asthetics.

After getting pampered with the flick interface for a while, doing the 2-finger scroll on my MBP (which I'm usually very happy with) makes the laptop feel... limp. A more subtle [Compiz](http://www.youtube.com/watch?v=icm7GGCPOt8) maybe good? I don't know.

Oh ya, there's an app called [Apptapp Installer](http://modmyiphone.com/wiki/index.php/IPhone_unlock_OS_X_Part_3) that comes with the hack, which is basically a "apt-get" (or "synaptic" or "yum" depending on which Linux flavour you come from). I'm an idiot because I can't seem to figure out how to get pass the welcome screen for Doom :-P

Generally, lots of stuff on the device to waste my time with (I guess the same for all smart phones). But most of the [application] features are flawed in some small way. e.g. My mails from Gmail isn't my Gmail inbox, but my "unread emails", i.e. ignoring my gmail filters, and there's no way to do otherwise. The wifi reception is much weaker than my MBP (1/3 bar vs 3/4 bars in this corner of the office).

But I can ssh to it, deal with the phone's filesystem like a computer ([sshfs](http://fuse.sourceforge.net/sshfs.html)). That alone makes the phone head and shoulders above other phones, IMHO.

PS: Had a little scare after 2 hours of using it - my SIM card wasn't working (oh no! a brick!). I ran the "Installer.app" (which I wasn't supposed to) and it worked again. Looking at the difference in "ps", my guess is (if this helps anyone), that this process had crashed earlier: /System/Library/Frameworks/CoreTelephony.framework/Support/CommCenter

