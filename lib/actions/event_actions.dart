import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/store/app_state.dart';

import '../models/event.dart';
import '../backend/api.dart';
import '../backend/utils.dart';
import 'dart:async';
import '../models/post.dart';

Api api = Api();

final Function postEvent = (BuildContext context,token,title,description,user,max,starts_at) {
  Api api = Api();
      api.createEvent(token,title,description,user,max,starts_at);

};



class GetEventsAction {
  final List<Event> events;

  GetEventsAction({this.events});


}

class FinishGetEventsAction {
  final List<Event> events;

  FinishGetEventsAction({this.events});

  
  ThunkAction<AppState> getEvents() {
  return (Store<AppState> store) async {
    final response = await api.copyWith(store.state.auth.user.authToken)
                                  .getEvents();
    List<Event> eventList = await parseEvents(response);
    //final response = await api.getPosts();
   Future.delayed(Duration(seconds: 3),() =>store.dispatch(new FinishGetEventsAction(events: eventList))) ;

    //store.dispatch(new GetAnomaliesAction([]).getAnomalies());

  };
  }
}