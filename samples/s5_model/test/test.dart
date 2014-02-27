library s5_model.test;

import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'package:s5_model/badge_controller.dart';
import 'package:s5_model/pirate_module.dart';

class PirateName {
  String firstName, appellation;
  PirateName([this.firstName = '', this.appellation = '']);
}

main() {
  setUp(setUpInjector);
  tearDown(tearDownInjector);

  group('PirateName', () {
    PirateName pn;
    var name = "misko";
    var appellation = "magnificent";

    test('constructor with no-args', () {
      pn = new PirateName();
      expect(pn.firstName, isEmpty);
      expect(pn.appellation, isEmpty);
    });

    test('constructor with one-arg', () {
      pn = new PirateName(name);
      expect(pn.firstName, name);
      expect(pn.appellation, isEmpty);
    });

    test('constructor with two-args', () {
      pn = new PirateName(name, appellation);
      expect(pn.firstName, name);
      expect(pn.appellation, appellation);
    });
  });

  group('BadgeController', () {
    BadgeController ctrl;

    setUp(module((Module m) {
      m.install(new PirateModule());
      inject((BadgeController _ctrl) => ctrl = _ctrl);
    }));

    test('initial state', inject((BadgeController ctrl) {
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
