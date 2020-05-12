import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsilise/widgets/progress.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  final String url;
  WebPage(
    {
      this.url
    }
  );
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  bool loading;
  final Completer<WebViewController> _controller =Completer<WebViewController>();
  @override
  void initState() {
    loading=true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(children: <Widget>[
              WebView(
                    initialUrl: widget.url,
                    onPageFinished: (e){
                       setState(() {
                        loading=false;
                      });
                    },
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController){
                      _controller.complete(webViewController);
                    },
                    ),
                    
                 loading?Container(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator(),
                )
              : Container(
                  color: Colors.transparent,
                ),
      ],),
      
      floatingActionButton:FutureBuilder<WebViewController>(
        future:_controller.future ,
        builder: (BuildContext context,AsyncSnapshot<WebViewController> controller){
          if(controller.hasData){
              return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:30),
                  child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.arrow_back_ios,
                    
                    ),
                    onPressed: (){
                      controller.data.goBack();
                    },
                  ),),
                FloatingActionButton(
                   backgroundColor: Colors.black,
                  child: Icon(Icons.search,
                   
                  ),
                  onPressed: (){
                    controller.data.loadUrl('https://www.google.com/');
                  },
                ),
                 FloatingActionButton(
                   backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_forward_ios,
                   
                  ),
                  onPressed: (){
                    controller.data.goForward();
                  },
                )
            ],
            );
          } 
        },
        )
    );
  }
}