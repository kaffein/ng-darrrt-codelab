// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library service.pirate_module;

import 'package:service/src/service/names_service.dart';
import 'package:angular/angular.dart';
import 'package:service/src/badge/badge_component.dart';
import 'package:service/src/badges_controller.dart';

class PirateModule extends Module {
  PirateModule() {
    type(BadgesController);
    type(NamesService);
    type(BadgeComponent);
  }
}