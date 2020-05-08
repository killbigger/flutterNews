import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsilise/explore.dart';
import 'package:newsilise/home.dart';
import 'package:newsilise/inshort.dart';

class MainPage extends StatefulWidget {
  final String country;
  MainPage({
    this.country='in'
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  {
PageController pageController;
int currentPage=0;
  @override
  void initState() {
    
    super.initState();
    pageController = PageController(initialPage: 0);
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (pageIndex){
          setState(() {
            currentPage=pageIndex;
          });
        },
        children: <Widget>[
          Home(selectedCountry:'in'),
          Explore(),
          InShort(),
      ],),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Color.fromRGBO(34, 35, 39, 1),
        currentIndex:currentPage,
        onTap:(pIndex){
        pageController.animateToPage(pIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceInOut
         );
        },
        activeColor:Colors.white,
        items: [
          
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.explore,)),
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          ],
          ),
      
    );
  }
}