import '../models/anomaly.dart';
import '../projectSettings.dart' as ProjectSettings;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import '../models/comment.dart';
import '../models/user.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:learning2/models/app_state.dart';
import 'package:redux/redux.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';

class Api {
  Future getPosts() async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/post/";
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Token " + ProjectSettings.authToken
    });
    return response.body;
  }

  Future createPost(Anomaly anomaly) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/post/";
    var response = await http.post(url,
    body : {'title': anomaly.title,'description': anomaly.description, 'longitude': anomaly.longitude, 'latitude':anomaly.latitude, 'post_owner': "1",'city':'1', 'image':anomaly.imageUrl},
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

  Future checkNewPosts(Store<AppState> store) async {
    String count = store.state.anomalies.length.toString();
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
      'post': "1",
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

  Future getAnomaly(int id) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/post/$id";
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Token " + ProjectSettings.authToken
    });
    return response.body;
  }
}
