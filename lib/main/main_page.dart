import 'package:flutter/material.dart';
import 'package:sweeter_mobile/main/main_bloc.dart';
import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/search/search_page.dart';
import 'package:sweeter_mobile/sweet/new_sweet_page.dart';
import 'package:sweeter_mobile/sweet/sweet_list.dart';
import 'package:sweeter_mobile/utils/actions.dart' as actions;

class MainPage extends StatefulWidget {

  final User initialUser;

  MainPage({User user}) : initialUser = user;

  @override
  State<StatefulWidget> createState() {
    return MainPageState(user: initialUser);
  }

}

class MainPageState extends State<MainPage> {

  final MainBloc bloc = MainBloc();
  final User initialUser;

  MainPageState({User user}) : initialUser = user {
    bloc.refreshSweets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Theme(
          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
          child: Container(height: 35, child: TextField(
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17.5),
                borderSide: BorderSide.none
              ),
              contentPadding: EdgeInsets.all(0)
            ),
            onSubmitted: (keyword) {
              if(keyword.length > 0)
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(keyword)));
            },
          ))
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            iconSize: 40,
            onPressed: () => actions.showMyPage(context),
            padding: EdgeInsets.all(0),
          )
        ],
      ),
      body: Container(color: Colors.grey[200], child: Column(
        children: <Widget>[
          Expanded(child: SweetList(bloc.mySweetsStream, onRefresh: bloc.refreshSweets))
        ],
      )),
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

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

}