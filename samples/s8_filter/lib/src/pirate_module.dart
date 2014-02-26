// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library s8_filter.pirate_module;

import 'package:angular/angular.dart';

import 'package:use_filter/src/service/names_service.dart';
import 'package:use_filter/src/badge/badge_component.dart';
import 'package:use_filter/src/badge_controller.dart';
import 'package:use_filter/src/filter/capitalize_filter.dart';

class PirateModule extends Module {
  PirateModule() {
    type(BadgeController);
    type(NamesService);
    type(CapitalizeFilter);
    type(BadgeComponent);
  }
}
