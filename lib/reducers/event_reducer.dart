import 'package:redux/redux.dart';

import '../models/event.dart';
import '../store/event_state.dart';
import '../actions/event_actions.dart';

Reducer<EventState> eventReducer = combineReducers([
  new TypedReducer<EventState, GetEventsAction>(getEvents),
  //new TypedReducer<EventState, AddEventAction>(addItem),

]);

EventState getEvents(EventState state, GetEventsAction action) {
  print("reducer" + action.events.toString());
  return state.copyWith(events: action.events);
}
/*
EventState addItem(EventState state, AddEventAction action) {
  var list = List.from(state.events)..add(action.event);
  print(list);
  return state.copyWith(events: List.from(state.events)..add(action.event));
}*/

