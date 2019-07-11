import '../models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import '../projectSettings.dart' as ProjectSettings;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:sbaclean/store/feed_state.dart';
import 'package:redux/redux.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:sbaclean/models/user.dart';
import 'package:sbaclean/models/comment.dart';
class Api {
  Future getPosts() async{
    var url = ProjectSettings.apiUrl+"/api/v1/posts/post/";
    var response = await http.get(url,
    headers: {HttpHeaders.authorizationHeader : "Token "+ProjectSettings.authToken});
    return response.body;
  }

  Future createPost(Anomaly anomaly) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/post/";
    var response = await http.post(url,
    body : {'title': anomaly.title,'description': anomaly.description, 
    'longitude': anomaly.longitude, 'latitude':anomaly.latitude, 
    'post_owner': "1",'city':'1', 'image':anomaly.imageUrl},    
    headers: {HttpHeaders.authorizationHeader: "Token "+ProjectSettings.authToken}
    );

    return response;
  }
Future getComments() async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/comment";
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Token " + ProjectSettings.authToken
    });
    return response.body;
  }
  Future upload(File imageFile) async {    
      // open a bytestream
      var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      // get file length
      var length = await imageFile.length();

      // string to uri
      var uri = Uri.parse(ProjectSettings.imageServer);

      // create multipart request
      var request = new http.MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFile = new http.MultipartFile('image', stream, length,
          filename: basename(imageFile.path));

      // add file to multipart
      request.files.add(multipartFile);

      // send
      print(length);
      var response = await request.send();
      print(response.statusCode);

      // listen for response
      String val= "a";
      await response.stream.transform(utf8.decoder).listen((value) {
        //print(value);
        val = value;
      });
      var jsonResponse =  json.decode(val);
    
      return jsonResponse['url'];
  }

  Future queryPosts(String query) async {
    var url = ProjectSettings.apiUrl+"/api/v1/posts/post/?q=$query";
    var response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: "Token "+ProjectSettings.authToken});
    return response.body;

  }

  Future checkNewPosts(FeedState state) async {
    String count = state.anomalies.length.toString();
    print(count);
    var url = ProjectSettings.apiUrl + "/api/v1/mobile/check_new_posts/";
    var response = await http.post(url,
    body: {'count':count},
    headers: {HttpHeaders.authorizationHeader: "Token "+ProjectSettings.authToken}
    );
    Map<String, dynamic> responseJson = json.decode(response.body);
    return responseJson['changed'];

  }

  Future createComment(Comment comment) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/comment/";
    var response = await http.post(url, body: {
      'comment_owner': "1",
      'post': "23",
      'description': comment.commentContent
    }, headers: {
      HttpHeaders.authorizationHeader: "Token " + ProjectSettings.authToken
    });
    return response;
  }

  Future getUsers() async {
    var url = ProjectSettings.apiUrl + "/api/v1/accounts/";
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Token " + ProjectSettings.authToken
    });
    return response.body;
  }

  Future getComment(int id) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/comment/$id";
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Token " + ProjectSettings.authToken
    });
    return response.body;
  }

  Future getUser(int id) async {
    var url = ProjectSettings.apiUrl + "/api/v1/accounts/$id";
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Token " + ProjectSettings.authToken
    });
    return response.body;
  }

  Future createUser(User user) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/post/";
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: "Token " + ProjectSettings.authToken
    });
}

  Future setReactionPost(Anomaly anomaly,Reaction reaction) async {
    print("API" + reaction.toString());

    var url = ProjectSettings.apiUrl + '/api/v1/posts/reaction/';
    var response = await http.post(url,
      body: {'post' : reaction.post.toString(), 
            'reaction_owner': reaction.reactionOwner.toString(), 
            'is_like': reaction.isLike.toString()
            },
      headers: {HttpHeaders.authorizationHeader: "Token "+ProjectSettings.authToken}
    );
    Map<String, dynamic> responseJson = json.decode(response.body);
    return responseJson;

  }

  Future deleteReaction(Reaction reaction) async {
    var url = ProjectSettings.apiUrl + '/api/v1/posts/reaction/'+ reaction.id.toString();
    var response = await http.delete(url,
      headers: {HttpHeaders.authorizationHeader: "Token "+ProjectSettings.authToken}

    );

    return response.statusCode;
  }

  Future updateReaction(Reaction reaction) async {
    var url = ProjectSettings.apiUrl + '/api/v1/posts/reaction/'+ reaction.id.toString();
    var response = await http.put(url,
      body: {'post' : reaction.post.toString(), 
            'reaction_owner': reaction.reactionOwner.toString(), 
            'is_like': reaction.isLike.toString()
            },
      headers: {HttpHeaders.authorizationHeader: "Token "+ProjectSettings.authToken}
    );
    Map<String, dynamic> responseJson = json.decode(response.body);
    return responseJson;
  }

  Future getUserReaction(int userId) async {
    var url = ProjectSettings.apiUrl + '/api/v1/posts/reaction/user/'+ userId.toString();
    var response = await http.get(url,
    headers: {HttpHeaders.authorizationHeader: "Token "+ProjectSettings.authToken}
    
    );
    return response.body;
  }

  Future getUserAnomaliesHistory(String userId) async {
    var url = ProjectSettings.apiUrl + '/api/v1/posts/post?owner=$userId';
    var response = await http.get(url,
      headers: {HttpHeaders.authorizationHeader: "Token "+ProjectSettings.authToken}
    );

    return response.body;
  }
}

