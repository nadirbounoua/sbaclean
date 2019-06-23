import '../models/anomaly.dart';
import '../projectSettings.dart' as ProjectSettings;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';


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

}