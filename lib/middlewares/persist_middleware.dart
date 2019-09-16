
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sbaclean/actions/feed_actions.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/anomaly_details_actions.dart';

import 'persist_helper.dart';

Api api = Api();

List<Middleware<AppState>> persistMiddleware() {
  return [
    TypedMiddleware<AppState, FinishGetAnomaliesAction>(persist()),
//    TypedMiddleware<AppState, AddAnomalyAction>(addAnomaly()),
//    TypedMiddleware<AppState, GetUserReactionAction>(getReactions()),
//    TypedMiddleware<AppState, SetReactionAction>(setReaction()),
//    TypedMiddleware<AppState, DeleteReactionAction>(deleteReaction()),
//    TypedMiddleware<AppState, UpdateReactionAction>(updateReaction()),
//    TypedMiddleware<AppState, RefreshAnomaliesAction>(refreshAnomalies()),
    TypedMiddleware<AppState, GetUserPostReactionAction>(refreshPersist()),


  ];
}

persist() {
  return (Store<AppState> store, FinishGetAnomaliesAction action, NextDispatcher next) async {
    next(action);
    action.anomalies.sort((anomaly,anomaly1)=> anomaly1.post.id.compareTo(anomaly.post.id));
    int postId = action.anomalies[0].post.id;
    saveId(postId);
  };

}

refreshPersist() {
  return (Store<AppState> store, GetUserPostReactionAction action, NextDispatcher next) async {
    next(action);
    int postId = action.anomaly.post.id;
    saveId(postId);

    print(postId);
  };

}
