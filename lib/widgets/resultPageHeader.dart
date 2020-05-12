import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newsilise/mainPage.dart';
import 'package:newsilise/pages/sortPage.dart';

 
class ResultPageHeader implements SliverPersistentHeaderDelegate {
final String category;
 final String q;
final bool isEverything;
 final String source;
 final String sortBy;
  ResultPageHeader({
    this.minExtent,
    @required this.maxExtent,
    this.sortBy,
    this.category,
   this.q,
  this.isEverything,
  this.source,
  });
  final double minExtent;
final double maxExtent;
TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    
    return Container(
      child: Stack(
          fit: StackFit.expand,
          children:<Widget>[
            Positioned(
              top: 11,
              left: 8,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 40,
                onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                        return MainPage(page:1);
                      }));
                },
              ),
            ),
            Center(child: Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: Text('NEWS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
                letterSpacing: 1
              ),
              ),
            ),),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[ 
                          GestureDetector(
                            onTap: (){
                             if(isEverything){
                               Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>SortPage(
                                sortBy:sortBy,
                                category:category,
                                q:q,
                                isEverything:isEverything,
                                source:source
                              )
                              ));
                             }
                                
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                 color:Color.fromRGBO(30, 215, 96, 1),
                              ),
                     width: 200,
                     height:60,
                     child: Center(child: Text(isEverything?'sort':'Top Headlines',
                     style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6
                     ),
                     ),),
                     
                    ),
                          ),
                   
                  
          ],
          ),
            
            
            //  Positioned(
            //   bottom: 0,
            //   child: Text('ssssss',style:TextStyle(color: Colors.black))),
          ] 
        ),
    );
    
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    
    return true;
  }

  @override
  
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

 
}