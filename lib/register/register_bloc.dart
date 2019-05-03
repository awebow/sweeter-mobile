import 'dart:async';

import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/api.dart' as api;
import 'dart:convert';
import 'package:sweeter_mobile/data.dart' as data;

class RegisterBloc {

  final StreamController<bool> _pwConfirmController = StreamController<bool>();

  get pwConfirmStream => _pwConfirmController.stream;

  checkPassword(String password, String confirmation) {
    _pwConfirmController.sink.add(password == confirmation);
  }

  Future<void> submit(String id, String password, String name) async {
    try {
      await api.post("/users", body: {
        "id": id,
        "password": password,
        "name": name
      });

      var token = (await api.post("/users/tokens", body: {
        "id": id,
        "password": password
      }))["authorization"];

      api.setAuthorization("Bearer " + token);
      return Future.value();
    } catch(error) {
      return Future.error(error);
    }
  }

  dispose() {
    _pwConfirmController.close();
  }

}