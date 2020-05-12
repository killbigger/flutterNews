import 'package:flutter/material.dart';
import 'package:newsilise/models/news_headlinesandeverything.dart';
import 'package:newsilise/pages/contentPage.dart';
import 'package:newsilise/widgets/progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
  
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
                itemCount: 12,
                itemBuilder: (BuildContext context,int index){
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical:125),
                      child:circularProgress()
                    );
                    }),
            );
              
          }
          if(snapshot.hasError){
            print('error in Future builder is ${snapshot.error}');
            return Container(
              height: 250,
              width: double.infinity,
              child: Center(child: Text(snapshot.error)),
            );
          }
          List<NewsAll> news = snapshot.data;
          
          
          return Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 12,
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
            );
       
        },
      ),
    ]
  );
  }

