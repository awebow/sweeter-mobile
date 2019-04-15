import 'package:flutter/material.dart';
import 'package:sweeter_mobile/main/main_bloc.dart';
import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/sweet/new_sweet_bloc.dart';

class NewSweetPage extends StatelessWidget {

  final NewSweetBloc bloc = NewSweetBloc();

  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sweeter"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () {
              bloc.submit(contentController.text).then((_) {
                Navigator.pop(context);
              });
            }
          )
        ],
      ),
      body: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Do you have a sweet story?"
        ),
        controller: contentController,
      ),
    );
  }

}