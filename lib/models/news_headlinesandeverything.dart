class NewsAll {

  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  String api;
  
  NewsAll({

  this.author,
  this.title,
  this.description,
  this.url,
  this.urlToImage,
  this.publishedAt,
  this.content,
  });

  factory NewsAll.fromJson(Map<String,dynamic> json) {
    return NewsAll(
  
  author:json['author'],
  title:json['title'],
  description:json['description'],
  url:json['url'],
  urlToImage:json['urlToImage'],
  publishedAt:json['publishedAt'],
  content:json['content'],
  
    );
  }
  Map toJson() => {
        'author':author ,
        'title': title,
        'description':description,
        'url':url,
        'urlToImage':urlToImage,
        'publishedAt':publishedAt,
        'content':content

      };

}