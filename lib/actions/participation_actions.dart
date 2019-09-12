import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../models/participation.dart';
import '../backend/api.dart';
import '../backend/utils.dart';
import 'dart:async';
import '../store/app_state.dart';

Api api = Api();


final Function addParticipation = (BuildContext context,token,participation) {
  Api api = Api();
  return (Store<AppState> store) async{
    final responseParticipation = await api.createParticipation(token, participation);
    store.dispatch(new AddParticipationAction(participation));
  };
};

class AddParticipationAction {
  final Participation participation;
  AddParticipationAction(this.participation);
}



final Function getParticipations = (BuildContext context) {
  Api api = Api();
  return (Store<AppState> store) async{
    final response = await api.getParticipations();
    List<Participation> participations = parseParticipations(response);
    store.dispatch(new GetParticipationsAction(participations));
  };
};

class GetParticipationsAction {
  final List<Participation> participations;
  GetParticipationsAction(this.participations);
}

final Function getParticipationsEvent = (List<Participation> participations,String event_id) {
  List<Participation> list = new List<Participation>();
  participations.forEach((f){
    if (int.parse(f.event) == int.parse(event_id)){
      list.add(f);
    }
  });
  return list;

};

final Function checkEvent = (List<Participation> participations,String user_id) {
  bool closed = false;
  participations.forEach((f){
    if (int.parse(f.user) == int.parse(user_id)){
      closed = true;
    }
  });
  return closed;

};