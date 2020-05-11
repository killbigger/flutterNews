import 'package:flutter/material.dart';


class SelectCountry extends StatefulWidget {
 final String selectedCountry;
  SelectCountry({
this.selectedCountry
  });

  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
String country;
@override
void initState() { 
  super.initState();
  setState(() {
    country=widget.selectedCountry;
  });
}
buildButton(String buttonText,String key){
  return  GestureDetector(
     onTap: (){
                 print('tapped');
                 setState(() {
                   country=key;
                   
                 });
               },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
               padding: EdgeInsets.symmetric(vertical:10,horizontal: 25),
               decoration:
                BoxDecoration(
                 color:country!=key?Color.fromRGBO(9, 8, 48, 0):Color.fromRGBO(213,126,81, 1),
                 borderRadius: BorderRadius.circular(20) 
                 ),
               
                 child:Text(buttonText,
                 style: TextStyle(
                   fontSize: 15,
                   color: country!=key?Color.fromRGBO(213,126,81, 1):Color.fromRGBO(9, 8, 48, 1)
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
        buildButton('India','in'),
         buildButton('USA','us'),
          buildButton('Canada','ca'),

           ],),
           Row(mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
        buildButton('United Kingdom','gb'),
         buildButton('UAE','ae'),

           ],),
            SizedBox(height: 80,),
           FlatButton(
             child: Text('Back',
             style: TextStyle(
               fontSize: 25,
               color: Color.fromRGBO(213,126,81, 1),
             ),), onPressed: () {
                   Navigator.pop(context,country);
             },
           )
        
         ],) ,);
    
  }
}