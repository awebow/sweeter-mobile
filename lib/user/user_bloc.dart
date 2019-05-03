import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:sweeter_mobile/models/sweet.dart';
import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/api.dart' as api;

class UserBloc {

  User user;
  String relation;
  final StreamController<List<Sweet>> _sweetsController = StreamController<List<Sweet>>.broadcast();
  get sweetsStream => _sweetsController.stream;

  final StreamController<String> _relationCotroller = StreamController<String>.broadcast();
  get relationStream => _relationCotroller.stream;

  final StreamController<List<User>> _followersController = StreamController<List<User>>.broadcast();
  get followersStream => _followersController.stream;

  final StreamController<List<User>> _followingsController = StreamController<List<User>>.broadcast();
  get followingsStream => _followingsController.stream;

  final StreamController<String> _pictureController = StreamController<String>.broadcast();
  get pictureStream => _pictureController.stream;

  UserBloc(this.user) {
    refreshSweets();
    refreshRelation();
    refreshFollowers();
    refreshFollowings();
  }

  Future<void> refreshSweets() async {
    Iterable items = await api.get("/users/${user.no}/sweets");
    var sweets = items.map((item) => Sweet.fromJson(item)).toList();
    _sweetsController.sink.add(sweets);
    return Future.value();
  }

  refreshFollowers() async {
    Iterable items = await api.get("/users/${user.no}/followers");
    var users = items.map((item) => User.fromJson(item)).toList();
    _followersController.sink.add(users);
  }

  refreshFollowings() async {
    Iterable items = await api.get("/users/${user.no}/followings");
    var users = items.map((item) => User.fromJson(item)).toList();
    _followingsController.sink.add(users);
  }

  refreshRelation() async {
    var result = await api.get("/users/me/relations/${user.no}");
    relation = result["relation"];
    _relationCotroller.sink.add(relation);
  }

  follow() async {
    await api.post("/users/me/followings/${user.no}");
    refreshRelation();
    refreshFollowers();
  }

  unfollow() async {
    await api.delete("/users/me/followings/${user.no}");
    refreshRelation();
  }

  uploadProfile(File file) async {
    var contentType = "";
    var ext = file.path.split(".").last;

    if(ext == "jpg" || ext == "jpeg")
      contentType = "image/jpeg";
    else if(ext == "png")
      contentType = "image/png";

    var user = User.fromJson(await api.put("/users/me/picture", body: file.readAsBytesSync(), raw: true, contentType: contentType));
    _pictureController.sink.add(user.picture);
    refreshSweets();
  }

  dispose() {
    _sweetsController.close();
    _relationCotroller.close();
    _followersController.close();
    _followingsController.close();
    _pictureController.close();
  }

}