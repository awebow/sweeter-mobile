import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sweeter_mobile/models/user.dart';

const serverUrl = "http://192.168.0.27:8080";
var _authorization = "";

Future<dynamic> get(String resource) async {
  var response = await http.get(serverUrl + resource, headers: _getDefaultHeaders());
  if(response.statusCode == 200) {
    return jsonDecode(response.body);
  }
  else {
    return Future.error(response.statusCode);
  }
}

Future<dynamic> post(String resource, {dynamic body}) async {
  var response = await http.post(serverUrl + resource, body: jsonEncode(body), headers: _getDefaultHeaders());
  if(response.statusCode == 200) {
    return jsonDecode(response.body);
  }
  else {
    return Future.error(response.statusCode);
  }
}

setAuthorization(String authorization) {
  _authorization = authorization;
}

Map<String, String> _getDefaultHeaders() {
  var headers = {
    "Content-Type": "application/json"
  };
  if(_authorization.isNotEmpty)
    headers['Authorization'] = _authorization;
  return headers;
}