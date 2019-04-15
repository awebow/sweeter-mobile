import 'package:sweeter_mobile/api.dart' as api;

class NewSweetBloc {

  Future<void> submit(String content) async {
    try {
      await api.post("/sweets", body: {"content": content});
    }
    catch(error) {
      return Future.error(error);
    }
  }

}