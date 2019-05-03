import 'package:flutter/material.dart';
import 'package:sweeter_mobile/models/sweet.dart';
import 'package:sweeter_mobile/sweet/sweet_view.dart';

class SweetList extends StatefulWidget {

  final bool scrollable;
  final Stream<List<Sweet>> stream;
  final Function onRefresh;

  SweetList(this.stream, {this.scrollable = true, this.onRefresh});

  @override
  State<StatefulWidget> createState() {
    return SweetListState();
  }

}

class SweetListState extends State<SweetList> {

  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Sweet>>(
      stream: widget.stream,
      initialData: [],
      builder: (context, snapshot) {
        if(widget.scrollable)
          return RefreshIndicator(
            onRefresh: widget.onRefresh,
            child: ListView.builder(
              itemCount: snapshot.data.length,
              padding: EdgeInsets.all(0),
              itemBuilder: (context, index) => SweetView(snapshot.data[index])
            )
          );
        else
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: snapshot.data.map((sweet) => SweetView(sweet)).toList()
          );
      }
    );
  }

}