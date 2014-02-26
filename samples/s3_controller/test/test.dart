library s3_controller.test;

import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'package:s3_controller/src/pirate_module.dart' show PirateModule;
import 'package:s3_controller/src/badge_controller.dart' show BadgeController;

main() {
  setUp(setUpInjector);
  tearDown(tearDownInjector);

  group('pirate badge', () {
    BadgeController ctrl;

    setUp(module((Module m) {
      m.install(new PirateModule());
      inject((BadgeController _ctrl) => ctrl = _ctrl);
    }));

    test('should load recipes', () {
      expect(ctrl.inputIsNotEmpty, isFalse);
      expect(ctrl.label, 'Aye! Gimme a name!');
    });

    test('should generate name', () {
      expect(ctrl.name, isEmpty);
      ctrl.generateName();
      expect(ctrl.name, BadgeController.DEFAULT_NAME);
    });
  });
}
