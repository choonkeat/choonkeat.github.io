---
layout: post
title: Database Schema Migration
published: true
---
> It’s been more than a decade since Ruby on Rails included a [`db:migrate` feature](https://guides.rubyonrails.org/active_record_migrations.html).

Sadly when creating a non-Rails app, it’s still a thing to unnecessarily waste brain cycles on.

Do I want to include Rails to my non-Rails app just to manage my database schema evolution properly?

- The good: schema migration policy is solid
- The bad: need Rails or at least Ruby for dev and production envs

How about equivalent tools in [my choice language] environment? The implementations are usually ignorant (or ignores by design 🤷‍♂️) of the various real world use cases that have evolved the design of rails database schema migrations policy. e.g. naming files with an incrementing number starting from 001, requiring human with direct db access to salvage a failed migration.

Whenever I use a new stack, do I have to look for "db:migrate" for that stack again? Even though I didn't change my choice of database?

How about _not evolving_ my database schema and code like it’s 2004? LOL -- do you not version control your source code too?

<hr><br/>

After getting bitten by yet another issue (that wouldn’t have caused any grief if it had adopted the rails-way), I decided to see what it would take to implement Rails database schema migrations policy.

In Go. Because tiny, fast, and portable binary. I'd like to use it regardless of whether I'm writing Ruby, Rust, Javascript, or Elm.

So, what does it take?

**Store each version number that had been applied; not just the "current version"**

> Quiz time: There were a couple of PRs to be merged X and Y. X was merged and deployed. All good. When Y was merged, deployment succeeded but app began to crash on certain features; migrations in Y wasn't applied. Guess why?
>
> If you figured out why, part 2 is: how taxing is it going to be on the team to ensure that doesn't happen again? hint: check list, per PR, per deploy.

The migration policy should be to _apply any migration that wasn't applied before_. So we need to track every version number that had been applied. The chaos scenarios of imagined "incompatible migrations" either won't happen or isn't better managed in alternative policies. Remember that

- Your [tests](https://www.youtube.com/watch?v=a6oP24CSdUg) would run with a blank database + all migrations, and would've failed there if migrations are incompatible from scratch
- Your staging server would share the same history of migrations as your production, and would've failed to deploy on staging if migrations are incompatible with migration history on production -- but production is untouched since deployment to staging failed (see "Rollback on error" section below)

System resources aside, the only time when migrations would "pass on staging but fail on production" is when there were _unexpected values_ in production database (e.g. preventing an alter column). When this happens, your production deployment must fail and not proceed. When that happens, our production database will only be 1 bound behind our staging database schema migration history. A variety of approaches can be taken moving forward, e.g. undo previous migration in staging, add unexpected values, replicate failure, edit offending migration script, and redeploy.

> Aside: When a new deployment fails (due to schema migration or whatever reason), [your previous deployment must still chug along fine](https://martinfowler.com/bliki/BlueGreenDeployment.html). Otherwise, you actually have bigger problems.

**UTC timestamp as version number**

Why should this even be a choice?

**Rollback on error**

This allows for a straightforward "fix offending migration and re-deploy" playbook. Given an uncreative but clear constraint, developers can have creative solutions on how to best roll out their multi-step migration.

> Aside: Different databases have different rollback capability. The tool itself shouldn't make promises it can't keep on atomicity of migrations across different database systems. Understand yours and solution accordingly, e.g. break up into multiple files if necessary to ensure "save points" should something go wrong

**Up and down scripts written in your database syntax (SQL)**

This is not the place for leaky abstractions. Use your database features to make changes to your database.

<hr><br/>

If that's all fine and dandy to you too, then the good news is [dbmigrate](https://github.com/choonkeat/dbmigrate) exists and is runnable as a single binary or [ready to go Docker container](https://hub.docker.com/r/choonkeat/dbmigrate)
