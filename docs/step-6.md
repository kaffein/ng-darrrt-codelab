## Step 6: Read from a JSON-encoded file

In this step, you change the app so that it
gets the list of names and appellations from a JSON file.
You also disable the app's controls until the JSON data is loaded.

_**Keywords**: HTTP request, ng-disabled, NgBooleanAttributeDirective_

### Create a JSON file under lib/assets

&rarr; Create a directory named `assets`
under the `lib` directory.

&rarr; Under `lib/assets`,
create a JSON-encoded file named `piratenames.json`
with the following content:

```JSON
{ "names": [ "Anne", "Bette", "Cate", "Dawn",
        "Elise", "Faye", "Ginger", "Harriot",
        "Izzy", "Jane", "Kaye", "Liz",
        "Maria", "Nell", "Olive", "Pat",
        "Queenie", "Rae", "Sal", "Tam",
        "Uma", "Violet", "Wilma", "Xana",
        "Yvonne", "Zelda",
        "Abe", "Billy", "Caleb", "Davie",
        "Eb", "Frank", "Gabe", "House",
        "Icarus", "Jack", "Kurt", "Larry",
        "Mike", "Nolan", "Oliver", "Pat",
        "Quib", "Roy", "Sal", "Tom",
        "Ube", "Val", "Walt", "Xavier",
        "Yvan", "Zeb"],
  "appellations": [ "Awesome", "Black", "Captain", "Damned",
        "Even", "Fighter", "Great", "Hearty",
        "Irate", "Jackal", "King", "Lord",
        "Mighty", "Noble", "Old", "Powerful",
        "Quick", "Red", "Stalwart", "Tank",
        "Ultimate", "Vicious", "Wily", "aXe",
        "Young", "Zealot",
        "Angry", "Brave", "Crazy", "Damned",
        "Eager", "Fool", "Greedy", "Hated",
        "Idiot", "Jinxed", "Kind", "Lame",
        "Maimed", "Naked", "Old", "Pale",
        "Queasy", "Rat", "Sandy", "Tired",
        "Ugly", "Vile", "Weak", "Xeric",
        "Yellow", "Zesty"]}
```

### Edit the controller

The following steps involve editing `lib/badge_controller.dart`.

&rarr; Add the following import to `badge_controller.dart`:

```Dart
import 'dart:async' show Future;
```

Ignore the 'Unused import' warning from the Editor. You'll soon be using the
import.

&rarr; In the `BadgeController` class, replace the `names` and `appellations` lists with
these static, empty lists:

```Dart
class BadgeController {
  ...
  static List<String> names = [];
  static List<String> appellations = [];
  ...
}
```

In `BadgeController`, add a private final `Http _http` field:

```Dart
class BadgeController {
  ...
  final Http _http;
  ...
}
```

Key information:

* The `Http` service facilitates communication with remote HTTP servers.
* You don't need to do anything to `ngBootstrap()` to use the `Http` service
  because an instance of it is automatically injected by Angular.

&rarr; Add a private `_loadData()` method to `BadgeController`:

```Dart
class BadgeController {
  ...
  Future _loadData() {
    return _http.get('packages/s1_basics/assets/piratenames.json')
        .then((response) {
          names = response.data['names'];
          appellations = response.data['appellations'];
        });
  }
  ...
}
```

Key information:

* The `get()` method makes HTTP GET requests.
* The code uses a Future to perform the GET asynchronously. A Future is
a way to get a value in the future. For JavaScript developers: Futures are
similar to Promises.
* The callback function for `then()` executes when the Future completes
successfully, and the pirate names and appellations are read from the
response data.

&rarr; Add a `dataLoaded` field to `BadgeController` and set it to `false`:

```Dart
class BadgeController {
  ...
  bool dataLoaded = false;
  ...
}
```

&rarr; Add a `BadgeController` constructor that initializes the `_http` field
and requests the JSON data:

```Dart
class BadgeController {
  ...
  bool dataLoaded = false;

  BadgeController(this._http) {
    _loadData()
        .then((_) => dataLoaded = true)
        .catchError((error) {
          print('Could not read data from the JSON file: $error');
        });
  }
  ...
```

Key information:

* When `_loadData()` successfully reads the JSON content,
  `dataLoaded` becomes `true`.
* If the Future returned by `_loadData()` completes with an error,
  `catchError()` handles the error.  
* Chaining `then()` and `catchError()` when getting the value of Future
  is a common pattern in asynchronous Dart programming.
  You can think of it as the rough equivalent of a synchronous try-catch block.


### Edit the HTML file

&rarr; In `web/index.html`,
change the input and the button so that they are disabled until
the JSON data is loaded:

```HTML
<div class="widgets">
  <div>
    <input type="text" id="inputName" maxlength="15" ng-model="ctrl.name"
        ng-disabled="!ctrl.dataLoaded">
  </div>
  <div>
    <button ng-click="ctrl.generateName()"
        ng-disabled="!ctrl.dataLoaded || ctrl.inputIsNotEmpty">
        {{ctrl.label}}</button>
  </div>
</div>
```

Key information:
* If the expression in `ng-disabled` is true, then the `disabled` attribute
  is set on the element.
* When `ctrl.dataLoaded` is false, the input
  and button elements are disabled.
* The `ng-disabled` attribute is defined,
  along with other boolean attributes such as `ng-required`, in
  [NgBooleanAttributeDirective](https://docs.angulardart.org/#angular/angular-directive.NgBooleanAttributeDirective).
  {PENDING: It seems a little weird to discuss ng-disabled now,
  when we've already used it in a previous step. Move/split discussion?}

### Learn more about
 - [Introducing the Http service](https://github.com/angular/angular.dart.tutorial/wiki/Introducing-filters-and-services)

### Problems?
Check your code against the files in [s6_http](../samples/s6_http).
- [index.html](../samples/s6_http/web/index.html)
- [main.dart](../samples/s6_http/web/main.dart)

## [Home](../README.md#code-lab-angulardart) | [< Previous](step-5.md#step-5-use-a-class-as-a-model) | [Next >](step-7.md#step-7-use-a-service-to-get-data)
