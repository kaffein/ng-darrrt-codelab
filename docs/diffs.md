## Differences Between AngularDart Versions

### 0.9.10 tutorial vs. bleeding edge

A new [transformer](https://www.dartlang.org/tools/pub/assets-and-transformers.html)
enables smaller generated JavaScript for AngularDart apps.

What you need to change:

* You need to import the `angular_dynamic` package
  and use `ngDynamicApp()` instead of `ngBootstrap()`.
  (The function name is likely to change.)

  See [hello_world.dart](https://github.com/angular/angular.dart/blob/master/example/web/hello_world.dart) for the latest code.

* When generating a JavaScript version of your AngularDart app,
  you need to use `pub serve` or `pub build`,
  which runs the transformer.


