import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsilise/models/news_headlinesandeverything.dart';

import 'package:newsilise/pages/webPage.dart';
import 'package:newsilise/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ContentPage extends StatefulWidget {

  final List<NewsAll> news;
  final int index;
  ContentPage({
    this.news,
    
    this.index,
  });
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  PageController pageController;
  List<NewsAll> news;
  List<NewsAll> favNews=[];
 bool added = false;
  int fIndex;
  @override
  void initState() {
    stringFromStorage();
    this.news=widget.news;
    pageController=PageController(initialPage: widget.index);
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
addToFavorite(int findex,bool added,int index)async{
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
  newsFromOtherPage(){
    
   return PageView.builder(
      itemCount: news.length,
      controller: pageController,
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
            onPressed: ()=>addToFavorite(findex,added,index),
          ),
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: <Widget>[
                Container(width: double.infinity,
                height:300,
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
            //     RichText(
              
            //   text: TextSpan(
                
            //     style: TextStyle(fontSize: 14,color: Colors.black),
            //   children:[
            //     TextSpan(text:news[index].title,
            //     style: TextStyle(fontWeight: FontWeight.bold,fontSize:19)
            //        ),
            //        TextSpan(text:news[index].description!=null?news[index].description:'',
            //        style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold
            //           ),
            //        ),
            //        TextSpan(
            //          text:news[index].content!=null?news[index].content:'',
            //           style:TextStyle(
            //           color:Colors.black,
            //           fontSize: 15,
            //           // fontWeight: FontWeight.bold
            //           ),
            //        )
            //   ]

            //   ),
            // ),
                 
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
                    child: Text(news[index].content!=null?news[index].content
                    :''
                    ,
                    style:TextStyle(
                      color:Colors.black,
                      fontSize: 15,
                      // fontWeight: FontWeight.bold
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
  }
  @override
  Widget build(BuildContext context) {
    
    return newsFromOtherPage();
  }
}