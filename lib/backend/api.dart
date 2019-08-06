import 'package:sbaclean/backend/utils.dart';

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
import 'package:sbaclean/models/post.dart';

class Api {
  String token ;

  Api copyWith(String token) {
    return Api(token: token ?? this.token);
  }
  Api({this.token});

  Future getPosts() async{
    var url = ProjectSettings.apiUrl+"/api/v1/posts/post/";
    var response = await http.get(url,
    headers: {HttpHeaders.authorizationHeader : "Token "+token});
    return response.body;
  }

  Future createPost(Post post, User user) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/post/";
    var response = await http.post(url,
    body : {'title': post.title,'description': post.description, 
    'longitude': post.longitude, 'latitude':post.latitude, 
    'post_owner': user.id,'city':'1', 'image':post.imageUrl},    
    headers: {HttpHeaders.authorizationHeader: "Token "+token}
    );
    print(response.body);
    return response.body;
}

Future createAnomaly(Post post, User user) async {
  String responseBody = await createPost(post, user);
  Post preAnomaly = parseOnePost(responseBody);
  var url = ProjectSettings.apiUrl + "/api/v1/anomalys/";
  var response = await http.post(url,
    body: {"post": preAnomaly.id.toString()},
    headers: {HttpHeaders.authorizationHeader: "Token" + token}
  );
  return {"response":response.body,"post":preAnomaly};
}

Future getAnomalies() async {
    var url = ProjectSettings.apiUrl+"/api/v1/posts/post/?anomaly";
    var response = await http.get(url,
    headers: {HttpHeaders.authorizationHeader : "Token "+token});
    return response.body;
}

Future getComments() async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/comment";
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Token " + token
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
    var url = ProjectSettings.apiUrl+"/api/v1/posts/post/?anomaly=$query";
    var response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: "Token "+token});
    return response.body;

  }

  Future checkNewPosts(FeedState state) async {
    String count = state.anomalies.length.toString();
    print("Tokeen $token");
    var url = ProjectSettings.apiUrl + "/api/v1/mobile/check_new_posts/";
    var response = await http.post(url,
    body: {'count':count},
    headers: {HttpHeaders.authorizationHeader: "Token "+token}
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
      HttpHeaders.authorizationHeader: "Token " + token
    });
    return response;
  }

  Future getUsers() async {
    var url = ProjectSettings.apiUrl + "/api/v1/accounts/";
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Token " + token
    });
    return response.body;
  }

  Future getComment(int id) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/comment/$id";
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Token " + token
    });
    return response.body;
  }

  Future getUser(int id) async {
    var url = ProjectSettings.apiUrl + "/api/v1/accounts/$id";
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Token " + token
    });
    return response.body;
  }

  Future createUser(User user) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/post/";
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: "Token " + token
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
      headers: {HttpHeaders.authorizationHeader: "Token "+token}
    );
    Map<String, dynamic> responseJson = json.decode(response.body);
    return responseJson;

  }

  Future deleteReaction(Reaction reaction) async {
    var url = ProjectSettings.apiUrl + '/api/v1/posts/reaction/'+ reaction.id.toString();
    var response = await http.delete(url,
      headers: {HttpHeaders.authorizationHeader: "Token "+token}

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
      headers: {HttpHeaders.authorizationHeader: "Token "+token}
    );
    Map<String, dynamic> responseJson = json.decode(response.body);
    return responseJson;
  }

  Future getUserReaction(int userId) async {
    print(token);
    var url = ProjectSettings.apiUrl + '/api/v1/posts/reaction/user/'+ userId.toString();
    var response = await http.get(url,
    headers: {HttpHeaders.authorizationHeader: "Token "+token}
    
    );
    return response.body;
  }

  Future getUserAnomaliesHistory(String userId) async {
    var url = ProjectSettings.apiUrl + '/api/v1/posts/post/?anomalyOwner=$userId';
    var response = await http.get(url,
      headers: {HttpHeaders.authorizationHeader: "Token "+token}
    );

    return response.body;
  }
}

