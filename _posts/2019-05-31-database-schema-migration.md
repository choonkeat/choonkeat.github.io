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

How about equivalent tools in [my choice language] environment? The implementations are usually ignorant (or ignores by design 🤷‍♂️) of the various real world use cases that have evolved the design of rails database schema migrations policy. e.g. naming files with an incrementing number starting from 001, requiring human with direct db access to salvage a failed migration

How about _not evolving_ my database schema and code like it’s 2004? LOL

After getting bitten by yet another issue (that wouldn’t have caused any grief if it had adopted the rails-way), I decided to see what it would take to implement Rails database schema migrations policy. In Go. Because tiny, fast, and portable binary.

**Store each version number that had been applied; not just the "current version"**

> Thought experiment: There were a couple of PRs to be merged X and Y. X was merged and deployed. When Y was merged, deployment succeeded but app began to crash; migrations in Y PR wasn't applied. Guess why? How taxing is it on the team to not have that happen again in such a setup?

The migration policy should be to run any migration script that wasn't recorded as run in _this_ database. The chaos scenarios of imagined "incompatible migrations" either doesn't happen or isn't better in alternative policies. Don't forget that

- Your [integration] tests would run with a blank database + all migrations, and would fail if migrations are incompatible from scratch
- Your staging server would have the same history of migrations as your production, and would fail to deploy on staging if migrations are incompatible with migration history on your production -- but production won't even see it since staging deployment failed (see also "Rollback on error" section below)

Systems resources aside, the only time when it would "pass on staging and fail on production" is when there were unexpected values in production (e.g. cannot alter column type). In such a failed production deployment, production should chug along fine with the previous version and thus be 1 bound behind staging database schema version. A variety of approaches can be taken moving forward, e.g. undo previous migration in staging, add unexpected values, replicate failure, edit offending migration script, and redeploy.

**UTC timestamp as version number**

Why even a choice?

**Rollback on error**

This allows for a straightforward "fix offending migration and re-deploy" playbook. Given an uncreative but clear constraint, developers can have creative solutions on how to best roll out their multi-step migration.

> Aside: Different databases have different rollback capability. The tool itself shouldn't make promises it can't keep on atomicity of migrations across different database systems. Understand yours and solution accordingly, e.g. break up into multiple files if necessary to ensure "save points" should something go wrong

**Up and down scripts written in your database syntax (SQL)**

This is not the place for leaky abstractions. Use your database features to make changes to your database.

---

If that's all fine and dandy to you too, then the good news is [dbmigrate](https://github.com/choonkeat/dbmigrate) exists and is runnable as a single binary or [ready to go Docker container](https://hub.docker.com/r/choonkeat/dbmigrate)
