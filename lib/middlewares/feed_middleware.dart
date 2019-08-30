import 'package:redux/redux.dart';
import 'dart:convert';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/actions/feed_actions.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/middlewares/feed_helper.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/store/app_state.dart';

Api api = Api();
List<Anomaly> anomalyList;

List<Middleware<AppState>> feedMiddleware() {
  return [
    TypedMiddleware<AppState, GetAnomaliesAction>(loadAnomalies()),
    TypedMiddleware<AppState, AddAnomalyAction>(addAnomaly())
  ];
}

loadAnomalies() {
  return (Store<AppState> store, GetAnomaliesAction action, NextDispatcher next) {
    next(action);
    api.copyWith(store.state.userState.user.authToken)
        .getAnomalies()
          .then((anomalies) => {
              getAnomalies(store, anomalies)
          });
  };
}

addAnomaly() {
  return (Store<AppState> store, AddAnomalyAction action, NextDispatcher next) {
    next(action);
    api.copyWith(store.state.userState.user.authToken)
        .createAnomaly(action.post, action.user)
          .then((response) => {
              addAnomalyHelper(store, response, action.post)
          });
  };
}