import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/event.dart';
import 'package:sbaclean/models/participation.dart';
import 'package:sbaclean/models/report.dart';

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
    'post_owner': user.id.toString(),'city':'1', 'image':post.imageUrl},    
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

Future getComments(String postId) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/comment?post=$postId";
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
      'comment_owner': comment.commentOwner.toString(),
      'post': comment.commentPost.toString(),
      'description': comment.commentContent,
      
    }, headers: {
      HttpHeaders.authorizationHeader: "Token " + token
    });
    return response.body;
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


//--------------------------------------------------------------------------------
  Future getToken(String username,String password) async {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    var url = ProjectSettings.apiUrl + "/api-token-auth/";
    var response = await http.post(url,body: map);
    return response.body;
  }

  Future addUser(String username,String first_name,String last_name,String phone_number,String city,String address, String email, String password) async {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    map["first_name"] = first_name;
    map["last_name"] = last_name;
    map["phone_number"] = phone_number;
    map["email"] = email;
    map["address"] = address;
    map["city"] = city;
    map["is_staff"] = '0';

    var url = ProjectSettings.apiUrl + "/api/v1/accounts/register/";
    var response = await http.post(url,body: map);
    return response.body;
  }

  Future getProfile(String username, String token) async {
    var url = ProjectSettings.apiUrl + '/api/v1/accounts?username='+ username;
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: "Token "+ token}
    );
    return response.body;
  }

  Future getUserByEmail(String email) async {
    var url = ProjectSettings.apiUrl + '/api/v1/accounts?email='+ email;
    var response = await http.get(url,
        
    );
    return response.body;
  }

  Future modifyPersonal(String id,String token,String first_name, String last_name,String phone_number,String address, String city) async {
    var map = new Map<String, dynamic>();
    map["first_name"] = first_name;
    map["last_name"] = last_name;
    map["phone_number"] = phone_number;
    map["address"] = address;
    map["city"] = city;
    map["is_staff"] = "0";
    var url = ProjectSettings.apiUrl + "/api/v1/accounts/$id";
    var response = await http.patch(url,body: map, headers: {HttpHeaders.authorizationHeader: "Token "+ token });
    return response.body;
  }

  Future modifyLogin(String id,String token,String username, String email,String password) async {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["email"] = email;
    map["password"] = password;
    map["is_staff"] = "0";
    var url = ProjectSettings.apiUrl + "/api/v1/accounts/$id";
    var response = await http.patch(url,body: map, headers: {HttpHeaders.authorizationHeader: "Token "+ token });
    return response.body;
  }

  Future createPostE(String token,String title,String description, String user) async {
    var url = ProjectSettings.apiUrl + "/api/v1/posts/post/";
    var response = await http.post(url,
        body : {'title': title,'description': description,
          'longitude': "2.3488", 'latitude':"48.8534",
          'post_owner': user,'city':'1'},
        headers: {HttpHeaders.authorizationHeader: "Token "+token}
    );
    print(response.body);
    return response.body;
  }



  Future createEvent(Event event, User user) async {
    String responseBody = await createPost(event.post, user);
    Post preEvent = parseOnePost(responseBody);
    var map = new Map<String, dynamic>();
    map["post"] = preEvent.id.toString();
    map["max_participants"] = event.max_participants.toString();
    map["starts_at"] = event.starts_at;
    var url = ProjectSettings.apiUrl + "/api/v1/events/";
    var response = await http.post(url,body: map,headers: {HttpHeaders.authorizationHeader: "Token "+ token}
    );
    return {"response":response.body,"post":preEvent};
  }

  Future getEvents() async {

    var url = ProjectSettings.apiUrl+"/api/v1/posts/post/?event";
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader : "Token "+ token});
    return response.body;
  }

  Future getUserEvents(String userId) async {

    var url = ProjectSettings.apiUrl+"/api/v1/posts/post/?eventOwner=$userId";
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader : "Token "+ token});
    return response.body;
  }

  Future getPost(int id) async {
    var url = ProjectSettings.apiUrl + '/api/v1/posts/post/$id';
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: "Token " + token}
    );
    return response.body;
  }

  Future getRanking(String cityId) async {
    print(cityId);
    var url = ProjectSettings.apiUrl+"/api/v1/accounts/ranking/?limit=5&city=$cityId";
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader : "Token "+ token});
    return response.body;
  }
  Future getCities() async {
    var url = ProjectSettings.apiUrl+"/api/v1/address/city/";
    var response = await http.get(url);
    return response.body;
  }

    Future createParticipation(String token,Participation participation) async {
    var map = new Map<String, dynamic>();
    map["user"] = participation.user;
    map["event"] = participation.event;
    var url = ProjectSettings.apiUrl + "/api/v1/events/participate/";
    var response = await http.post(url,body: map,headers: {HttpHeaders.authorizationHeader: "Token "+ token}
    );
    return response.body;
  }

  Future getParticipations() async {
    var url = ProjectSettings.apiUrl+"/api/v1/events/participate/";
    var response = await http.get(url);
    return response.body;
  }
  Future createReport(String token,Report report) async {
    var map = new Map<String, dynamic>();
    map["user"] = report.user;
    map["anomaly"] = report.anomaly;
    var url = ProjectSettings.apiUrl + "/api/v1/anomalys/signal/";
    var response = await http.post(url,body: map,headers: {HttpHeaders.authorizationHeader: "Token "+ token}
    );
    return response.body;
  }

  Future getReport(String user_id) async {
    var url = ProjectSettings.apiUrl+"/api/v1/anomalys/signal/?user=$user_id";
    var response = await http.get(url);
    return response.body;
  }
}

