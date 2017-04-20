# Placeholder
An iOS client of [typicode](https://twitter.com/typicode)'s [RESTful jsonplaceholder API](http://jsonplaceholder.typicode.com) written in Swfit 3. I made this to work out some ideas for (1) making a **simple** client for RESTful APIs (with no dependencies) and (2) using view controllers with generics. In a separate, as-yet unpublished project, I'm building a server-side Swift twitter-like webservice in [Vapor](https://vapor.codes) to reivise and expand these ideas to include (1) Reactive techniques (written myself, so as to understand it) (2) more complex REST services, (3) simplified, secure user authentication.

This code builds on many ideas from the Swift community, but especially on those I first heard discussed by Chris Eidhof and Florian Kugler in their show [Swift Talk](https://talk.objc.io).

## Features:
- A simple, decoupled webservice layer
  - Asynchronous response handling.
  - Caching.
  - Typesafe routing.
- Generic UITableViewControllers.
  - Small, simple, decoupled view controllers.
  - Dependency injection, using the ["Coordinator"](http://khanlou.com/2015/10/coordinators-redux/) pattern.
  
Apr 19, 2017: Placeholder does not yet support "todos", "posts", or "comments".
