import 'package:redux/redux.dart';

import '../models/event.dart';
import '../store/event_state.dart';
import '../actions/event_actions.dart';

Reducer<EventState> eventReducer = combineReducers([
    new TypedReducer<EventState, FinishGetEventsAction>(finishGetEvents),
    new TypedReducer<EventState, GetEventsAction>(getEvents),

  new TypedReducer<EventState, FinishGetEventsAction>(finishGetEventsContent),

  //new TypedReducer<EventState, AddEventAction>(addItem),

]);

EventState getEvents(EventState state, GetEventsAction action) {
  print("reducer" + true.toString());
  return state.copyWith(isEventsLoading: true);
}

EventState finishGetEventsContent(EventState state, FinishGetEventsAction action) {
  print("reducer" + action.events.toString());
  return state.copyWith(events: action.events);
}

EventState finishGetEvents(EventState state, FinishGetEventsAction action) {
  print("reducer" + false.toString());
  return state.copyWith(isEventsLoading: false);
}
/*
EventState addItem(EventState state, AddEventAction action) {
  var list = List.from(state.events)..add(action.event);
  print(list);
  return state.copyWith(events: List.from(state.events)..add(action.event));
}*/

