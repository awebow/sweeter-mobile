import 'package:flutter/material.dart';
import 'package:sweeter_mobile/models/sweet.dart';

class SweetList extends StatelessWidget {

  final Stream<List<Sweet>> stream;

  SweetList(this.stream);
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Sweet>>(
      stream: stream,
      initialData: [],
      builder: (context, snapshot) => ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) => Text(snapshot.data[index].content)
      )
    );
  }

}