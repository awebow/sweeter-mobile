import 'package:flutter/material.dart';
import 'package:sweeter_mobile/main/main_bloc.dart';
import 'package:sweeter_mobile/models/user.dart';

class MainPage extends StatelessWidget {

  final MainBloc bloc = MainBloc();
  User initialUser;

  MainPage({User user}) : this.initialUser = user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sweeter")),
      body: StreamBuilder<User>(
        stream: bloc.meStream,
        initialData: initialUser,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Text("ID: ${snapshot.data.id}"),
              Text("Name: ${snapshot.data.name}")
            ],
          );
        },
      ),
    );
  }

}