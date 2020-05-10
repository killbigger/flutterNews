import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newsilise/models/news_headlinesandeverything.dart';




class Search {
  
  String sortBy;
  String sources;
  String q;
  Search({
   this.sortBy='',
   this.sources='',
   this.q='', 
  });
  
  Future<List<NewsAll>> getNews () async{
    String newsApi='';
    if(q!=''&&sources!=''){
      newsApi='https://newsapi.org/v2/everything?q=$q&sources=$sources&language=en&apiKey=5f913179c6314d77bed28a9ca3e37e4f';
    } else if(q!=''){
      newsApi='https://newsapi.org/v2/everything?q=$q&language=en&apiKey=5f913179c6314d77bed28a9ca3e37e4f';
    } else if(sources!=''){
      newsApi='https://newsapi.org/v2/everything?sources=$sources&language=en&apiKey=5f913179c6314d77bed28a9ca3e37e4f';
    }
 final response = await http.get(newsApi);
 if(response.statusCode==200){
   Map<String,dynamic> body = json.decode(response.body);
  //  print(body['articles']);
   List<NewsAll> news=[];
   body['articles'].forEach((article){
NewsAll newsAll = NewsAll.fromJson(article);
news.add(newsAll);
   });
    return news;
 }
 else {
   throw Exception('Failed to Retrieve News');
   
 }

  }
}