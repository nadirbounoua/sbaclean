import 'package:flutter/material.dart';
import 'main.dart';
import 'settings.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'projectSettings.dart' as ProjectSettings;
void main() => runApp(Feed());
  String apiUrl = 'http://192.168.1.119:7000';
  String authToken = "485d5e2f79512be1280a9f82b8b95c3ecb934bf4" ;

class Feed extends StatelessWidget {
  static const String _title = 'Signalements';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                semanticLabel: 'settings',
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
              },
            )
          ],
        ),
        body: FutureBuilder<List<Post>>(
          future: getPosts(),
          builder: (context,snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
              ? PostList(posts: snapshot.data)
              : Center(child: CircularProgressIndicator());
        
          },
        ),
      ),
    );
  }
}

Future<List<Post>> getPosts() async{
  var url = ProjectSettings.apiUrl+"/api/v1/posts/post/";
  var response = await http.get(url,
  headers: {HttpHeaders.authorizationHeader : "Token "+ProjectSettings.authToken});
  return compute(parsePost, response.body);
}


List<Post> parsePost(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    
    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}
class PostList extends StatelessWidget {
  final List<Post> posts;

  PostList({Key key, this.posts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostPreview(description: posts[index].description, title: posts[index].title);
        },
      );
  }
}

class Post {
  String title;
  String description;

  Post({this.title, this.description});

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(description: json['description'] as String,title: json['title'] as String);
  }

}

class PostPreview extends StatelessWidget {
  String title;
  String description;
  PostPreview({Key key,  this.title, this.description}) : super(key: key);     

  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                  decoration: new BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1))
                  ),
                  child: Icon(
                    Icons.image,
                    size: 100,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(title
                      ,
                      style: new TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Text(description),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      padding: EdgeInsets.only(left: 10),
                      textColor: Colors.grey,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.comment,
                            size: 25,
                            color: Colors.grey,
                          ),
                          Container(
                            child: Text('124 Commentaires'),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                      },
                    ),
                  ),
                  Text(
                    "2493",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_up, color: Colors.blue),
                      onPressed: () {/* ... */},
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      onPressed: () {/* ... */},
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

}