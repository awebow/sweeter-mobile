import 'package:flutter/material.dart';
import 'package:sweeter_mobile/login/login_page.dart';
import 'package:sweeter_mobile/splash/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }

}

class SplashPageState extends State<SplashPage> {

  final SplashBloc bloc = SplashBloc();

  @override
  Widget build(BuildContext context) {
    bloc.callback = () { Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => LoginPage())); };
    return Scaffold(
      body: SizedBox.expand(child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/lollipop.png", width: 150),
            Container(height: 20),
            Text("Share your sweet story", style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),)
          ],
        ),
      )),
    );
  }

}