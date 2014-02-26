library s4_component.test;

import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'package:s4_component/src/badge_controller.dart';
import 'package:s4_component/src/pirate_module.dart';
import 'package:s4_component/src/badge/badge_component.dart';

main() {
  setUp(setUpInjector);
  tearDown(tearDownInjector);

  group('pirate badge', () {
    TestBed tb;

    setUp(module((Module m) {
      m.install(new PirateModule());
      inject((TestBed testBed) => tb = testBed);
      inject((BadgeController _ctrl) => tb.rootScope.ctrl = _ctrl);
      inject((BadgeComponent _cmp) => tb.rootScope.cmp = _cmp);
    }));

    test('initial state', (){
      expect(tb.rootScope.ctrl.name, isEmpty);
      expect(tb.rootScope.cmp.name, isNull);
    });

    test('binding', () {
      // DOES NOT WORK
      tb.rootScope.ctrl.name = 'foo';
      expect(tb.rootScope.cmp.name, 'foo');
    });

    test('', () {
      // Testing the component DOM.
    });
  });
}
