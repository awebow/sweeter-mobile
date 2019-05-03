import 'dart:async';

import 'package:sweeter_mobile/models/sweet.dart';
import 'package:sweeter_mobile/api.dart' as api;

class MainBloc {

  final StreamController<List<Sweet>> _mySweetsController = StreamController<List<Sweet>>.broadcast();
  
  Stream<List<Sweet>> get mySweetsStream => _mySweetsController.stream;

  Future<void> refreshSweets() async {
    Iterable items = await api.get("/users/me/newsfeeds");
    var sweets = items.map((item) => Sweet.fromJson(item)).toList();
    _mySweetsController.sink.add(sweets);
    return Future.value();
  }

  dispose() {
    _mySweetsController.close();
  }

}