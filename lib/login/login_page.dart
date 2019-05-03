import 'package:flutter/material.dart';
import 'package:sweeter_mobile/login/login_bloc.dart';
import 'package:sweeter_mobile/main/main_page.dart';
import 'package:sweeter_mobile/register/register_page.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }

}

class LoginPageState extends State<LoginPage> {

  final LoginBloc bloc = LoginBloc();
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset("assets/lollipop.png", width: 100),
              Container(height: 20),
              Container(width: 200, child: TextField(
                decoration: InputDecoration(
                  hintText: "User ID",
                  filled: true,
                  fillColor: Theme.of(context).primaryColorDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    borderSide: BorderSide.none
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white.withAlpha(128)
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
                style: TextStyle(
                  color: Colors.white
                ),
                controller: idController,
              )),
              Container(height: 7),
              Container(width: 200, child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  filled: true,
                  fillColor: Theme.of(context).primaryColorDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    borderSide: BorderSide.none
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white.withAlpha(128)
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
                style: TextStyle(
                  color: Colors.white
                ),
                controller: pwController,
              )),
              Container(height: 20),
              Container(width: 200, child: RaisedButton(
                child: Text("Login"),
                color: Theme.of(context).primaryColorLight,
                onPressed: () {
                  bloc.submit(idController.text, pwController.text).then((user) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(user: user)));
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
              )),
              FlatButton(
                child: Text("No account? Sign up!", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage())).then((result) {
                    if(result) {
                      bloc.useToken().then((user) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(user: user)));
                      });
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

}