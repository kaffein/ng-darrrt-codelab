## Step 5: Use a class as a model

In this step, you define and use a model.

_**Keywords**: class, model_

### Create a model (PirateName)

&rarr; Create a file named `lib/model.dart`,
and add the following code to it:

```Dart
library s1_basics.model;

class PirateName {
  String firstName, appellation;
  PirateName([this.firstName = '', this.appellation = '']);
}
```

You've just implemented the model for this app.
{PENDING: say more? Maybe under "Key information"?
It's kind of interesting that it has two optional parameters that set the two fields.
Talk about where this model is used?}

{PENDING: talk about library name?}


### Update the controller

Now you'll edit `lib/badge_controller.dart`,
which is by far the most-changed file in this step.

&rarr; Add the following imports to `lib/badge_controller.dart`:

```Dart
import 'dart:math' show Random;
import 'package:s1_basics/model.dart';
```

The Editor will complain about unused imports. Don't worry about that, we'll
be using `Random` and the model later in this step.


&rarr; Add the following `const` lists inside `BadgeController`:

```Dart
class BadgeController {
  // ...
  static const List names = const [
    'Anne', 'Mary', 'Jack', 'Morgan', 'Roger',
    'Bill', 'Ragnar', 'Ed', 'John', 'Jane' ];

  static const List appellations = const [
    'Black','Damned', 'Jackal', 'Red', 'Stalwart', 'Axe',
    'Young', 'Old', 'Angry', 'Brave', 'Crazy', 'Noble'];
  // ...
}
```

&rarr; Add the following utility function that helps pick random names and
appellations:


```Dart
class BadgeController {
  // ...
  String _oneRandom(List<String> list) =>
      list[new Random().nextInt(list.length)];
}
```

&rarr; Inside `BadgeController`, create a new model instance:

```Dart
class BadgeController {
  // ...
  PirateName pn = new PirateName();
  // ...
}
```

&rarr; Now add a `pirateName` getter to the controller:


```Dart
class BadgeController {
  // ...
  String get pirateName => pn.firstName.isEmpty ? '' :
      '${pn.firstName} the ${pn.appellation}';
  // ...
}
```

This getter returns the complete name of the pirate. You will soon add code to
pass the string returned by this getter as an argument to the component that we
created in step 4.

`BadgeController` contains a `name` field:

```Dart
class BadgeController {
  // ...
  String name = '';
  // ...
}
```

&rarr; _Replace_ that line with the following code:


```Dart
class BadgeController {
  // ...
  String _name = '';

  get name => _name;

  set name(newName) {
    _name = newName;
    pn..firstName = newName
      ..appellation = _oneRandom(appellations);
  }
  // ...
}
```

Key information:
* We've added a private `_name` field that we'll later bind into the UI.
* We've defined a getter and a setter to get and set the value of `_name`.
* The setter also sets the `firstName` and `appellation` fields of the
`PirateBadge` object.
* Every time the value of `_name` changes, the change is reflected in `pn`,
  the public `PirateName` object.

So far, this method has produced a static name. Now
you'll add code to generate a name based on randomly picked values from the
`names` and `appellations` lists.

&rarr; _Replace_ the old version of `generateName()` with the following code:

```Dart
void generateName() {
  name = _oneRandom(names);
}
```

&rarr; Delete the `DEFAULT_NAME` constant.

```Dart
class BadgeController {
  //static const DEFAULT_NAME = 'Anne Bonney'; // DELETE THIS LINE
  ...
```

### Update data bindings

Now it's time to use the `pirateName` controller getter.

&rarr; In `web/index.html`, update the data binding in the `badge` tag to use
that getter:

```HTML
<badge name={{ctrl.pirateName}}
    style='float: left; margin-left: 20px;'></badge>
```

### Run the app in Dartium

You should be able to enter text into the input box and see
a pirate name in the pirate badge. You should also be able to generate a
random pirate name by clicking on the button.

### Problems?
Check your code against the files in [s5_model](../samples/s5_model).

Don't worry about differences in package names.
Your files should contain the string `s1_basics`
wherever the files in s5_model contain `s5_model`.

## [Home](../README.md#code-lab-angulardart) | [< Previous](step-4.md#step-4-create-a-custom-component) | [Next >](step-6.md#step-6-read-from-a-json-encoded-file)
