import 'package:flutter/material.dart';
import 'package:sweeter_mobile/data.dart' as data;
import 'package:sweeter_mobile/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }

}

class RegisterPageState extends State<RegisterPage> {
  
  final RegisterBloc bloc = RegisterBloc();

  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController pwchkController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text("Sign up"),),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(child: 
        SingleChildScrollView(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
              onChanged: (text) => bloc.checkPassword(pwController.text, pwchkController.text),
            )),
            Container(height: 7),
            StreamBuilder<bool>(
              stream: bloc.pwConfirmStream,
              initialData: true,
              builder: (context, snapshot) => Container(width: 200, child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password Confirmation",
                  errorText: snapshot.data ? null : "Not equal to password",
                  filled: true,
                  fillColor: Theme.of(context).primaryColorDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    borderSide: BorderSide.none
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white.withAlpha(128)
                  ),
                  errorStyle: TextStyle(
                    color: Colors.red[900]
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
                style: TextStyle(
                  color: Colors.white
                ),
                controller: pwchkController,
                onChanged: (text) => bloc.checkPassword(pwController.text, pwchkController.text),
              ))
            ),
            Container(height: 7),
            Container(width: 200, child: TextField(
              decoration: InputDecoration(
                hintText: "Name",
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
              controller: nameController,
            )),
            Container(height: 20),
            Container(width: 200, child: RaisedButton(
              color: Theme.of(context).primaryColorLight,
              child: Text("Sign up"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9)
              ),
              onPressed: () => doRegister(context),
            ))
          ],
        ))
      ),
    );
  }

  void doRegister(BuildContext context) {
    if(pwController.text != pwchkController.text) return;

    bloc.submit(idController.text, pwController.text, nameController.text).then((_) {
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

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

}