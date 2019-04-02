import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
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
          TextField(
            decoration: InputDecoration(
              labelText: "Name"
            ),
          ),
          RaisedButton(
            child: Text("Register"),
          )
        ],
      ),
    );
  }

}