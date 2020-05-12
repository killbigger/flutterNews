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
  final Completer<WebViewController> _controller =Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
      ),
      body: WebView(
       initialUrl: widget.url,
       
       javascriptMode: JavascriptMode.unrestricted,
       onWebViewCreated: (WebViewController webViewController){
         _controller.complete(webViewController);
       },
      ),
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
          } else {
return circularProgress();
          } 
        },
        )
    );
  }
}