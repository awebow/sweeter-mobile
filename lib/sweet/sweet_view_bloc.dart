import 'dart:async';

import 'package:sweeter_mobile/models/sweet.dart';
import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/api.dart' as api;
import 'package:sweeter_mobile/utils/timeago.dart';

class SweetViewBloc {

  final Sweet sweet;

  final StreamController<User> _authorController = StreamController<User>.broadcast();
  get authorStream => _authorController.stream;

  final StreamController<String> _sweetAtController = StreamController<String>.broadcast();
  get sweetAtStream => _sweetAtController.stream;

  Timer _sweetAtTimer;
  

  SweetViewBloc(this.sweet) {
    refreshAuthor();
    calcRefreshSweetAt();
  }

  refreshAuthor() async {
    var author = User.fromJson(await api.get("/users/${sweet.author}"));
    _authorController.sink.add(author);
  }

  calcRefreshSweetAt() {
    if(_sweetAtTimer != null)
      _sweetAtTimer.cancel();
    var current = DateTime.now();
    Timer(Duration(milliseconds: 60000 - current.second * 1000 - current.millisecond), () {
      refreshSweetAt();
      _sweetAtTimer = Timer.periodic(Duration(minutes: 1), (timer) => refreshSweetAt());
    });
  }

  refreshSweetAt() {
    var current = DateTime.now();
    _sweetAtController.sink.add(timeago(sweet.sweetAt, current));
  }

  dispose() {
    _authorController.close();
    _sweetAtController.close();
    if(_sweetAtTimer != null)
      _sweetAtTimer.cancel();
  }
  

}