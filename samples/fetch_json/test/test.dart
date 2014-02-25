// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library fetch_json.test;

import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';

import 'package:fetch_json/src/pirate_module.dart';
import 'package:fetch_json/src/badges_controller.dart';

main() {
  setUp(() {
   setUpInjector();
   module((Module m) => m.install(new PirateModule()));
  });
  tearDown(tearDownInjector);

  group('fetching data', () {
    Injector injector;
    MockHttpBackend backend;
    BadgesController badgesController;

    setUp((){
      inject((Injector _injector, MockHttpBackend _backend) {

        backend = _backend;
        injector = _injector;
        backend.expectGET('piratenames.json').respond('''{"names": [ "Anne"],
        "appellations": [ "Awesome"]}''');
      });
    });

    test('should fetch pirate names', async(() {

      expect(BadgesController.names, isEmpty);
      expect(BadgesController.appellations, isEmpty);

      badgesController = injector.get(BadgesController);
      expect(badgesController.dataLoaded, isFalse);
      expect(badgesController.pirateName, isEmpty);

      microLeap();
      backend.flush();
      microLeap();

      expect(BadgesController.names, ["Anne"]);
      expect(BadgesController.appellations, ["Awesome"]);
      expect(badgesController.dataLoaded, isTrue);
    }));

    test('should set the pirate name', async(() {
      badgesController = injector.get(BadgesController);
      badgesController.name ="Foo";
      expect(badgesController.pirateName, "Foo the Awesome");
    }));
  });
}