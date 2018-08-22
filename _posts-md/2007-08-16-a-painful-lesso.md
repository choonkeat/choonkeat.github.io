---
layout: post
title: A painful lesson for myself to remember
published: true
category:
- sharedcopy
---
When you've configured to use Google Apps (or any 3rd party email service) to host your domain's email... remember to tell your own server not to receive email for that domain.

As obvious as it is, I screwed up this one badly by leaving /etc/postfix/main.cf in its default setting of:

> `mydestination = $myhostname, localhost`

When it should've been corrected to:

> `mydestination = localhost`

What happened is, after you've created many custom addresses in your 3rd-party email service, the whole world can send email to them... but not from your own server! You'd think you're sending the mail out, but Postfix tries to receive the email itself. But it can't. So it junks the mail and reports

> `550 5.1.1 <support@sharedcopy.com>: Recipient address rejected: User unknown in local recipient table`

Yep.

The wierd thing is... I'd used Google Apps since day #1, so how had the earlier emails been going out?

_Update: Mystery solved (I think). The SMTP server was up prior to being assigned its domain name hence everything "worked" since it was only receiving for "localhost". However once it restarts, and the actual configuration kicks in, all mails to the domain name stopped leaving the server._

