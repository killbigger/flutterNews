
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsilise/homeList/headlines.dart';
import 'package:newsilise/httpEndpoints.dart/topHeadlines.dart';
import 'package:newsilise/models/news_headlinesandeverything.dart';
import 'package:newsilise/pages/contentPage.dart';
import 'package:newsilise/pages/selectCountry.dart';
import 'package:newsilise/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget { 
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  String selectedCountry;
 TopHeadlines topHeadlines;
 TopHeadlines sportHeadlines;
 TopHeadlines entertainmentHeadlines;
 List<NewsAll> news=[];
 bool get wantKeepAlive => true;
 @override
  void initState() {
    buildSharedPreferences();
      selectedCountry='in';
    super.initState();
  
  }
   buildSharedPreferences() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
  String data = prefs.getString('favnews');
 var body = json.decode(data);
 List<NewsAll> list = [];
 body.forEach((data){
    list.add(NewsAll.fromJson(data));
});
  if(body!=null){
   setState(() {
     news=list;
   });
      
   
    
  }
   }
  buildFavorites(){
   return news.isNotEmpty?
    Column(
     mainAxisAlignment: MainAxisAlignment.start,
     children: <Widget>[
       Text('Favorites',
      style: TextStyle(fontSize: 28,
      color: Colors.white,
      letterSpacing: 0.7,
      ),
      ),
 Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:news.length,
                itemBuilder: (BuildContext context,int index){
                 
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(
                     builder: (context)=>
                     ContentPage(
                     news:news,
                     
                     index: index,
                     )
                     ));
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                          height: 150,
                          width: 150,
                          child:
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:Container(
                            child:
                          news[index].urlToImage!=null? CachedNetworkImage(
                              imageUrl: news[index].urlToImage,
                              placeholder: (context, url) => circularProgress(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              fit: BoxFit.cover,
                          ):
                          Image(
                            image: AssetImage('assets/images/nullimage.jpg'),
                            fit: BoxFit.cover,
                          ),
                          )
                         
                        ),
                         
                          ),
                          Container(
                            width: 150,
                            child: Text(news[index].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11
                            ),
                            maxLines: 5,
                            
                            overflow: TextOverflow.ellipsis,
                            ),
                          )
                      ],),
                    ),
                  );
                }
                
                ),
            )
   ],):Text('');

  
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
                    buildFavorites(),
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