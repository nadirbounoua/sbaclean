import 'package:sbaclean/actions/user_actions.dart';
//import '../redux/actions.dart';
import '../models/user.dart';
import '../models/anomaly.dart';
import 'dart:async';

class Comment {
  int commentOwner;
  int commentPost;
  String created_at;
  String commentContent;

  Comment({this.commentOwner,this.commentPost,this.created_at, this.commentContent});
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(commentOwner: json['comment_owner'] as int ,commentPost:json['post'] as int ,created_at: json['created_at'],commentContent: json['description'] as String);
  }
}

  //  GetUser getuser = new GetUser();
  //   GetAnomaly getanomaly = new GetAnomaly();
  //   final user = getuser.getUser(json['comment_owner']);
  //   final anomaly = getanomaly.getAnomaly(json['post']);

  //   print("-----------------1");

  //   user.then((value) {
  //     anomaly.then((value2) {
  //       commentPost = value2.title;
  //       commentContent = json['description'] as String;
  //     }, onError: print);
  //       commentOwner = value.first_name;
  //   }, o
