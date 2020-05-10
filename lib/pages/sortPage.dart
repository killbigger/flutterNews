import 'package:flutter/material.dart';
import 'package:newsilise/pages/resultPage.dart';

class SortPage extends StatefulWidget {
 final String category;
 final String q;
final bool    isEverything;
 final String source;
 final String sortBy;
  SortPage({
this.sortBy,
this.category,
this.q,
this.isEverything,
this.source,
  });

  @override
  _SortPageState createState() => _SortPageState();
}

class _SortPageState extends State<SortPage> {
String sortBy;
@override
void initState() { 
  super.initState();
  setState(() {
    this.sortBy=widget.sortBy;
  });
}
buildButton(String buttonText,String key){
  return  GestureDetector(
     onTap: (){
                 print('tapped');
                 setState(() {
                   sortBy=key;
                   print(sortBy);
                   print(key);
                 });
               },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
               padding: EdgeInsets.symmetric(vertical:10,horizontal: 25),
               decoration:
                BoxDecoration(
                 color:sortBy!=key?Color.fromRGBO(9, 8, 48, 0):Color.fromRGBO(213,126,81, 1),
                 borderRadius: BorderRadius.circular(20) 
                 ),
               
                 child:Text(buttonText,
                 style: TextStyle(
                   fontSize: 15,
                   color: sortBy!=key?Color.fromRGBO(213,126,81, 1):Color.fromRGBO(9, 8, 48, 1)
                 ),
                 ),
                
                 ),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         backgroundColor: Color.fromRGBO(9, 8, 48, 1),
         body:Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[

           Row(mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
        buildButton('relevancy','relevancy'),
         buildButton('popularity','popularity'),         
           ],),
           Row(mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
          buildButton('publishedAt','publishedAt'),
           ],),
            SizedBox(height: 80,),
           FlatButton(
             child: Text('Back',
             style: TextStyle(
               fontSize: 25,
               color: Color.fromRGBO(213,126,81, 1),
             ),), onPressed: () {
               
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                    return 
                    ResultPage(
                      source:widget.source,
                    isEverything: widget.isEverything,
                    sortBy:sortBy,
                    category:widget.category,
                    q:widget.q,
                                
                    );
                  }));
             },
           )
        
         ],) ,);
    
  }
}