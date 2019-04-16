import 'dart:async';

import 'package:sweeter_mobile/models/sweet.dart';
import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/api.dart' as api;

class MainBloc {

  final StreamController<User> _meController = StreamController<User>();
  final StreamController<List<Sweet>> _mySweetsController = StreamController<List<Sweet>>();
  
  Stream<User> get meStream => _meController.stream;
  Stream<List<Sweet>> get mySweetsStream => _mySweetsController.stream;

  void setUser(User user) {
    _meController.sink.add(user);
  }

  void refreshUser() async {
    var user = User.fromJson(await api.get("/users/me"));
    _meController.sink.add(user);
  }

  void refreshSweets() async {
    Iterable items = await api.get("/users/me/sweets");
    var sweets = items.map((item) => Sweet.fromJson(item)).toList();
    _mySweetsController.sink.add(sweets);
  }

}