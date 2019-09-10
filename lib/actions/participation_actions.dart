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



final Function getParticipations = (BuildContext context,String event_id) {
  Api api = Api();
  return (Store<AppState> store) async{
    final response = await api.getParticipations(event_id);
    List<Participation> participations = parseParticipations(response);
    store.dispatch(new GetParticipationsAction(participations));
  };
};

class GetParticipationsAction {
  final List<Participation> participations;
  GetParticipationsAction(this.participations);
}