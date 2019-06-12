import '../models/anomaly.dart';
import '../projectSettings.dart' as ProjectSettings;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'utils.dart';
import 'package:flutter/foundation.dart';



class Api {
  Future<List<Anomaly>> getPosts() async{
    var url = ProjectSettings.apiUrl+"/api/v1/posts/post/";
    var response = await http.get(url,
    headers: {HttpHeaders.authorizationHeader : "Token "+ProjectSettings.authToken});
    return compute(parsePost, response.body);
  }

  Future createPost(String title, String description, String longitude, String latitude) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/post/";
    var response = await http.post(url,
    body : {'title': title,'description': description, 'longitude': longitude, 'latitude':latitude, 'post_owner': "1",'city':'1' },
    headers: {HttpHeaders.authorizationHeader: "Token "+ProjectSettings.authToken}
    );

    return response;
  }

}