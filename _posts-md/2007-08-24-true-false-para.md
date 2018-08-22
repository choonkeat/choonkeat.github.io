---
layout: post
title: True False parameters
published: true
category:
- software
---
Every so often, I get the chance to use functions that accepts a nondescript boolean as parameter... or \*gasp\* a sequence of nondescript booleans.

> `api.connect( true )`

It's a chore for the maintainer (usually my future self) to have to look up what "true" meant. IDEs might be helpful at this point, bringing up code hints and what not.. unless of cos the function declaration itself isn't exactly perfect...

> `def connect(bool)  ... end`

I've finally come round to do myself a favor (ok, I AM going to be the maintainer) by using self-explanatory truthy / falsey values instead

> `api.connect(  :auto_retry )`` # true``api.connect( ``!:auto_retry`` )`` # false`

Reads better. No?

