## Step 3: Add a button and controller

In this step you add a button and a controller that coordinates the button, label, and badge.
The Dart code for the controller goes into libraries in a new `lib` directory.

_**Keywords**: controller, module, click event, custom library_

### Create a new file: lib/badge_controller.dart.

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

Key information:
- The [pub package layout conventions](https://www.dartlang.org/tools/pub/package-layout.html)
  specify the `lib` name and location.
- Putting the new badge controller code in its own library is optional,
  but it's a good way to keep your app modular.


### Edit badge_controller.dart.

&rarr; Add the following code to declare and import libraries.

<pre>
<b>library s1_controller.badge_controller;

import 'package:angular/angular.dart';</b>
</pre>

If you're using Dart Editor, it warns you that the import is unused.
_{PENDING: Say something about the library name.}_


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


### Edit main.dart.
    

&rarr; Modify the `main()` method to create a new module.

<pre>
void main() {
  <b>ngBootstrap(module: new Module()..type(BadgeController));</b>
}
</pre>
    
Key information:
- The Module instance provides all of Angular’s built in services  and directives.
- Your app’s module is added to the list of modules that Angular loads.

&rarr; In the `BadgeController` class, add an `inputIsNotEmpty` getter,
a `label` getter, and a `generateName()` method.

<pre>
class BadgeController {
  String name = '';
  BadgeController();
  
  <b>bool get inputIsNotEmpty => !name.trim().isEmpty;
  String get label => inputIsNotEmpty ? "Arrr! Write yer name!" : "Aye! Gimme a name!";
    
  generateName() {
    name = 'Anne Bonney';
  }</b>
}
</pre>

<!-- PENDING: add key info about getters -->

### Edit index.html. 

&rarr; Add `badge-controller` to the `<body>` element.

<pre>
&lt;body <b>badge-controller</b>>
</pre>

Key information:

* Thanks to the `badge-controller` selector, a BadgeController now
  controls every element under `<body>`.

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
  In our example, it invokes the generateName() method on the controller.
* As `{{ctrl.label}}` shows, an Angular expression can refer to a getter.

&rarr; Update data binding: replace `name` with `ctrl.name`.

<pre>
&lt;input type="text" id="inputName" maxlength="15" ng-model="<b>ctrl.name</b>">
</pre>

<pre>
&lt;span id="badgeName">{{<b>ctrl.name</b>}}</span>
</pre>
    
&rarr; Add a `ng-disabled` directive to the button tag.

<pre>
&lt;button ng-click="ctrl.generateName()" <b>ng-disabled="ctrl.inputIsNotEmpty"</b>>
  {{ctrl.label}}
&lt;/button>
</pre>

Key information:
* `ng-disabled` disables the element whenever the condition is true.
  In this case,
  the button is disabled whenever the input field contains text.

* Like `ng-click`, `ng-disabled` is a built-in AngularDart directive.

### Run the app in Dartium.

Click the button.
"Anne Bonney" appears in the text field and badge,
and the button becomes disabled.

Erase all text from the input field.
The button becomes enabled again.

### Problems?
Check your code against the files in [s3_controller](../samples/s3_controller).
- [index.html](../samples/s3_controller/web/index.html)
- [main.dart](../samples/s3_controller/web/main.dart)

## [Home](../README.md) | [< Previous](step-2.md) | [Next >](step-4.md)
