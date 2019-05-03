import 'package:flutter/material.dart';
import 'package:sweeter_mobile/api.dart' as api;
import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/user/user_page.dart';

void showMyPage(BuildContext context) async {
  var user = User.fromJson(await api.get('/users/me'));
  Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage(user)));
}