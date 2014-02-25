// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library controller.pirate_module;

import 'package:angular/angular.dart';
import 'package:controller/src/badges_controller.dart';

class PirateModule extends Module {
  PirateModule() {
    type(BadgesController);
  }
}
