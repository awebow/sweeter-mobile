import 'package:flutter/material.dart';
import 'package:sweeter_mobile/login/login_bloc.dart';
import 'package:sweeter_mobile/main/main_page.dart';
import 'package:sweeter_mobile/register/register_page.dart';

class LoginPage extends StatelessWidget {

  final LoginBloc bloc = LoginBloc();
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "User ID",
            ),
            controller: idController,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Password"
            ),
            controller: pwController,
          ),
          RaisedButton(
            child: Text("Login"),
            onPressed: () {
              bloc.submit(idController.text, pwController.text).then((user) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(user: user)));
              });
            },
          ),
          RaisedButton(
            child: Text("Register"),
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
    );
  }

}