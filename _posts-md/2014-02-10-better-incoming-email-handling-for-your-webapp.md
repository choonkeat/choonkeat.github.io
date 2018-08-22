---
layout: post
title: Better incoming email handling for your webapp
published: true
---
A standard feature in a webapp is to send emails to an end user. This can be done by

- using the locally installed [mail transfer agent (MTA) like postfix](http://www.postfix.org/) (not available on heroku)
- paying a bit of money and using SendGrid
- [sending directly to the recipient smtp server](https://github.com/andris9/directmail) (doesn’t work well if you are on ec2)

What happens when your user replies to that email, using email? You could stonewall with a non-existant `donotreply@example.com`… but how about when you _do_ want to handle a reply? Add a link in the email saying `click here to reply using our web interface`? I find that UX onerous and usually terribly slow e.g. working through my inbox during commute.

A better UX would be to allow an actual email reply.

### Incoming email

Handling incoming emails might seem like dark waters for web developers. Many solutions offered on stackoverflow & mailing lists usually involves gmail, imap and polling.

Polling. Ugh.

### Event driven incoming email

A better way is to pipe incoming email directly to your application for processing. And for web developers, “pipe” preferably means a `HTTP POST` into your favourite web framework. aka a Webhook.

A quick overview of such setup is:

1. Point `MX` dns entry for your domain to the server that can receive email (e.g. ubuntu with postfix installed); this server _can_ be a different server from your webapp
2. Configure `postfix` to handle that email with an [smtp-to-http shell script](https://gist.github.com/choonkeat/3225691)
3. Now every incoming email is just a regular HTTP form post to your webapp. Throw the blob of email content into a parser like [mail](http://rubygems.org/gems/mail) or [mailparser](https://npmjs.org/package/mailparser) and you’d have a handy email object to manipulate.

Configuring your own `Postfix` server and installing that script to work with `Postfix` might be difficult to some, walk in the park for others, but definitely a hairy piece of infrastructure to keep around. You can make things less hairy by paying a SaaS provider to take care of #1 and #2, but there are caveats.

### Reply-To as Identifier

Most webapps I see uses a custom `Reply-To` email address (e.g. Basecamp & Github) In this design, an email notification sent from Discussion `id=42` would use `Reply-To: discussion-42@webapp.com`; an email notification for Discussion `id=99` would use a different `Reply-To: discussion-99@webapp.com` address.

When a user replies via email, the webhook handler parses `To: discussion-42@webapp.com` header, retrieves `Dicussion.find(42)` and create a new discussion comment on behalf of `User.where(email: email.from)`, using the email html/text body as `comment.body`.

Unfortunately, unless you pay [an arm and a leg](www.cloudmailin.com/plans), you’ll only get 1x email address to use as your `Reply-To`. Also, any attachment in the email would be lost.

So having unique-per-conversation `Reply-To` address is inefficient & restrictive your infrastructure options.

### Discussion Thread

One more thing.

Unless you want your webapp’s email messages to reach your user’s inbox as individual, annoyingly unrelated messages, your job is actually not done yet.

A conversation in your webapp should ideally be threaded in the same manner in your user’s inbox (e.g. see Basecamp discussions & Github Issues). So when `userX` comments on `Discussion 42`, the outgoing email notification sent to other participants of the discussion should properly set `In-Reply-To: <discussion42messageid>` and `References: <discussion42messageid>` in order for them to thread properly in Gmail, Apple Mail and presumably anything else. Having a matching mail subject is essential too, but that’s the easy part.

By now we’d have a module to manage mapping of `Discussion` records to-and-fro `Reply-To` values. And another module to manage a consistent value of `Message-Id`, `In-Reply-To` and `References` for `Discussion` records.

Seems unnecessarily complicated.

### Message-Id as Identifier (duh)

We can simplify the design by giving up unique-per-conversation `Reply-To`.

Uh? Then how do you know if an email replied `To: standard@webapp.com` is for `Dicussion.find(42)`? We look inside the values array of `In-Reply-To` + `References` instead.

For example, an outgoing email from your webapp just need to craft the correct, unique-per-conversation `Message-Id: <discussion-42@webapp.com>`. A email reply to that will automatically contain these headers

<figure><div><table><tr>
<td><pre><span>1</span>
<span>2</span>
</pre></td>
<td><pre><code><span>In-Reply-To: &lt;discussion-42@webapp.com&gt;
</span><span>References: &lt;discussion-42@webapp.com&gt;</span></code></pre></td>
</tr></table></div></figure>

And our webhook handler can still locate Discussion 42 based on values array of `In-Reply-To` + `References`. Thus, managing `Message-Id` alone will suffice.

Warning: earlier we mentioned using `email.from` to identify the `User`, but that’s not reliable since email `From:` header can be easily faked. A better mechanism would be to embed the author identity in `References`

### Summary

A quick summary of this scheme is

1. User#1 create new Discussion#42 with User#2 as participant
2. App delivers ‘new discussion’ email to User#2 with `Message-Id: <D42>` and `References: <D42-U2SECRET>`
3. User#2 replies to email, email automatically carries `In-Reply-To: <D42>` and `References: <D42> <D42-U2SECRET>`
4. Webhook handler picks up `D42` to retrieve Discussion#42, and picks up `U2SECRET` to locate User#2 and proceed to create a comment
5. App delivers ‘new comment’ email to User#1 with `References: <D42> <D42-U1SECRET>` (notice `Message-Id` doesn’t matter from here onwards)

### Diymailin

That could be the end of the story for most people, but for [various reasons](https://github.com/develsadvocates/runtimeerror.js) I couldn’t afford to have an unreasonably low cap on the number of incoming emails, and have attachments stripped.

So for my own setup, I pay $5/month for a [Digital Ocean](https://www.digitalocean.com/?refcode=8d52e959ad0f) box to run a [diymailin](https://github.com/choonkeat/diymailin) instance. With that I can support the numerous apps that I have using diymailin’s built in web interface, without mucking around with arcane `postfix` config.

### Mail2Webhook

But if you’re too lazy to setup your own diymailin instance, you can hop on to [mail2webhook.com](https://www.mail2webhook.com/) and use my setup instead.

