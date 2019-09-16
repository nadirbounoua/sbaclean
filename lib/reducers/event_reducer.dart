import 'package:redux/redux.dart';

import '../models/event.dart';
import '../store/event_state.dart';
import '../actions/event_actions.dart';

Reducer<EventState> eventReducer = combineReducers([
  new TypedReducer<EventState, FinishGetEventsAction>(finishGetEvents),
  new TypedReducer<EventState, GetEventsAction>(getEvents),
  new TypedReducer<EventState, FinishGetEventsAction>(finishGetEventsContent),
  new TypedReducer<EventState, AddEventsAction>(addItem),
  new TypedReducer<EventState, FinishAddEventsAction>(finishAddItem),
  new TypedReducer<EventState, RemoveEventAction>(removeEventReducer)



]);

EventState getEvents(EventState state, GetEventsAction action) {
  print("reducer" + true.toString());
  return state.copyWith(isEventsLoading: true);
}

EventState finishGetEventsContent(EventState state, FinishGetEventsAction action) {
  print("reducer" + action.events.toString());
  return state.copyWith(events: action.events
                              ..sort((event,event1) => event1.id.compareTo(event.id))
  );
}

EventState finishGetEvents(EventState state, FinishGetEventsAction action) {
  print("reducer" + false.toString());
  return state.copyWith(isEventsLoading: false);
}

EventState addItem(EventState state, AddEventsAction action) {
  
  return state.copyWith(isPostingEvent: true);
}

EventState finishAddItem(EventState state, FinishAddEventsAction action) {
  List<Event> list = List.from(state.events)
                ..add(action.event)
                ..sort((event,event1) => event1.id.compareTo(event.id));
  return state.copyWith(events: list, isPostingEvent: false);
}

EventState removeEventReducer(EventState state, RemoveEventAction action) {
  List<Event> list = state.events;
  list.remove(action.event);
  return state.copyWith(events: list);
}

