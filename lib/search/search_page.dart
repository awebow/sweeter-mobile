import 'package:flutter/material.dart';
import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/search/search_bloc.dart';
import 'package:sweeter_mobile/user/user_page.dart';

class SearchPage extends StatefulWidget {

  final String keyword;

  SearchPage(this.keyword);
  
  @override
  State<StatefulWidget> createState() {
    return SearchPageState(keyword);
  }

}

class SearchPageState extends State<SearchPage> {

  final SearchBloc bloc = SearchBloc();

  SearchPageState(String keyword) {
    bloc.search(keyword);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.keyword)),
      body: StreamBuilder<List<User>>(
        initialData: null,
        stream: bloc.resultStream,
        builder: (context, snapshot) {
          if(snapshot.data != null && snapshot.data.length == 0)
            return Text("There is no search result.");
          else
            return ListView.builder(
              itemCount: snapshot.data == null ? 0 : snapshot.data.length,
              itemBuilder: (context, index) => ListTile(
                leading: Container(width: 36, height: 36, child: CircleAvatar(backgroundColor: Colors.transparent, backgroundImage: NetworkImage("https://i.stack.imgur.com/34AD2.jpg"))),
                title: Text(snapshot.data[index].name),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage(snapshot.data[index]))),
              ),
            );
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