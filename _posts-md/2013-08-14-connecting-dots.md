---
layout: post
title: Connecting Dots
published: true
---
I was [listening](http://soundgecko.com) to [a post from High Scalability](http://highscalability.com/blog/2012/11/5/gone-fishin-building-super-scalable-systems-blade-runner-mee.html) today, and it reminded me of this old talk

> the spread of an epidemic can provide a model for the spread of information throughout a network and … techniques based on that model can be used to create ultra-scalable software infrastructures that exhibit unparalleled robustness and scalability properties.   
> — [Werner Vogels, E-Commerce at Interplanetary Scale](http://itc.conversationsnetwork.org/shows/detail459.html)

Taken to its logical conclusion, instead of our familiar client-server architectures, “everybody” will have to be hosting a piece of the system in order for us to reach where Werner Vogels describe: scale is no longer a problem to tackle but like a virus, the more nodes there are, the more robust the system.

Even if we solve the technical issues, the first big hurdle is actually: how do we convince everyone to run a piece of infrastructure 24x7?

### Go To Market

At AllThingsD, when asked to comment on a TV product, Steve Jobs implied that the problem is not purely technical; he rightfully pointed out that there was no [good go-to-market-strategy](http://tech.fortune.cnn.com/2011/12/23/video-steve-jobs-on-tvs-go-to-market-problem/). To appreciate how a go-to-market-strategy can make or break a product, let’s consider the original iPhone: a beautiful jewel in your hands, but a rather lame cell phone (poor battery life, no 3g, no keyboard)

Who knows if the entire vision was already there, but the initial focus was solely on the beautiful device & beautiful interface. While flying lame and humble under the radar of incumbent players, get _this pretty device_ into enough affluent people’s hands, and while they’re smitten, require an unlimited data plan (imho, a critical but understated move in 2007).

Later, a reveal: hey Mac developers, a few million rich people is using our phone, running your familiar OS X, has 24x7 internet connection, plays video, mp3, has GPS, has Google Map, real web browser, multi-touch, accelerometer, camera, compass… Wanna sell them some apps? (you _have_ to time-travel back to 2007 to appreciate how impossibly desirable that was)

The proverbial chicken and egg hurdle was deftly leapt over with a feint.

### Interplanetary Scale

Space Monkey says they are [taking the cloud out of the datacentre](http://www.kickstarter.com/projects/clintgc/space-monkey-taking-the-cloud-out-of-the-datacente), then they talk about the [1TB of storage… your photos, videos, documents, and music](http://www.spacemonkey.com/). You’d think they’re building a Dropbox, iCloud or Amazon S3. Perhaps they do really mean just that.

But let’s assume they don’t :-)

### Feint

While Dropbox is a darling right now and “Cloud” is buzzword, Space Monkey is quite a desirable consumer device. So use that story and get the device into the hands of a big enough group of geeky people (Kickstarter hurray!)

Later, a reveal: hey developers, we have a big group of rich geeky people hosting our computer servers across the globe, powered up and connected to the internet 24x7, with a TB of storage each… Wanna sell them some apps?

### Botnet App Store

What if an app running on this “data center” cost nothing extra to scale up? Instead of paying for computing resources in East Coast of USA to serve users in Australia, how about if every user “pay for their fair share” instead?

Let’s say users install your app from Space Monkey “app store”, onto their own device. Your app runs off that device at home, stores their own content there too. Users can still access your app from Starbucks like a regular SaaS app (Space Monkey “data centre” platform takes care of that, no worries)

Nay sayers may immediately say “that’s a lame data centre! you can’t possibly launch a search engine this way!”. Some types of app won’t work well (Google.com, Amazon.com), but others could potentially thrive (Shopify, Gmail, Dropbox).

And being lame to incumbent products is not always a bad thing.

### “If you’re not paying for the product, you are the product”

Like an iPhone, the device belongs to the customer, and they’d have to explicitly install apps from an app store. The result is, developers can easily charge money for the app in a way that agrees with how people pay for things. Thanks Apple AppStore, for training the mass consumers!

A side effect is, since you’re now selling your app, you no longer need to sell your users: Hey, your product has no ads.

### Epilogue

There once was a social network idea pitched to me: an anti-Facebook.

With superb privacy configs, access controls so anal that the infrastructure requires each user to store content in their own harddisk (Ha!). No big brother. No subpoena. I told my peers they’re crazy.

Perhaps they’d just needed a better go to market strategy.

