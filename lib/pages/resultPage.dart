import 'package:flutter/material.dart';
import 'package:newsilise/widgets/resultPageHeader.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate:ResultPageHeader(
           minExtent:82,
           maxExtent:360,
         
        ) ,
        ),
        SliverList(
          delegate:SliverChildBuilderDelegate((context,index){
            return ListTile(title: Text('List no $index'),);
          })
          )
        ],
      ),
    );
  }
}