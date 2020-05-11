
import 'package:flutter/material.dart';
import 'package:newsilise/homeList/headlines.dart';
import 'package:newsilise/httpEndpoints.dart/topHeadlines.dart';
import 'package:newsilise/pages/selectCountry.dart';

class Home extends StatefulWidget { 
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  String selectedCountry;
 TopHeadlines topHeadlines;
 TopHeadlines sportHeadlines;
 TopHeadlines entertainmentHeadlines;
 bool get wantKeepAlive => true;
 @override
  void initState() {
    
    super.initState();
    selectedCountry='in';
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    topHeadlines=TopHeadlines(country:selectedCountry);
    sportHeadlines=TopHeadlines(country:selectedCountry,category:'sports');
    entertainmentHeadlines=TopHeadlines(country:selectedCountry,category:'entertainment');
    return Scaffold(
      body: Container(
         decoration:BoxDecoration(
          gradient:LinearGradient(
            begin:Alignment.topLeft,
            end:Alignment(0.4,0.4),
            colors: [
              
              Colors.pink[300],
              Colors.black,
              
            ]
          ) ), 
        child: SingleChildScrollView(
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
                            onPressed: ()async{
                            
                             final result= await Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectCountry(selectedCountry:selectedCountry)));
                             setState(() {
                               selectedCountry=result;
                             });
                             }),
                  ),
                  SizedBox(height: 18,),
                    buildTopHeadlines(topHeadlines,'Top Headlines'),
                    buildTopHeadlines(entertainmentHeadlines,'Entertainment'),
                    buildTopHeadlines(sportHeadlines,'Sports'),   
                ],),

             ),
          ),
        ),
      ),
    );
  }
}