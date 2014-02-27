library s4_component.test;

import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'package:s4_component/badge_controller.dart';
import 'package:s4_component/pirate_module.dart';
import 'package:s4_component/components/badge_component.dart';

import 'dart:html' show HttpRequest, querySelector;

main() {
  setUp(setUpInjector);
  tearDown(tearDownInjector);

  group('pirate badge', () {
    TestBed tb;
    var name = "misko";

    setUp(module((Module m) {
      m.install(new PirateModule());
      inject((TestBed testBed) => tb = testBed);
      inject((BadgeController _ctrl) => tb.rootScope.ctrl = _ctrl);
      inject((BadgeComponent _cmp) => tb.rootScope.cmp = _cmp);
    }));

    solo_test('initial state', (){
      expect(tb.rootScope.ctrl.name, isEmpty);
      expect(tb.rootScope.cmp.name, isNull);
    });

    test('DOM structure', () {
      var path = 'packages/s4_component/components/badge_component.html';
      HttpRequest.getString(path).then((_template) {
        new MockHttpBackend().expect('GET').respond(_template);
        tb.compile(_template.trim());

        var el = tb.rootElement.querySelector('span');
        expect(el.innerHtml, isEmpty);

        tb.rootScope.cmp.name = name;
        tb.rootScope.$digest();
        expect(el.innerHtml, name);
      });
    });
  });
}
