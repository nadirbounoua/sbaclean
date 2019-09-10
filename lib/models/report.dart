import '../backend/utils.dart';

import 'dart:convert';

class Report {
  String user;
  String anomaly;


  Report({
    this.user,
    this.anomaly

  });

  factory Report.fromJson(Map<String,dynamic> json){

    return Report(
      user: json["user"].toString(),
      anomaly: json["anomaly"].toString(),

    );
  }



}