## Step 8: Use a filter to modify data

In this step, you implement a custom filter to modify data.

Filters let you change how your model data is displayed in the view without
changing the model data itself. For example, they're useful for showing
parts of a model's data, or displaying data in a particular format.
Angular has built-in filters such as CurrencyFilter and DateFilter.
You can also easily create and use your own filters,
as this step shows.

_**Keywords**: filter_

### Create a filter

&rarr; Create a `filters` directory under `lib`.

&rarr; In the `lib/filters` directory, create a new file,
`capitalize_filter.dart`, and copy the following content to it:

```Dart
library s1_basics.filters.capitalize_filter;

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

* The @NgFilter annotation on CapitalizeFilter tells
  Angular to publish the class as a filter.
* Each custom filter in AngularDart requires a class that has
  a `call()` method with at least one argument:
  `call(valueToFilter, optArg1, ..., optArgN)`
* The `call()` method's first argument is the value to filter.
* The `call()` method should return the filtered value.

### Register the filter

&rarr; In `lib/pirate_module.dart`, import the filter:

```Dart
import 'package:s1_basics/filters/capitalize_filter.dart';
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

<!-- PENDING: check that optional quotation mark feature is intentional and will remain true -->


### Run the app in Dartium

&rarr; Type in a name, using all lowercase letters.

In the badge, the pirate name is capitalized!

### Learn more
 - [Introducing Filters and Services](https://angulardart.org/tutorial/07-ch05-filter-service.html)
 - [angular.filter API reference](https://docs.angulardart.org/#angular/angular-filter)
 

### Problems?
Check your code against the files in [s8_filter](../samples/s8_filter).

Don't worry about differences in package names.
Your files should contain the string `s1_basics`
wherever the files in s8_filter contain `s8_filter`.


## [Home](../README.md#code-lab-angulardart) | [< Previous](step-7.md#step-7-use-a-service-to-get-data) | [Next >](step-9.md#step-9-run-the-app-as-javascript)
