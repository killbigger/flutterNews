import 'package:flutter/material.dart';
import 'package:newsilise/pages/resultPage.dart';
import 'package:newsilise/widgets/exploreHeader.dart';

class Explore extends StatefulWidget {

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  String q='';
  List sourceTiles = [
'BBC',
'The Hindu',
'Times of India',
'BBC Sport',
'ESPN',
'The Verge'

  ];
  List allTiles = [
    'corona',
    'football',
    'Sebin Davis',
    'movies',
     'music',
    'business',
    'general',
    'health',
    'science',
  ];
  List sourceTilesKey =[
    'bbc-news',
    'the-hindu',
    'the-times-of-india',
    'bbc-sport',
    'espn',
    'the-verge'
  ];
  List<Color> colorList = [
  Color.fromRGBO(156, 240, 225, 1),
  Color.fromRGBO(195, 240, 201, 1),
   Color.fromRGBO(245, 155, 35, 1),
    Color.fromRGBO(65, 0, 245, 1),
     Color.fromRGBO(159, 195, 209, 1),
   Color.fromRGBO(76, 145, 126, 1),
    Color.fromRGBO(159, 195, 209, 1),
    Color.fromRGBO(339, 53, 96, 1),
    Color.fromRGBO(181, 155, 200, 1),
    Color.fromRGBO(255, 100, 54, 1),   
    Color.fromRGBO(255, 200, 100, 1), 
    Color.fromRGBO(255, 70, 50, 1),
    Color.fromRGBO(245, 115, 161, 1),
    Color.fromRGBO(311, 77, 69, 1),
    Color.fromRGBO(241, 55, 166, 1),

  ];
  
  TextEditingController searchController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate:ExplorePageHeader(
           minExtent:82,
           maxExtent:250,
         
        ) ,
        ),
       SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(vertical:10,horizontal:8),
                child:Text('Browse top sources',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.7
                ),) ,)
            ]),
          ),
        SliverGrid(
         gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 2,
           mainAxisSpacing: 0,
           crossAxisSpacing: 1,
           childAspectRatio: 3/2,
         ),
          delegate: SliverChildBuilderDelegate((context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0,vertical:10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ResultPage(source:sourceTilesKey[index],isEverything: true,);
                  }));
                },
                child: Container(
                  padding: EdgeInsets.only(top:20,left:8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorList[index],
                  ),
                  child: Text(sourceTiles[index],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 0.7
                  ),),
                ),
              ),
            );
          },
          childCount: sourceTiles.length
          ),

        ),
         SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(vertical:10,horizontal:8),
                child:Text('Browse all',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.7
                ),) ,)
            ]),
          ),
        SliverGrid(
         gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 2,
           mainAxisSpacing: 0,
           crossAxisSpacing: 1,
           childAspectRatio: 3/2,
         ),
          delegate: SliverChildBuilderDelegate((context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0,vertical:10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    if(index==0){
                      return ResultPage(isEverything: false,q:allTiles[0]);
                    } else if(index>=5){
                      return ResultPage(isEverything: false,category:allTiles[index],);
                    } else if(index==1||index==2){
                        return ResultPage(isEverything: true,q:allTiles[index]);
                    } else {
                      return ResultPage(isEverything: true,q:allTiles[index],source:'mtv-news');
                    }
                  }));
                },
                child: Container(
                  padding: EdgeInsets.only(top:20,left:8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorList[index+sourceTiles.length],
                  ), 
                  child:Text(
                    allTiles[index],

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 0.7
                  ),), 
                ),
              ),
            );
          },
          childCount: allTiles.length
          ),

        )
    ],);
  }
}