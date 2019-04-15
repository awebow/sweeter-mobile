import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/api.dart' as api;
import 'dart:convert';
import 'package:sweeter_mobile/data.dart' as data;

class RegisterBloc {

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

}