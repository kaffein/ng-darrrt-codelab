// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library fetch_json.badge_controller;

import 'dart:async' show Future;
import 'dart:math' show Random;
import 'package:angular/angular.dart';

@MirrorsUsed(override:'*')
import 'dart:mirrors';

class PirateName {
  String firstName, appellation;
  PirateName([this.firstName = '', this.appellation = '']);
}

@NgController(
    selector: '[badges]',
    publishAs: 'ctrl')
class BadgeController {
  static List<String> names = [];
  static List<String> appellations = [];

  final Http _http;
  bool dataLoaded = false;

  PirateName pn = new PirateName();

  String get pirateName => pn.firstName.isEmpty ? '' :
    '${pn.firstName} the ${pn.appellation}';

  BadgeController(this._http) {
    _loadData()
        .then((_) => dataLoaded = true)
        .catchError((error) {
          print('Could not read data from the JSON file: $error');
        });
  }

  Future _loadData() {
    return _http.get('../lib/assets/piratenames.json').then((HttpResponse response) {
      names = response.data['names'];
      appellations = response.data['appellations'];
    });
  }

  String _name = '';

  get name => _name;

  set name(newName) {
    _name = newName;
    pn..firstName = name
      ..appellation = appellations[new Random().nextInt(appellations.length)];
  }

  bool get inputIsNotEmpty => name.trim().isNotEmpty;

  String get label => inputIsNotEmpty ? "Arrr! Write yer name!" :
    "Aye! Gimme a name!";

  generateName() {
    var randomName = _oneRandom(names);
    name = randomName;
  }

  String _oneRandom(List<String> list) => list[new Random().nextInt(list.length)];
}
