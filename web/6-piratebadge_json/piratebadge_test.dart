library piratebadgetb.test;

import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'piratebadge.dart';

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