import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class Data {

  String authorization;

  Data({this.authorization});

  Data.fromJson(Map<String, dynamic> json)
    : authorization = json['authorization'];

  Future<void> save() async {
    final dir = await getApplicationDocumentsDirectory();
    File('$dir/data.json').writeAsStringSync(jsonEncode(this));
    return Future.value();
  }

}