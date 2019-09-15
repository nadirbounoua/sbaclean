import '../backend/utils.dart';

import 'dart:convert';

class Participation {
  String id;
  String user;
  String event;


  Participation({
    this.id,
    this.user,
    this.event,

  });

  factory Participation.fromJson(Map<String,dynamic> json){

    return Participation(
        id: json["id"].toString(),
        user: json["user"].toString(),
        event: json["event"].toString(),

    );
  }



}