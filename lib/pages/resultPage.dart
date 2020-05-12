
import 'package:flutter/material.dart';
import 'package:newsilise/httpEndpoints.dart/everything.dart';
import 'package:newsilise/httpEndpoints.dart/topHeadlines.dart';
import 'package:newsilise/models/news_headlinesandeverything.dart';
import 'package:newsilise/pages/contentPage.dart';
import 'package:newsilise/widgets/progress.dart';
import 'package:newsilise/widgets/resultPageHeader.dart';

class ResultPage extends StatefulWidget {
  final String sortBy;
  final String category;
 final String q;
final bool isEverything;
 final String source;
 ResultPage({
   this.sortBy='publishedAt',
   this.category='',
 this.q='',
this.isEverything,
 this.source=''
 }) ;
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  

  @override
  Widget build(BuildContext context) {
     futureCaller(){
    if(!widget.isEverything){
      if(widget.q!=''){
        TopHeadlines qtopHeadlines = TopHeadlines(q: widget.q);
        return qtopHeadlines.getNews();
      } else if(widget.category!=''){
        TopHeadlines categorytopHeadlines = TopHeadlines(category: widget.category);
        return categorytopHeadlines.getNews();
      } 
    } else {
      if(widget.q!=''&&widget.source!=''){
        Search qsourceSearch = Search(q: widget.q,sources: widget.source,sortBy: widget.sortBy);
        return qsourceSearch.getNews();
      } else if(widget.q!='') {
         Search qSearch = Search(q: widget.q,sortBy: widget.sortBy);
         return qSearch.getNews();
      } else if(widget.source!=''){
        Search sourceSearch = Search(sources: widget.source,sortBy: widget.sortBy);
        return sourceSearch.getNews();
      }
    }      
    }
    return WillPopScope(
      onWillPop: ()=> Future.value(false),
      child: Scaffold(
        
        body: 
        FutureBuilder(
          future: futureCaller(),
          builder: (BuildContext context, AsyncSnapshot<List<NewsAll>> snapshot) {
            if(!snapshot.hasData){
              return circularProgress();
            }
            List<NewsAll> news = snapshot.data;
            return Container(
            decoration:BoxDecoration(
            gradient:LinearGradient(
              begin:Alignment.topLeft,
              end:Alignment(0.3,0.3),
              colors: [
                Colors.blue[200],
                Colors.black
              ]
            ) ), 
              child: CustomScrollView(

          slivers: <Widget>[
              
              SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate:ResultPageHeader(
               minExtent:82,
               maxExtent:360,
              sortBy:widget.sortBy,
              category:widget.category,
              q:widget.q,
              isEverything:widget.isEverything,
              source:widget.source
           
          ) ,
          ),
          SliverList(
              delegate:SliverChildBuilderDelegate((context,index){
                return 
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                      return 
                     ContentPage(index: index,
                      news:news,
                      );
                      
                    }));
                      
                    },
                  leading: CircleAvatar(backgroundImage:news[index].urlToImage==null?
                             AssetImage('assets/images/nullimage.jpg'):NetworkImage(news[index].urlToImage),
                              
                            
                  radius: 23,
                  ),
                  title: Text(news[index].title),
                  );
              },
              childCount: news.length)
              )
          ],
        ),
            );
          },
        ),
        
      ),
    );
  }
}