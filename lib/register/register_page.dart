import 'package:flutter/material.dart';
import 'package:sweeter_mobile/data.dart' as data;
import 'package:sweeter_mobile/register/register_bloc.dart';

class RegisterPage extends StatelessWidget {

  final RegisterBloc bloc = RegisterBloc();

  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
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
          TextField(
            decoration: InputDecoration(
              labelText: "Name"
            ),
            controller: nameController,
          ),
          RaisedButton(
            child: Text("Register"),
            onPressed: () => doRegister(context),
          )
        ],
      ),
    );
  }

  void doRegister(BuildContext context) {
    bloc.submit(idController.text, pwController.text, nameController.text).then((user) {
      Navigator.pop(context, true);
    }).catchError((error) {
      if(error == 409) {
        showConflictDialog(context);
      }
    });
  }

  void showConflictDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Register Failed'),
          content: Text('The user id is already registered!'),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      }
    );
  }

}