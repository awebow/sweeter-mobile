import 'package:sweeter_mobile/api.dart' as api;
import 'package:sweeter_mobile/models/sweet.dart';

class NewSweetBloc {

  Future<Sweet> submit(String content) async {
    try {
      return Sweet.fromJson(await api.post("/sweets", body: {"content": content}));
    }
    catch(error) {
      return Future.error(error);
    }
  }

}