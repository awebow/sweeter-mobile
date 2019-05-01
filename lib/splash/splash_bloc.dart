import 'dart:async';

class SplashBloc {

  Function callback;

  SplashBloc() {
    Timer(Duration(seconds: 1), () => callback());
  }

}