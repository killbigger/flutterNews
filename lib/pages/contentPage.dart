import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsilise/models/news_headlinesandeverything.dart';
import 'package:newsilise/widgets/progress.dart';

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
  @override
  void initState() {
   
    super.initState();
    this.news=widget.news;
    pageController=PageController(initialPage: widget.index);
  }

  newsFromOtherPage(){
   return PageView.builder(
      itemCount: news.length,
      controller: pageController,
      scrollDirection: Axis.vertical,
      itemBuilder:(context,index){
        return Scaffold(
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    icon: Icon(Icons.web),
                    color: Colors.blue,
                    iconSize: 40,
                    onPressed: (){

                    },
                  ),
                )
            ],),
          ),
          );
      }
    );
  }
   directNews(){
   
   }
  @override
  Widget build(BuildContext context) {
    
    return newsFromOtherPage();
  }
}