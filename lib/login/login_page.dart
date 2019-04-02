import 'package:flutter/material.dart';
import 'package:sweeter_mobile/register/register_page.dart';

class LoginPage extends StatelessWidget {
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
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Password"
            ),
          ),
          RaisedButton(
            child: Text("Login"),
          ),
          RaisedButton(
            child: Text("Register"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
            },
          )
        ],
      ),
    );
  }

}