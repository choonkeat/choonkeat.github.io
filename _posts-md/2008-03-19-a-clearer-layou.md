---
layout: post
title: A Clearer Layout For Viewing Timezones
published: true
category:
- software
---
After putting up [a job post for SharedCopy](http://jobs.37signals.com/jobs/2749) at the 37signals job board, I've gotten quite a fair bit of response and in turn, had to propose timings for Skype calls very often.

I hate timezones.

For my purpose (i.e. propose a time where all parties are at least awake!) I figure I'd just need a simple view of everybody's clock over a period of 1 day - which can be done in Ruby:

> 24.times do |hh|  
>  puts [+8, -7, -5].collect {|tz| Time.now.utc + hh + (tz \* 3600) }.inspect  
> end

Functional, but a chore to run and the output is still a mess to pick out information from. Then I did a proper one in Javascript, in case I ever need to use it while on the move... ;-)

> [![](http://farm3.static.flickr.com/2299/2345726166_fd42e55ca8_m.jpg)](http://dev.choonkeat.com/js/cleartz/index#,8,18,-6)

[Update] A few notes:

- The darker/ **shaded areas are ZZZ hours** - so just look for horizontals where the "whites" align.
- Your own timezone should automatically show up - so **most usage is only 1 click**.
- URL changes as you add timezones - so you **can even bookmark the page** and remember a standard set of timezones.
- Day-of-week is subtly indicated just so **you can tell if its the same day or otherwise**.
- **Name of location** is used instead of numeric offset (and **auto resized to fit** ) for a more humane experience



Try it out at [http://dev.choonkeat.com/js/cleartz/index](http://dev.choonkeat.com/js/cleartz/index)

