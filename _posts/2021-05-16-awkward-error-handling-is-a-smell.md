---
layout: post
title: Awkward error handling is a code smell
published: true
---
Say you have a need to pretty print an email address string inside one of your view component and you have the urge to say _hey, this pretty printer component shouldn't print if the email address isn't valid, like a blank username_. The options to error out seem awkward and not great...

Stop. That's not a good place to _start_ being concern if a value is valid. 

If you have to push out something fast, I'd recommend just go ahead and pretty print the given value in a best-effort manner; no error handling. Then find time to refactor.

But refactor to what? Handle the validation concern MUCH earlier in the system: upon receiving the email string (from db? from api response? from user input?), parse it into a proper data structure, e.g. `EmailAddress`. If the parse failed, you'll find that error handling is very natural (db query error, api response invalid, user input error). If parsing succeeded, now pass this `EmailAddress` type value around your entire system instead of that original email string.

Once your entire system is refactored to deal with `EmailAddress` instead of email address strings, you'll find your original problem (what if the email I want to pretty print is invalid?) simply does not exist anymore. An even stronger guarantee can be had if your language can enforce that `EmailAddress` value can only ever be created via that function that parses a string, and that the `EmailAddress` value cannot be mutated.

Whenever you feel a strain in your options to handle an error condition, ask yourself if you're trying to deal with it at the wrong level; can you deal with it earlier? Chances are, you need to [Parse, Don't Validate](https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/).
