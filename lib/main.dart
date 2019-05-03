import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sweeter_mobile/data.dart';
import 'package:sweeter_mobile/login/login_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sweeter_mobile/splash/splash_page.dart';

void main() async {
  final dir = await getApplicationDocumentsDirectory();
  File file = File('$dir/data.json');
  Data data;
  if(await file.exists()) {
    String raw = file.readAsStringSync();
    data = Data.fromJson(jsonDecode(raw));
  }
  else {
    data = Data();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sweeter',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Colors.pink[300],
      ),
      home: SplashPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
