import 'package:redux/redux.dart';
import 'dart:convert';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/actions/event_actions.dart';
import 'package:sbaclean/actions/feed_actions.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/middlewares/feed_helper.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/store/event_state.dart';

Api api = Api();

List<Middleware<AppState>> eventMiddleware() {
  return [
    TypedMiddleware<AppState, GetEventsAction>(getEvents()),
    TypedMiddleware<AppState, AddEventsAction>(addEvents()),



  ];
}

getEvents() {
  return (Store<AppState> store, GetEventsAction action, NextDispatcher next) async {
    next(action);
    store.dispatch(FinishGetEventsAction(events: []).getEvents());

  };
}

addEvents() {
  return (Store<AppState> store, AddEventsAction action, NextDispatcher next) async {
    next(action);
    var imageurl = await api.copyWith(store.state.auth.user.authToken).upload(store.state.postFeedState.image);
    action.event.post.imageUrl = imageurl;
    store.dispatch(FinishAddEventsAction(event: action.event).addEvent(action.context));

  };
}
