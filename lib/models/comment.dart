import '../redux/actions_user.dart';
import '../redux/actions.dart';
import '../models/user.dart';
import '../models/anomaly.dart';
import 'dart:async';

class Comment {
  int id;
  int commentOwner;
  int commentPost;
  String commentContent;

  Comment({this.id,this.commentOwner, this.commentPost, this.commentContent});
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment( id: json['id'],commentOwner: json['comment_owner'],commentPost: json['post'],commentContent: json['description'] as String);
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
