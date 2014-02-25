library piratebadgetb.test;

import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'piratebadge.dart' show PirateModule, BadgesController;
import 'badge/badge_component.dart';

main() {
  setUp(setUpInjector);
  tearDown(tearDownInjector);

  group('pirate badge', () {
    TestBed tb;

    setUp(module((Module m) {
      m.install(new PirateModule());
      inject((TestBed testBed) => tb = testBed);
      inject((BadgesController _ctrl) => tb.rootScope.ctrl = _ctrl);
      inject((BadgeComponent _cmp) => tb.rootScope.cmp = _cmp);

    }));
  });
}
