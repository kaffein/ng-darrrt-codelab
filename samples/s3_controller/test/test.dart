library s3_controller.test;

import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'package:use_controller/src/pirate_module.dart' show PirateModule;
import 'package:use_controller/src/badge_controller.dart' show BadgeController;

main() {
  setUp(setUpInjector);
  tearDown(tearDownInjector);

  group('pirate badge', () {
    var name = 'misko';

    setUp(module((Module m) {
      m.install(new PirateModule());
    }));

    test('should load recipes', inject((BadgeController ctrl) {
      expect(ctrl.inputIsNotEmpty, isFalse);
      expect(ctrl.label, 'Aye! Gimme a name!');
    }));

    test('should generate name', inject((BadgeController ctrl) {
      expect(ctrl.name, isEmpty);
      ctrl.generateName();
      expect(ctrl.name, BadgeController.DEFAULT_NAME);
    }));
  });
}
