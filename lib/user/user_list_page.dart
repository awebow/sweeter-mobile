import 'package:flutter/material.dart';
import 'package:sweeter_mobile/models/user.dart';
import 'package:sweeter_mobile/user/user_page.dart';

class UserListPage extends StatelessWidget {

  final String title;
  final List<User> users;

  UserListPage(this.title, this.users);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => ListTile(
          leading: Container(width: 36, height: 36, child: CircleAvatar(backgroundColor: Colors.transparent, backgroundImage: NetworkImage("https://i.stack.imgur.com/34AD2.jpg"))),
          title: Text(users[index].name),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage(users[index]))),
        ),
      ),
    );
  }

}