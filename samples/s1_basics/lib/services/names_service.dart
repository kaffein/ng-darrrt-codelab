library s1_basics.services.names_service;


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

  Future _loadData() {
    if (names != null) return new Future.value(true);
    return _http.get('packages/s1_basics/assets/piratenames.json').then((HttpResponse response) {
      names = response.data['names'];
      appellations = response.data['appellations'];
    }).catchError((error) {
      print('Could not read data from json file $error');
    });
  }

  String _oneRandom(List<String> list) => list[rand.nextInt(list.length)];

  Future<String> randomName() {
    return _loadData().then((_) => _oneRandom(names));
  }

  Future<String> randomAppellation() {
    return _loadData().then((_) => _oneRandom(appellations));
  }

}
