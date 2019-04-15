import 'package:sweeter_mobile/api.dart' as api;
import 'package:sweeter_mobile/models/user.dart';

class LoginBloc {

  Future<User> submit(String id, String password) async {
    try {
      var token = (await api.post("/users/tokens", body: {
        "id": id,
        "password": password
      }))["authorization"];
        
      api.setAuthorization("Bearer " + token);
      return useToken();
    }
    catch(error) {
      return Future.error(error);
    }
  }

  Future<User> useToken() async {
    return User.fromJson(await api.get("/users/me"));
  }

}