// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library s8_filter.service.names_service;

import 'package:angular/angular.dart';
import 'dart:async';
import 'dart:math';

@NgInjectableService()
class NamesService {
  static final Random indexGen = new Random();
  final Http _http;
  List<String> names;
  List<String> appellations;

  NamesService(this._http);

  Future _load() {
    if (names != null) return new Future.value(true);
    return _http.get('packages/s8_filter/assets/piratenames.json').then((HttpResponse response) {
      names = response.data['names'];
      appellations = response.data['appellations'];
    });
  }

  Future<String> randomName() {
    return _load().then((_) => _oneRandom(names));
  }

  Future<String> randomAppellation() {
    return _load().then((_) => _oneRandom(appellations));
  }

  String _oneRandom(List<String> list) => list[indexGen.nextInt(list.length)];
}
