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



class AddEventsAction {
  final Event event;
  final BuildContext context;
  AddEventsAction({this.event, this.context});

}

class FinishAddEventsAction {
  final Event event;

  FinishAddEventsAction({this.event});

  
  ThunkAction<AppState> addEvent(BuildContext context) {
  return (Store<AppState> store) async {
    final response = await api.copyWith(store.state.auth.user.authToken)
                                  .createEvent(event, store.state.auth.user);
    Event parsedEvent = await parseOneEvent(response);
    Navigator.pop(context);
   Future.delayed(Duration(seconds: 5),() =>store.dispatch(new FinishAddEventsAction(event: parsedEvent))) ;
  };
  }
  
}


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
   store.dispatch(new FinishGetEventsAction(events: eventList));


  };
  }
}