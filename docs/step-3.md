## Step 3: Add a button and controller

In this step you add a button and a controller that coordinates the button, label, and badge.
You also start splitting your code into multiple libraries.
Implementing multiple libraries is optional,
but it's a good way to modularize your app.


_**Keywords**: controller, module, click event, defining a library_

### Create a lib directory and new Dart files

&rarr; Create a `lib` directory at the same level as the `web` directory.

You can do this at the command line, in a Finder,
or in Dart Editor.
In Dart Editor, right-click the top directory (`s1_basics`),
choose **New Folder...**,
and specify the name `lib`.

&rarr; Under `lib`, create a file named `badge_controller.dart`.

To do this in Dart Editor, right-click the `lib` directory,
choose **New File...**,
and specify the name `badge_controller.dart`.


&rarr; Under `lib`, create a file named `pirate_module.dart`.


Key information:
- The [pub package layout conventions](https://www.dartlang.org/tools/pub/package-layout.html)
  specify the `lib` name and location.
- The pub package manager looks under `lib` for
  any libraries that are imported with `package:this_package`
  (where <em>this_package</em> is the current package's name, as declared in the pubspec).
- Both `badge_controller.dart` and `pirate_module.dart` will declare libraries.


### Implement the controller

To implement the controller for this app,
edit `lib/badge_controller.dart`.

&rarr; Add the following code to declare and import libraries.

<pre>
<b>library s1_basics.badge_controller;

import 'package:angular/angular.dart';</b>
</pre>

If you're using Dart Editor, it warns you that the import is unused.


&rarr; Create an empty class named `BadgeController`, and give it a `name` property.

<pre>
...
<b>class BadgeController {
  String name = '';
}</b>
</pre>

&rarr; Add an `NgController` annotation to the class.

<pre><b>@NgController(
  selector: '[badge-controller]',
  publishAs: 'ctrl')</b>
class BadgeController {   
</pre>

Key information:
- The NgController annotation tells Angular that BadgeController is an Angular controller.
- The required `selector` argument defines the CSS selector that triggers the controller.
  It can be any valid CSS selector that does not cross element boundaries.
- The `publishAs` argument specifies that the controller instance should be assigned to
  the current scope under the specified name.

&rarr; Define some constant strings for the UI.

<pre>
Class BadgeController {
  <b>static const DEFAULT_NAME = 'Anne Bonney';
  static const LABEL1 = 'Arrr! Write yer name!';
  static const LABEL2 = 'Aye! Gimme a name!';</b>
  String name = '';
  ...
</pre>

Note that Dart Editor italicizes static values (and static methods, too).


&rarr; Add an `inputIsNotEmpty` getter, a `label` getter, and a `generateName()` method
to BadgeController.

<pre>
  String name = '';
  
<b>  bool get inputIsNotEmpty => name.trim().isNotEmpty;
  String get label => inputIsNotEmpty ? LABEL1 : LABEL2;

  generateName() {
    name = DEFAULT_NAME;
  }</b>
}
</pre>

<!-- PENDING: add key info about getters -->


### Register the controller

To register the BadgeController class,
you need to edit `lib/pirate_module.dart`.

&rarr; Add the following code to declare and import libraries.

<pre>
<b>library s1_basics.pirate_module;

import 'package:angular/angular.dart';
import 'package:s1_basics/badge_controller.dart'; </b>
</pre>

&rarr; Add a subclass of Angular's Module class, and register BadgeController.

<pre>
...
<b>class PirateModule extends Module {
  PirateModule() {
    type(BadgeController);
  }
}</b>
</pre>

Key information:
- The [Module](https://docs.angulardart.org/#angular/angular.Module) class
  provides all of Angular’s built-in services and directives.
- The code `type(BadgeController)` adds BadgeController
  to the list of modules that Angular loads.


### Instantiate and use the module

Now edit `main.dart`,
so that it uses a PirateModule object.

&rarr; Modify the `main()` method to instantiate PirateModule.

<pre>
<b>import 'package:s1_basics/pirate_module.dart';</b>

void main() {
  <b>ngBootstrap(module: new PirateModule());</b>
}
</pre>
    

### Hook up the controller to the HTML file

Now edit `web/index.html`,
so that it uses the controller.

&rarr; Add `badge-controller` to the `<body>` element.

<pre>
&lt;body <b>badge-controller</b>>
</pre>

Key information:

* Thanks to the `badge-controller` selector, a BadgeController now
  controls every element under `<body>`.

&rarr; Move `ng-cloak` up to the `<body>` element.
<!-- PENDING: why? really necessary? -->

<pre>
&lt;body badge-controller <b>ng-cloak</b>>
...
&lt;span id="badgeName">{{ctrl.name}}&lt;/span>
</pre>

&rarr; Add a `button` element under the input field.

<pre>
&lt;div class="widgets">
  &lt;div>
    &lt;input type="text" id="inputName" maxlength="15" ng-model="name">
  &lt;/div>
  <b>&lt;div>
    &lt;button ng-click="ctrl.generateName()">{{ctrl.label}}&lt;/button>
  &lt;/div></b>
&lt;/div>
</pre>

Key information:

* `ng-click` is a built-in Angular directive that
  allows you to specify custom behavior when an element is clicked.
  In our example, it invokes the `generateName()` method on the controller.
* As `{{ctrl.label}}` shows, an Angular expression can refer to a getter.


&rarr; Update data binding: replace `name` with `ctrl.name`.

<pre>
&lt;input type="text" id="inputName" maxlength="15" ng-model="<b>ctrl.name</b>">
...
&lt;span id="badgeName">{{<b>ctrl.name</b>}}</span>
</pre>
    
&rarr; Add a `ng-disabled` directive to the button tag.

<pre>
&lt;button ng-click="ctrl.generateName()"
    <b>ng-disabled="ctrl.inputIsNotEmpty"</b>>{{ctrl.label}}&lt;/button>
</pre>

Key information:
* `ng-disabled` disables the element whenever the condition is true.
  In this case,
  the button is disabled whenever the input field contains text.

* Like `ng-click`, `ng-disabled` is a built-in AngularDart directive.

### Run the app in Dartium

&rarr; Once the app is running, click the button.

"Anne Bonney" appears in the text field and badge,
and the button becomes disabled.

&rarr; Erase all text from the input field.

The button becomes enabled again.

### Problems?
Check your code against the files in [s3_controller](../samples/s3_controller).

Don't worry about differences in package names.
Your files should contain the string `s1_basics`
wherever the files in s3_controller contain `s3_controller`.


## [Home](../README.md#code-lab-angulardart) | [< Previous](step-2.md#step-2-add-an-input-field) | [Next >](step-4.md#step-4-create-a-custom-component)
