import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/models/post.dart'; 
import 'dart:convert';
 class Anomaly {

  int id;
  Post post;
  
  Anomaly({
           this.id, 
           this.post
  });

  factory Anomaly.fromJson(Map<String,dynamic> json){

    return Anomaly(
            id:json['anomaly'][0]['id'] as int,

            );
  }

    factory Anomaly.fromJsonPost(Map<String,dynamic> json){

    return Anomaly(
            id:json['id'] as int,

            );
  }

  Anomaly copyWith({Post post, int id}){
    return Anomaly(
      id: id ?? this.id,
      post: post ?? this.post
    );
  }

  @override
    String toString() {
      // TODO: implement toString
      return "Anomaly $id ";
    }
}