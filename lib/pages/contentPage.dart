
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

  
   
  @override
  Widget build(BuildContext context) {
    
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
                height:340,
                  child:Container()
                  // CachedNetworkImage(
                  //     imageUrl: news[index].urlToImage,
                  //     placeholder: (context, url) => circularProgress(),
                  //     errorWidget: (context, url, error) => Icon(Icons.error),
                  //                 ),
                )
            ],),
          ),
          );
      }
    );
  }
}