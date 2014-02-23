library piratebadgetb.est;

import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'piratebadge.dart' show PirateModule, BadgesController;
import 'dart:html' show querySelector;

main() {
  setUp(setUpInjector);
  tearDown(tearDownInjector);

  group('pirate badge', () {
    TestBed tb;
    var name = 'misko';

    // Get this from lib.
    var badgeName = 'Anne Bonney';

    setUp(module((Module m) {
      m.install(new PirateModule());
      inject((TestBed testBed) => tb = testBed);
      inject((BadgesController _ctrl) => tb.rootScope.ctrl = _ctrl);
    }));

    test('should load recipes', inject((BadgesController ctrl) {
      expect(ctrl.inputIsNotEmpty, isFalse);
      expect(ctrl.label, 'Aye! Gimme a name!');
    }));

    test('should generate name', inject((BadgesController ctrl) {
      expect(ctrl.name, isEmpty);
      ctrl.generateName();
      expect(ctrl.name, 'Anne Bonney');
    }));

    test('should bind model to input', () {
      tb.compile('''<div><span id="badgeName">{{ctrl.name}}</span></div>''');
      var span = tb.rootElement.querySelector('#badgeName');
      expect(span.innerHtml, isEmpty);
      tb.rootScope.ctrl.name = name;
      tb.rootScope.$digest();
      expect(span.innerHtml, name);
    });

    test('should update badge from input value', () {
      tb.compile('''<div><input type="text" id="inputName" maxlength="15"
          ng-model="ctrl.name" probe="p">
          <span id="badgeName">{{ctrl.name}}</span>
      </div>''');
      Probe probe = tb.rootScope.p;
      var ngModel = probe.directive(NgModel);

      var input = probe.element;
      var span = tb.rootElement.querySelector('#badgeName');
      expect(input.value, isEmpty);
      expect(span.innerHtml, isEmpty);

      input.value = name;
      tb.triggerEvent(input, 'change');

      expect(tb.rootScope.ctrl.name, name);
      expect(span.innerHtml, name);
    });

    test('should generate static name when button is pressed', () {
      tb.compile('''<div><button ng-click="ctrl.generateName()"
          ng-disabled="ctrl.inputIsNotEmpty" probe="p">{{ctrl.label}}</button>
          <span id="badgeName">{{ctrl.name}}</span>
        </div>''');
      Probe probe = tb.rootScope.p;
      var ngModel = probe.directive(NgModel);
      var button = tb.rootElement.querySelector('button');
      var span = tb.rootElement.querySelector('#badgeName');
      button.click();
      tb.rootScope.$digest();
      expect(span.innerHtml, 'Anne Bonney');
    });
  });
}
