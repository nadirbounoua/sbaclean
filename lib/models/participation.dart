import '../backend/utils.dart';

import 'dart:convert';

class Participation {
  String user;
  String event;


  Participation({
    this.user,
    this.event,

  });

  factory Participation.fromJson(Map<String,dynamic> json){

    return Participation(
        user: json["user"].toString(),
        event: json["event"].toString(),

    );
  }



}