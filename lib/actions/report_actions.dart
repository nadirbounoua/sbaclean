import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/store/app_state.dart';

import '../models/report.dart';
import '../backend/api.dart';
import '../backend/utils.dart';
import 'dart:async';


Api api = Api();


final Function addReport = (BuildContext context,token,report) {
  Api api = Api();
  print("test");
  return (Store<AppState> store) async{
    final responseReport = await api.createReport(token, report);
    store.dispatch(new AddReportAction(report));
  };
};

class AddReportAction {
  final Report report;
  AddReportAction(this.report);
}



final Function getReport = (BuildContext context,String user_id) {
  Api api = Api();
  print('test');
  return (Store<AppState> store) async{
    final response = await api.getReport(user_id);
    List<Report> reports = parseReports(response);
    store.dispatch(new GetReportAction(reports));
  };
};

class GetReportAction {
  final List<Report> reports;
  GetReportAction(this.reports);
}

final Function checkAnomaly = (List<Report> reports,int anomaly_id) {
  bool reported = false;
  reports.forEach((f){
    if (int.parse(f.anomaly) == anomaly_id){
      reported = true;
    }
  });
  return reported;

};