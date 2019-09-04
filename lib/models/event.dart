import 'package:sbaclean/backend/api.dart';
import '../backend/utils.dart';
import '../actions/event_actions.dart';

import '../models/post.dart';
import 'dart:convert';

class Event {
  int id;
  String approved_at;
  int max_participants;
  String description;
  String title;
  String starts_at;
  int approved_by;
  Post post;

  Event({
    this.id,
    this.approved_at,
    this.starts_at,
    this.post,
    this.description,
    this.title,
    this.max_participants,
    this.approved_by
  });

   factory Event.fromJson(Map<String,dynamic> json){
       
    return Event(
            id: json['event'][0]['id'] as int,
            approved_at: json['event'][0]['approved_at'] as String,
            starts_at: json['event'][0]['starts_at'] as String,
            max_participants: json['event'][0]['max_participants'] as int,
            approved_by: json['event'][0]['approved_by'] as int,
            );
  }

  factory Event.fromJsonPost(Map<String,dynamic> json){

    return Event(
      approved_at: json["approved_at"],
      starts_at: json["starts_at"],
      approved_by: json["approved_by"],
      max_participants: json["max_participants"],
    );
  }

  Event copyWith({Post post, int id}){
    return Event(
        id: id ?? this.id,
        max_participants: max_participants ?? this.max_participants,
        starts_at: starts_at ?? this.starts_at,
        approved_at: approved_at ?? this.approved_at,
        approved_by: approved_by ?? this.approved_by,
        post: post ?? this.post
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Event $description $title $max_participants";
  }

}