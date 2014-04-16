## Differences Between AngularDart Versions

### Changes between 0.9.8 and the release to be named 0.10.0

**Note:**
This list is incomplete.
Feel free to submit pull requests with more information
about what needs to change for releases after 0.9.8.

In 0.10.0, a new
[transformer](https://www.dartlang.org/tools/pub/assets-and-transformers.html)
enables smaller generated JavaScript for AngularDart apps.
Also, some API names have changed.

What you need to change:

* Import the `application_factory.dart` library (in addition to `angular.dart`),
  so that you can use `applicationFactory()`. Then:
  * Use `applicationFactory()` instead of `ngBootstrap()` or `dynamicApplication()`.
  * Once the app is set up, start it by invoking `run()`.
  * See [hello_world.dart](https://github.com/angular/angular.dart/blob/master/example/web/hello_world.dart)
    for the latest code.
* Whenever you generate a JavaScript version of your AngularDart app,
  use `pub serve` or `pub build`,
  so that the transformer runs.
* Add the `angular` transformer to your pubspec.yaml file.
```     
transformers:
  -  angular
```
* API names have changed. See
  [this commit](https://github.com/angular/angular.dart/commit/d93b12f10d739ffa74da755ed647ec624e3e225b)
  for details.
  A few highlights:
  * Most `Ng` prefixes are gone. <br>
    Example: `NgController` &rarr; `Controller`
  * The name _filter_ has changed to _formatter_. <br>
    Example: `NgFilter` &rarr; `Formatter`
  * Some classes have been deprecated
    but don't have replacements yet. <br>
    Example: Using `Controller` or `NgOneWay` causes Dart Editor to emit a deprecation hint.

##[Home](../README.md#code-lab-angulardart)
