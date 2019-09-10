import '../backend/utils.dart';
import '../actions/event_actions.dart';

import '../models/post.dart';
import 'dart:convert';

class City {
  String id;
  String zip_code;
  String name;


  City({
    this.id,
    this.zip_code,
    this.name,

  });

  factory City.fromJson(Map<String,dynamic> json){

    return City(
      id: json["id"].toString(),
      zip_code: json["zip_code"].toString(),
      name: json["name"].toString()

    );
  }



}