
import 'package:flutter/material.dart';
import 'package:newsilise/homeList/headlines.dart';
import 'package:newsilise/httpEndpoints.dart/topHeadlines.dart';
import 'package:newsilise/pages/selectCountry.dart';

class Home extends StatefulWidget { 
 final String selectedCountry ;
  Home({
    this.selectedCountry,
  });
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
 TopHeadlines topHeadlines;
 TopHeadlines sportHeadlines;
 TopHeadlines entertainmentHeadlines;
 bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    topHeadlines=TopHeadlines(country:widget.selectedCountry);
    sportHeadlines=TopHeadlines(country:widget.selectedCountry,category:'sports');
    entertainmentHeadlines=TopHeadlines(country:widget.selectedCountry,category:'entertainment');
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:22.0,left: 8,right: 8),
           child: Container(
             width: double.infinity,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                          icon:
                          Icon(Icons.settings,
                          size: 25,
                          color: Colors.white,
                          ),
                          onPressed: ()=>
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectCountry(selectedCountry:widget.selectedCountry)))
                       ),
                ),
                SizedBox(height: 18,),
                  buildTopHeadlines(topHeadlines,'Top Headlines'),
                  buildTopHeadlines(entertainmentHeadlines,'Entertainment'),
                  buildTopHeadlines(sportHeadlines,'Sports'),
                  
              ],),

           ),
        ),
      ),
    );
  }
}