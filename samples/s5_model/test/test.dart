library s5_model.test;

import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'package:s5_model/src/badge_controller.dart';
import 'package:s5_model/src/pirate_module.dart';

main() {
  setUp(setUpInjector);
  tearDown(tearDownInjector);

  group('pirate badge', () {
    setUp(module((Module m) {
      m.install(new PirateModule());
    }));

    test('should load recipes', inject((BadgeController ctrl) {
      expect(BadgeController.names.length, greaterThan(0));
      expect(ctrl.inputIsNotEmpty, isFalse);
      expect(ctrl.label, 'Aye! Gimme a name!');
    }));

    test('should generate name', inject((BadgeController ctrl) {
      expect(ctrl.name, isEmpty);
      ctrl.generateName();
      expect(BadgeController.names.contains(ctrl.name), isTrue);
    }));
  });
}
