import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsilise/httpEndpoints.dart/topHeadlines.dart';
import 'package:newsilise/models/news_headlinesandeverything.dart';
import 'package:newsilise/widgets/progress.dart';

class Inshort extends StatefulWidget {
  @override
  _InshortState createState() => _InshortState();
}

class _InshortState extends State<Inshort>with AutomaticKeepAliveClientMixin<Inshort> {
 bool get wantKeepAlive => true;
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
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: <Widget>[
                Container(width: double.infinity,
                height:285,
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
                
                       Padding(
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
                   
                IconButton(
                    icon: Icon(Icons.web),
                    color: Colors.blue,
                    iconSize: 40,
                    onPressed: (){

                    },
                  ),
                
            ],),
          ),
          );
      }
    );
      },
    );
  }
}