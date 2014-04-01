## Step 7: Use a service to get data

This step converts Step 6's example to use a service
(NamesService) to load and provide names.

Step 4 hard coded data in the controller.
Step 6 modified the controller to read the data from a JSON file.
This step moves all aspects of fetching a pirate name out of the controller and into a service,
creating a clean separation of logic in the app:

* The model defines the shape of the data.
* The service provides the actual data.
* The controller is the glue that keeps everything together.

_**Keywords**: service_


### Create a service

&rarr; Create a `service` directory under `lib`.

&rarr; In the `lib/service` directory, create a new file,
`names_service.dart`, and copy the following content to it:

```Dart
library s1_basics.service.names_service;

import 'package:angular/angular.dart';
import 'dart:async';
import 'dart:math';

@NgInjectableService()
class NamesService {
  static Random rand = new Random();
  final Http _http;
  List<String> names;
  List<String> appellations;

  NamesService(this._http);


  Future _loadData() {
    if (names != null) return new Future.value(true);
    return _http.get('packages/s1_basics/assets/piratenames.json')
      .then((HttpResponse response) {
        names = response.data['names'];
        appellations = response.data['appellations'];
      })
      .catchError((error) {
        print('Could not read data from the JSON file: $error');
      });
  }

  Future<String> randomName() {
    return _loadData().then((_) => _oneRandom(names));
  }

  Future<String> randomAppellation() {
    return _loadData().then((_) => _oneRandom(appellations));
  }

  String _oneRandom(List<String> list) => list[rand.nextInt(list.length)];
}
```

Key information:
* This file creates a `NamesService` class.
* The `@NgInjectableService` annotation on NamesService
  indicates that the NamesService class will be instantiated by Angular's dependency injector.
* Much of the logic that was in the controller is now in the NamesService class, specifically:
  * The `names` and `appellations` lists
  * The `_oneRandom()` method
  * The `_loadData()` method
* The NamesService class defines `randomName()` and `randomAppellation()` helper methods
  to fetch random data selections.
* The NamesService version of the `_loadData()` method is a bit optimized:
  it now checks whether the `names` list has already been populated and
  fetches data only if it hasn't.
  As a result, you can call `randomName()` and `randomAppellation()` without
  reloading the JSON data.
* The HTTP GET loads data from the current package (`s1_basics`).
  If you use a different package name, you need to change the argument
  to `get()`.



### Clean up the controller

In this step, you edit `lib/badge_controller.dart`.

&rarr; Import the service:

```Dart
// ...
import 'package:s1_basic/service/names_service.dart';
// ...
```

Ignore the 'Unused import' warning from Dart Editor.
You'll soon be using the import.

&rarr; Strip out the code that's duplicated in NamesService,
and use a NamesService object instead.

Your controller should now look like this:
{PENDING: split up, explain better}

```Dart
@NgController(
    selector: '[badge-controller]',
    publishAs: 'ctrl')
class BadgeController {
  NamesService ns;

  PirateName pn = new PirateName();

  String get pirateName => pn.firstName.isEmpty ? '' :
    '${pn.firstName} the ${pn.appellation}';

  BadgeController(this.ns);

  String _name = '';

  get name => _name;

  set name(newName) {
    _name = newName;
    ns.randomAppellation().then((appellation) {
      pn..firstName = newName
        ..appellation = appellation;
    });
  }

  bool get inputIsNotEmpty => name.trim().isNotEmpty;
  String get label => inputIsNotEmpty ? "Arrr! Write yer name!" :
    "Aye! Gimme a name!";

  Future generateName() => ns.randomName().then((aName) {
    name = aName;
  });
}
```

Key information:

* A `NamesService` instance is now a field of the controller.
* The `name` setter now uses the service to construct the pirate name.
* The `generateName()` method also uses the service:
* The `generateName()` method updates the value of `_name`,
  triggering the `name` setter,
  which updates `pn.firstName` and `pn.appellation`.
* The controller now has no knowledge of how the data is generated,
  but can request it from the service when needed.

&rarr; Remove this unused import:

```Dart
import 'dart:math' show Random;
```

### Register the service

&rarr; In `lib/pirate_module.dart`,
import `names_service.dart` and add the `NamesService` type:

```Dart
...
import 'package:s1_basic/service/names_service.dart';
...
    type(NamesService);
...
```

Key information:

* Adding the NamesService type
  allows the AngularDart dependency injector
  to instantiate NamesService objects.
* The dependency injector instantiates a NamesService object
  whenever Angular creates a BadgeController,
  thanks to the BadgeController constructor having an argument
  of type NamesService.

### Update the UI

Notice that the `dataLoaded` field has been removed from the controller.
You no longer fetch data when the page loads,
but instead wait for user action before doing so.
As a result, you need to enable the UI before data has loaded.

&rarr; Update `web/index.html` so that the markup for your input and
button look like this:

```HTML
<div class="widgets">
  <div>
    <input type="text" id="inputName" maxlength="15" ng-model="ctrl.name">
  </div>
  <div>
    <button ng-click="ctrl.generateName()"
        ng-disabled="ctrl.inputIsNotEmpty">
        {{ctrl.label}}</button>
  </div>
</div>
```

### Run the app in Dartium

The app should look like it did before,
but you might notice that the controls are enabled by default.

### Problems?
Check your code against the files in [s7_service](../samples/s7_service).

Don't worry about differences in package names.
Your files should contain the string `s1_basics`
wherever the files in s7_service contain `s7_service`.


## [Home](../README.md#code-lab-angulardart) | [< Previous](step-6.md#step-6-read-from-a-json-encoded-file) | [Next >](step-8.md#step-8-use-a-filter-to-modify-data)


