library s7_service.service.names_service;

import 'package:angular/angular.dart';
import 'dart:async';
import 'dart:math';

@NgInjectableService()
class NamesService {
  static Random rand = new Random();
  final Http _http;
  List<String> names;
  List<String> appellations;

  NamesService(this._http);


  Future loadData() {
    if (names != null) return new Future.value(true);
    return _http.get('packages/s7_service/assets/piratenames.json')
      .then((HttpResponse response) {
        names = response.data['names'];
        appellations = response.data['appellations'];
      })
      .catchError((error) {
        print('Could not read data from the JSON file: $error');
      });
  }

  Future<String> randomName() {
    return loadData().then((_) => _oneRandom(names));
  }

  Future<String> randomAppellation() {
    return loadData().then((_) => _oneRandom(appellations));
  }

  String _oneRandom(List<String> list) =>
      list[rand.nextInt(list.length)];
}
