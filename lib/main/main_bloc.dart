import 'dart:async';

import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/api.dart' as api;

class MainBloc {

  final StreamController<User> _meController = StreamController<User>();
  
  Stream<User> get meStream => _meController.stream;

  void setUser(User user) {
    _meController.sink.add(user);
  }

  void refreshUser() async {
    var user = await api.get("/users/me");
    _meController.sink.add(user);
  }

}