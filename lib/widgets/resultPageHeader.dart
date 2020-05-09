import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

 
class ResultPageHeader implements SliverPersistentHeaderDelegate {

  ResultPageHeader({
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
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                               color:Color.fromRGBO(30, 215, 96, 1),
                            ),
                     width: 200,
                     height:60,
                     child: Center(child: Text('sort',
                     style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6
                     ),
                     ),),
                     
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