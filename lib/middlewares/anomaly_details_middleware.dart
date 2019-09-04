import 'package:redux/redux.dart';
import 'package:sbaclean/actions/anomaly_details_actions.dart';
import 'dart:convert';
import 'package:sbaclean/actions/feed_actions.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/middlewares/anomaly_details_helper.dart';
import 'package:sbaclean/middlewares/feed_helper.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/store/app_state.dart';

Api api = Api();

List<Middleware<AppState>> anomalyDetailsMiddleware() {
  return [
    TypedMiddleware<AppState, GetCommentsAction>(getComments()),
    TypedMiddleware<AppState, AddCommentAction>(addComment()),


  ];
}

getComments() {
  return (Store<AppState> store, GetCommentsAction action, NextDispatcher next) async {
    next(action);
    await api.copyWith(store.state.auth.user.authToken)
          .getComments(action.postId)
            .then((response) {
                getCommentsHelper(store, response);
            });
  };
}

addComment() {
  return (Store<AppState> store, AddCommentAction action, NextDispatcher next) async {
    next(action);
    await api.copyWith(store.state.auth.user.authToken)
              .createComment(action.item)
                .then((response) {
                  print(response);
                  addCommentHelper(store, response);
              });
  };
}