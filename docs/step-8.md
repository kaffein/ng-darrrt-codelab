## Step 8: Use a filter to modify data

In this step, you implement a filter to modify data.

_**Keywords**: filter_

Filters let you change how your model data is displayed in the view without
changing the model data itself. They do things like allow you to show parts of
the model data, or display data in a particular format. You can also use
Angular’s custom filters feature to create your own filters to do anything you
want.

### Create a filter

&rarr; Create a `filter` directory under `lib`.

&rarr; In the `lib/filter` directory, create a new file,
`capitalize_filter.dart`, and copy the following content to it:

```Dart
library s1_basics.filter.capitalize_filter;

import 'package:angular/angular.dart';

@NgFilter(name: 'capitalize')
class CapitalizeFilter {
  call(String name) {
    if (name == null || name.isEmpty) return '';
    return name[0].toUpperCase() + name.substring(1);
  }
}
```

Key information:

* The @NgFilter annotation {PENDING: explain}
* To create a custom filter in Angular, just create a Dart class that has
  a `call()` method with the following signature:

  ```Dart
  call(valueToFilter, optArg1, optArg2);
  ```

### Register the filter

&rarr; In `lib/pirate_module.dart`, import the filter:

```Dart
import 'package:s1_basics/filter/capitalize_filter.dart';
```

&rarr; Add the filter to the module definition:

```Dart
...
type(CapitalizeFilter);
...
```

### Use the filter

&rarr; Now use the filter in `web/index.html`:

```HTML
...
<badge name="{{ctrl.pirateName | capitalize}}"
...
```

Key information:

* This code sets the badge name to filtered (capitalized) value of
  the controller's `pirateName` variable.
* Be sure to use `"{{...}}"`, not just `{{...}}`.
  Quotation marks aren't necessary when you're just referring to a variable,
  but they _are_ necessary if you perform any operations.
  {PENDING: check!}


### Run the app in Dartium

&rarr; Type in a name, using all lowercase letters.

In the badge, the pirate name is capitalized!

### Learn more
 - [Introducing Filters](https://angulardart.org/tutorial/07-ch05-filter-service.html)

### Problems?
Check your code against the files in [s8_filter](../samples/s8_filter).

Don't worry about differences in package names.
Your files should contain the string `s1_basics`
wherever the files in s8_filter contain `s8_filter`.


## [Home](../README.md#code-lab-angulardart) | [< Previous](step-7.md#step-7-use-a-service-to-get-data)
