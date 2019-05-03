import 'dart:async';

import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/api.dart' as api;

class SearchBloc {

  final StreamController<List<User>> _resultController = StreamController<List<User>>();
  get resultStream => _resultController.stream;

  search(String keyword) async {
    Iterable items = await api.get("/users?keyword=" + Uri.encodeComponent(keyword));
    var users = items.map((item) => User.fromJson(item)).toList();
    _resultController.sink.add(users);
  }


  dispose() {
    _resultController.close();
  }

}