---
layout: post
title: "Re: The User Wizard Scenario"
published: true
---
So Eric Normand had started a conversation to compare notes on dynamic types and static types. You can find it at [https://lispcast.com/user-wizard-scenario/](https://lispcast.com/user-wizard-scenario/).

I liked the very concrete and real scenario he picked. I agree with the volatility observed but I also want to note early on that it isn't productive to respond to any particular solutions for each step: situation do arise, we developers handle it with the information and time we have at hand.

The final solution in his scenario -- at the cost of a bit of type safety -- was to use a `Map`. Since that's what a dynamically typed language (e.g. Clojure) would've chosen from the start, it begs the question: why not start there in the first place [instead of opting for static types and hoping that volatility doesn't hit]? Which leads to the statement:

> sufficiently volatile data prefers a flexible model with optional runtime checks.

### So how?

I'll disclaim upfront that I've in fact chosen to use a `Map` (aka `Dict`) most of the time, when dealing with forms, in my Elm apps. This choice is commonly judged as having given up on type safety.

That's true but **only if** we stop there!

Once we have a "bag of attributes" backing our form input values, add a function to parse it into the desired type or error messages if any <sup>[[1]](#footnote1)</sup>.

```elm
parse : Dict -> Result Errors UserInput
```

If valid, we return the value, e.g. `Ok { email = "bob@example.com" }`. Otherwise, return errors, e.g. `Err [ ( Email, "cannot is invalid" ) ]`. With the return value, you can enable the submit button when `userInput` is present, disable when absent, extract and display input field errors alongside the input fields. Not only are these validation rules consolidated into a single place, we can even use this same pure function on the frontend and the backend too.

Our form can change as much as needed by requirements, we'll just update `parse` accordingly.

### Managing boundaries

This isn't specific to managing HTML forms. The main idea here is to treat a form as a whole, and to consider it as external input, like a file. Drawing a line between that external world and the rest of our system.

Just because one edge of the system is volatile, doesn’t mean the rest of the system have to be as volatile. Just because we are looser with types on the periphery doesn't mean we have to bear the cost in the rest of our system. We can continue to benefit from the cosy assurance of statically type checked code within these walls we draw.

This explicit management of boundaries, like managed effects, is what I appreciate from a statically typed fp language.

### Some explorations

**Q: I want to save each step of partial attributes into the db**

I'd consider saving the key value data from those steps _as-is_ instead of having a `parse` for each step: it's pointless, the entire thing is incomplete anyways. But don't forget we can still use the same `parse` to obtain the list of errors _relevant to the current step_ and spruce up the UI accordingly.

Only at the final step, would `parse` be required to succeed fully.

**Q: What if some form inputs need the values from other form inputs?**

For example, an autocompletion list need to know which items have already been added (exclude from suggestions), and the text that is typed so far (filter the suggestions).

We can write a function that returns a `Suggestions` value based on those two earlier fields inside our `Dict`

```elm
suggestions : Dict -> Suggestions
```

Our autocomplete widget should then require a suggestions value in order to render

```elm
widget : Suggestions -> Html
```

**Q: You mentioned we could use our pure `parse` function in the frontend and the backend. What if some of my validation rules are not pure and needed a check against our database?**

Extend the `parse` function to account for the new `ExternalData` input, e.g. `parse : ExternalData -> Dict -> Result Errors UserInput` and run the `parse` function inside the procedure that queries for those external data. e.g. Client-side code can call upon an HTTP API and then supply the response data to the `parse` function along with the form data.

If it's not feasible in your scenario to supply such data to the Client-side, then we have to admit it can't be checked by the Client-side however you do it. Simply supply an empty value for `ExternalData` (that will allow you to consider the input as valid) and run it that way on the Client-side; we can still have validation for the other fields.

---

<sub><a name="footnote1">[1]</a> In [my still evolving form data library](https://elm-formdata.netlify.app), I've chosen to go with ( Maybe a, List ( Maybe k, err ) ) instead of a Result so that I have the option to return some non-critical validation error messages along with a valid UserInput. We'll see how that works out.</sub><br/>
