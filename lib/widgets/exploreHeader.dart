import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newsilise/pages/resultPage.dart';

 
class ExplorePageHeader implements SliverPersistentHeaderDelegate {

  ExplorePageHeader({
    this.minExtent,
    @required this.maxExtent,
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
           Container(
              decoration:BoxDecoration(
          gradient:LinearGradient(
            begin:Alignment.topLeft,
            end:Alignment.bottomRight,
            colors: [
              Colors.grey[200],
              Colors.black
            ]
          ) ),
            ),
            Center(child: Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: Text('Search',
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
                          Container(
                     width: 350,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black,
                        fontSize: 22),
                      controller: searchController,
                        decoration: InputDecoration( 
                        fillColor: Colors.white,
                        hintText:"Search..",
                        filled: true,
                        suffixIcon:IconButton(icon:Icon(Icons.clear),
                        onPressed:()=>searchController.clear(),
                        color: Colors.black,)
                      ),
                onFieldSubmitted:(query){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ResultPage(isEverything: true,q:query);
                      }));
                }
                      ),
                    ),
                    SizedBox(height: 10,)
                  
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