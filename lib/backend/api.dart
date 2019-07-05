import '../models/anomaly.dart';
import '../projectSettings.dart' as ProjectSettings;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import '../models/comment.dart';
import '../models/user.dart';


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

  Future getComments() async{
    var url = ProjectSettings.apiUrl+"/api/v1/posts/comment/";
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader : "Token "+ProjectSettings.authToken});
    return response.body;
  }

  Future createComment(Comment comment) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/comment/";
    var response = await http.post(url,
        body : {'comment_owner': comment.commentOwner,'post': comment.commentPost, 'description': comment.commentContent},
        headers: {HttpHeaders.authorizationHeader: "Token "+ProjectSettings.authToken}
    );

    return response;
  }
    Future getUsers() async{
    var url = ProjectSettings.apiUrl+"/api/v1/accounts/";
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader : "Token "+ProjectSettings.authToken});
    return response.body;
  }
   Future getComment(int id) async{
    var url = ProjectSettings.apiUrl+"/api/v1/posts/comment/$id";
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader : "Token "+ProjectSettings.authToken});
    return response.body;
  }

  Future getUser(int id) async{
    var url = ProjectSettings.apiUrl+"/api/v1/accounts/$id";
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader : "Token "+ProjectSettings.authToken});
    return response.body;
  }

  Future createUser(User user) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/post/";
    var response = await http.post(url,
    //body : {'title': anomaly.title,'description': anomaly.description, 'longitude': anomaly.longitude, 'latitude':anomaly.latitude, 'post_owner': "1",'city':'1' },
    headers: {HttpHeaders.authorizationHeader: "Token "+ProjectSettings.authToken}
    );
  }
  Future getAnomaly(int id) async{
    var url = ProjectSettings.apiUrl+"/api/v1/posts/post/$id";
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader : "Token "+ProjectSettings.authToken});
    return response.body;
  }
}