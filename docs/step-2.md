## Step 2: Add an input field

In this step, you add an input field
that updates the text of the badge.

_**Keywords**: binding, scope, model_

-----------------------------
> **Note**: Throughout this code lab, continue to edit the files in `s1_basics`.
You can use the files in the other `samples` subdirectories to compare to your code
or to recover if you get off track.

-----------------------------

### Edit main.dart.

&rarr; Add the following imports just above main()).

<pre>
<b>import 'package:angular/angular.dart';

@MirrorsUsed(override: '*')
import 'dart:mirrors';</b>

void main() {
...
</pre>

Key information:

* An import pulls in a Dart library.
* Importing `dart:mirrors` and annotating it with `@MirrorsUsed` is a temporary
  measure that can help the dart2js compiler to generate smaller code.

---

&rarr; Add `ngBootstrap();` to the `main`() method:

<pre>
void main() {
<b>  ngBootstrap();</b>
}
</pre>

Key information:
* Once an application is bootstrapped, it’s ready to respond to incoming browser events
  (such as mouse clicks, key presses, or incoming HTTP responses)
  that might change the data that the app displays.


### Edit piratebadge.html.

&rarr; Add an `ng-app` attribute to the `<html>` element:

<pre>
&lt;html <b>ng-app</b>>
</pre>

Key information:

* The `ng-app` attribute is a _Angular directive_
  that identifies the root element of the application.
  Anything inside of the root element is part of the page template managed by Angular.
  Unless you have a reason for Angular to manage only part of the app,
  we recommend putting the `ng-app` directive on the `<html>` element because it is the outermost tag.

---

&rarr; Add a `<div>` containing an `<input>` element to the "widgets" `<div>`.

<pre>
...
&lt;div class="widgets">
<b>  &lt;div>
    &lt;input type="text" id="inputName" maxlength="15" ng-model="name">
  &lt;/div></b>
&lt;/div>
...
</pre>

Key information:
* The `ng-model` directive binds the input's value attribute to the property `name`.
* Angular creates the `name` property if it doesn't already exist (which it doesn't, in this case).

---

&rarr; Insert `{{name}}` in the "badgeName" span, and add an `ng-cloak` directive to hide it.

<pre>
&lt;span id="badgeName" <b>ng-cloak</b>><b>{{name}}</b>&lt;/span>
</pre>

Key information:
* Angular uses double curly braces  `{{...}}`, also known as double-mustache syntax,
  to contain Angular expressions. 
  Angular evaluates the expression and puts the result in the DOM.
* Angular swaps out `{{name}}` and substitutes the value of the `name` property.
* If you don't use `ng-cloak` and related CSS,
  Angular expressions such as `{{name}}` will be visible in your app until Angular swaps them out.

### Run the app.

&rarr; Like before, right-click `web/index.html`, and choose **Run in Dartium**.

&rarr; Type into the text field that appears.

Notice how the view (the badge) updates in real time whenever
the model (the contents of the text field) changes.
This is called _two-way data binding_.
Angular listens for changes to the model and updates the view to reflect those changes.

### Learn more about
 - [How Angular does MVC](https://github.com/angular/angular.dart.tutorial/wiki/Creating-your-first-Angular-app#how-angular-does-mvc)

### Problems?
Check your code against the files in [s2_binding](../s2_binding).
- [index.html](../samples/s2_binding/web/index.html)
- [main.dart](../samples/s2_binding/web/main.dart)

## [Home](../README.md#code-lab-angulardart) | [< Previous](step-1.md#step-1-run-the-app-and-view-its-code) | [Next >](step-3.md#step-3-add-a-button-and-controller)
