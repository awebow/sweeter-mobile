import 'package:flutter/material.dart';
import 'package:sweeter_mobile/main/main_bloc.dart';
import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/sweet/new_sweet_page.dart';
import 'package:sweeter_mobile/sweet/sweet_list.dart';

class MainPage extends StatelessWidget {

  final MainBloc bloc = MainBloc();
  final User initialUser;

  MainPage({User user}) : initialUser = user {
    bloc.refreshSweets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Theme(
          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
          child: Container(height: 40, child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none
              ),
              contentPadding: EdgeInsets.all(0)
            ),
          ))
        )
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<User>(
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
          Expanded(child: SweetList(bloc.mySweetsStream))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewSweetPage()))
            .then((result) {
              if(result != null)
                bloc.refreshSweets();
            });
        },
      ),
    );
  }

}