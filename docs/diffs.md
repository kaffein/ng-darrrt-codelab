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

##[Home](../README.md#code-lab-angulardart)
