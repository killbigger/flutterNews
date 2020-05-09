import 'package:flutter/material.dart';
import 'package:newsilise/models/news_headlinesandeverything.dart';
buildTopHeadlines(topHeadlines,String heading){
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:<Widget>[
      Text(heading,
      style: TextStyle(fontSize: 28,
      color: Colors.white,
      letterSpacing: 0.7,
      ),
      ),
      FutureBuilder(
        future:topHeadlines.getNews(), 
        builder: (BuildContext context, AsyncSnapshot<List<NewsAll>> snapshot) {
          if(snapshot.hasError){
            print(snapshot.error);
          } else if(!snapshot.hasData){
            return Container(
              height:250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (BuildContext context,int index){
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(children: <Widget>[
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,),
                          height: 150,
                          width:150,
                          
                        ),
                        SizedBox(height:4,),
                         Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,),
                          height: 24,
                          width:145,
                          
                        ),
                      ],),
                    );
                    }),
            );
              
          }
          List<NewsAll> news = snapshot.data;
          return Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: news.length,
                itemBuilder: (BuildContext context,int index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                        height: 150,
                        width: 150,
                        child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(news[index].urlToImage,
                        fit: BoxFit.cover,
                        ),
                      ),
                       
                        ),
                        Container(
                          width: 150,
                          child: Text(news[index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11
                          ),),
                        )
                    ],),
                  );
                }
                
                ),
            );
       
        },
      ),
    ]
  );
  }

