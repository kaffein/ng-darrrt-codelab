## Differences Between AngularDart Versions

### Changes between 0.9.8 and post-0.9.10 bleeding edge

**Note:**
This list is incomplete.
Feel free to submit pull requests with more information
about what needs to change for releases after 0.9.8.

After 0.9.10, a new
[transformer](https://www.dartlang.org/tools/pub/assets-and-transformers.html)
enables smaller generated JavaScript for AngularDart apps.

What you need to change:

* Import the `angular_dynamic.dart` library (in addition to `angular.dart`),
  so that you can use `ngDynamicApp()`. Then:
  * Use `ngDynamicApp()` instead of `ngBootstrap()`.
    (The function name is likely to change.)
  * Once the app is set up, start it by invoking `run()`.
  * See [hello_world.dart](https://github.com/angular/angular.dart/blob/master/example/web/hello_world.dart)
    for the latest code.
* If you generate a JavaScript version of your AngularDart app,
  use `pub serve` or `pub build`,
  so that the transformer runs.

##[Home](../README.md#code-lab-angulardart)
