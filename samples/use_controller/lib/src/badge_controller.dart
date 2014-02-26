// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library use_controller.badge_controller;

import 'package:angular/angular.dart';

@NgController(
    selector: '[badges]',
    publishAs: 'ctrl')
class BadgeController {
  static const DEFAULT_NAME = 'Anne Bonney';
  String name = '';

  BadgeController();

  bool get inputIsNotEmpty => name.trim().isNotEmpty;
  String get label => inputIsNotEmpty ? "Arrr! Write yer name!" : "Aye! Gimme a name!";

  generateName() {
    name = DEFAULT_NAME;
  }
}
