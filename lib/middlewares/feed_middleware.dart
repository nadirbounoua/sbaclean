import 'package:redux/redux.dart';
import 'dart:convert';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/actions/feed_actions.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/middlewares/feed_helper.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/store/app_state.dart';

Api api = Api();

List<Middleware<AppState>> feedMiddleware() {
  return [
    TypedMiddleware<AppState, GetAnomaliesAction>(loadAnomalies()),
    TypedMiddleware<AppState, AddAnomalyAction>(addAnomaly()),
    TypedMiddleware<AppState, GetUserReactionAction>(getReactions()),
    TypedMiddleware<AppState, SetReactionAction>(setReaction()),
    TypedMiddleware<AppState, DeleteReactionAction>(deleteReaction()),
    TypedMiddleware<AppState, UpdateReactionAction>(updateReaction()),
    TypedMiddleware<AppState, RefreshAnomaliesAction>(refreshAnomalies()),



  ];
}

loadAnomalies() {
  return (Store<AppState> store, GetAnomaliesAction action, NextDispatcher next) async {
    next(action);
    await api.copyWith(store.state.auth.user.authToken)
        .getAnomalies()
          .then((anomalies) => {
              getAnomalies(store, anomalies)
          });
  };
}

addAnomaly() {
  return (Store<AppState> store, AddAnomalyAction action, NextDispatcher next) async {

    next(action);
    var imageurl = await api.upload(store.state.postFeedState.image);
    action.post.imageUrl = imageurl;
    await api.copyWith(store.state.auth.user.authToken)
        .createAnomaly(action.post, action.user)
          .then((response)  {
              print(response);
              addAnomalyHelper(store, response, action.post);
          });
  };
}

getReactions() {
  return (Store<AppState> store, GetUserReactionAction action, NextDispatcher next) async {
    next(action);
    await api.copyWith(store.state.auth.user.authToken)
        .getUserReaction(store.state.auth.user.id)
          .then((response) => getReactionsHelper(store, response)
    );
  };
}

setReaction() {
  return (Store<AppState> store, SetReactionAction action, NextDispatcher next) async {
    next(action);
    await api.copyWith(store.state.auth.user.authToken)
              .setReactionPost(action.anomaly, action.reaction)
                .then((response) {
                  setReactionHelper(store, response, action.anomaly);
    });
  };
}

deleteReaction() {
  return (Store<AppState> store, DeleteReactionAction action, NextDispatcher next) async {
    next(action);
    Reaction reaction = action.anomaly.post.userReaction;
    print(reaction);
    await api.copyWith(store.state.auth.user.authToken)
                  .deleteReaction(reaction)
                    .then((onValue) {
                      deleteReactionHelper(store, action.anomaly, reaction);
                    });
  };
}

updateReaction() {
  return (Store<AppState> store, UpdateReactionAction action, NextDispatcher next) async {
    next(action);
  
  Reaction reaction = action.anomaly.post.userReaction;
        reaction.isLike = !reaction.isLike;
        await  api.copyWith(store.state.auth.user.authToken)
                  .updateReaction(reaction)
                    .then((response) {
                      updateReactionHelper(store, response, action.anomaly, action.reaction);
                    });
  };
}

refreshAnomalies() {
    return (Store<AppState> store, RefreshAnomaliesAction action, NextDispatcher next) async {
    next(action);
    await api.copyWith(store.state.auth.user.authToken)
        .getAnomalies()
          .then((anomalies) => {
              refreshAnomaliesHelper(store, anomalies)
          });
  };
}