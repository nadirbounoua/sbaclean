import '../models/anomaly.dart';
import 'package:learning2/models/reaction.dart';
import '../projectSettings.dart' as ProjectSettings;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:learning2/models/app_state.dart';
import 'package:redux/redux.dart';
import 'dart:convert';

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
    body : {'title': anomaly.title,'description': anomaly.description, 'longitude': anomaly.longitude, 'latitude':anomaly.latitude, 'post_owner': "1",'city':'1' },
    headers: {HttpHeaders.authorizationHeader: "Token "+ProjectSettings.authToken}
    );

    return response;
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
    print(responseJson);
    return responseJson;

  }

  Future deleteReaction(Reaction reaction) async {
    var url = ProjectSettings.apiUrl + '/api/v1/posts/reaction/'+ reaction.id.toString();
    var response = await http.delete(url,
      headers: {HttpHeaders.authorizationHeader: "Token "+ProjectSettings.authToken}

    );

    return response.statusCode;
  }
}