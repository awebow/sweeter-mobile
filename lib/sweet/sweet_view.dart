import 'package:flutter/material.dart';
import 'package:sweeter_mobile/models/sweet.dart';
import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/sweet/sweet_view_bloc.dart';
import 'package:sweeter_mobile/user/user_page.dart';
import 'package:sweeter_mobile/utils/timeago.dart';
import 'package:sweeter_mobile/api.dart' as api;

class SweetView extends StatefulWidget {

  final Sweet sweet;

  SweetView(this.sweet);

  @override
  State<StatefulWidget> createState() {
    return SweetViewState(sweet);
  }

}

class SweetViewState extends State<SweetView> {
  
  Sweet sweet;
  SweetViewBloc bloc;

  SweetViewState(this.sweet) : bloc = SweetViewBloc(sweet);

  @override
  Widget build(BuildContext context) {
    return Card(child: Container(
      padding: EdgeInsets.all(10),
      child: StreamBuilder<User>(
        stream: bloc.authorStream,
        initialData: User(),
        builder: (context, snapshot) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data.picture == null ? "https://i.stack.imgur.com/34AD2.jpg" : api.serverUrl + "/statics/${snapshot.data.picture}"),
                  backgroundColor: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage(snapshot.data))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(snapshot.data == null ? "" : snapshot.data.name),
                      StreamBuilder<String>(
                        stream: bloc.sweetAtStream,
                        initialData: timeago(sweet.sweetAt, DateTime.now()),
                        builder: (context, snapshot) => Text(snapshot.data),
                      )
                    ],
                  )
                )
              ]
            ),
            Container(height: 10),
            Text(snapshot.data == null ? "" : sweet.content)
          ],
        )
      ),
    ));
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SweetView oldWidget) {
    if(widget.sweet.no != oldWidget.sweet.no || widget.sweet.content != oldWidget.sweet.content) {
      bloc.dispose();
      setState(() {
        sweet = widget.sweet;
        bloc = SweetViewBloc(sweet);
      });
    } else {
      bloc.refreshAuthor();
    }
    super.didUpdateWidget(oldWidget);
  }

}