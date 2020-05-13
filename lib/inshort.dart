import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsilise/httpEndpoints.dart/topHeadlines.dart';
import 'package:newsilise/models/news_headlinesandeverything.dart';
import 'package:newsilise/pages/webPage.dart';
import 'package:newsilise/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Inshort extends StatefulWidget {
  @override
  _InshortState createState() => _InshortState();
}

class _InshortState extends State<Inshort>with AutomaticKeepAliveClientMixin<Inshort> {
 bool get wantKeepAlive => true;
  List<NewsAll> favNews=[];
 bool added = false;
  int fIndex;
  @override
  void initState() { 
    stringFromStorage();
    super.initState();
    
  }
   stringFromStorage() async {
  SharedPreferences prefs =await SharedPreferences.getInstance();
  String data = prefs.getString('favnews');
 var body = json.decode(data);
 List<NewsAll> list = [];
 
 body.forEach((data){
    list.add(NewsAll.fromJson(data));
});

  if(body!=null){
    setState(() {
      favNews=list;
    });
    
  }
  
}
addToFavorite(int findex,bool added,int index,news)async{
  SharedPreferences prefs =await SharedPreferences.getInstance();
if(added){
  setState(() {
    favNews.removeAt(findex);
  });
} else {
  setState(() {
    favNews.add(NewsAll(author: news[index].author,title:news[index].title,publishedAt:news[index].publishedAt,
  urlToImage:news[index].urlToImage,url:news[index].url,content:news[index].content,description:news[index].description,
  )); 
  });
    
  
}
String jsonFavNews = jsonEncode(favNews);

await prefs.setString('favnews', jsonFavNews);
}
  @override
  Widget build(BuildContext context) {
    super.build(context);
   TopHeadlines topHeadlines=TopHeadlines(country:'in');
    return FutureBuilder(
      future: topHeadlines.getNews(),
      builder: (BuildContext context, AsyncSnapshot<List<NewsAll>> snapshot) {
        if(!snapshot.hasData){
         return  circularProgress();
        } 
        List<NewsAll>news = snapshot.data;
        return  PageView.builder(
      itemCount: news.length,
      scrollDirection: Axis.vertical,
      itemBuilder:(context,index){
         int findex;
        favNews.forEach((element){
         
          if(element.title==news[index].title){
            findex = favNews.indexOf(element);
          } else {
            
          }
        });
        bool added =favNews.any((e)=>
         e.title.contains(news[index].title)
          );
        return Scaffold(
             floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              child: Icon(added?Icons.favorite:Icons.favorite_border,
              color:added?Colors.red:Colors.white
              ),
              onPressed: ()=>addToFavorite(findex,added,index,news),
            ),
            backgroundColor: Colors.white,
            body: Container(
              child: Column(
                children: <Widget>[
                  Container(width: double.infinity,
                  height:250,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8,top: 6),
                    child: Text(news[index].title,
                    style:TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8,top: 8),
                    child: Text(news[index].description!=null?news[index].description:'',
                    style:TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  
                         Expanded(
                           child: Padding(
                        padding: const EdgeInsets.only(left:8.0,right: 8,top: 6),
                        child: Text(news[index].content!=null?news[index].content:'',
                        
                        style:TextStyle(
                            color:Colors.black,
                            fontSize: 15,
                            
                            ),
                        ),
                  ),
                         ),
              Container(
              width: 100.0,
              height: 50.0,
              alignment: Alignment.center,
              child: RaisedButton.icon(
                label: Text(
                  "visit",
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.red,
                onPressed:(){
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                            return WebPage(url:news[index].url);
                          }));
                },
                icon: Icon(
                  Icons.web,
                  color: Colors.white,
                ),
              ),
              )
                    
                  
                  
              ],),
            ),
            
        );
      }
    );
      },
    );
  }
}