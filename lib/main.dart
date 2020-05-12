
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newsilise/mainPage.dart';
import 'package:splashscreen/splashscreen.dart';

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
  Widget build(BuildContext context) {
   
 return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new MainPage(),
      title: new Text('News',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),
      ),
      image: new Image.asset('assets/images/logo.png'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
}

}
