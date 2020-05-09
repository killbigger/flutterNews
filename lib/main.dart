import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newsilise/mainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        scaffoldBackgroundColor: Colors.black,
   
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
 @override
 void initState() { 
   super.initState();
   Timer(
     Duration(seconds: 3),(){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(country: 'in',)));
     }

   );
 }
  @override
  Widget build(BuildContext context) {
 return Scaffold(
      body:Container(
        height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width ,
        color: Color(0xFF081818),
        child: Stack(
          children: <Widget>[
            Center(
                 child:Container(
                  height:150,
                  width: 150,
                  decoration:BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image:AssetImage('assets/images/logo.png'),
                    fit: BoxFit.cover
                    )
                  ), 
                ), 
            ),
            
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:500.0),
                child: Container(child:Text('powered by newsapi.org',
                style: TextStyle(
                  color: Color(0xFF7A9AC1),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),),
                ),
              ),
            )
          ],),
      ),
    );
}

}
