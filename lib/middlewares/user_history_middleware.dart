import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'dart:convert';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/actions/user_history_actions.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/middlewares/feed_helper.dart';
import 'package:sbaclean/middlewares/post_feed_helper.dart';
import 'package:sbaclean/middlewares/user_history_helper.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/store/app_state.dart';

Api api = Api();

List<Middleware<AppState>> userHistoryMiddleware() {
  return [
    TypedMiddleware<AppState, GetUserAnomaliesHistoryAction>(getUserAnomaliesHistory()),
    TypedMiddleware<AppState, GetUserEventHistoryAction>(getEventAnomaliesHistory()),

  ];
}

getUserAnomaliesHistory(){
    return (Store<AppState> store, GetUserAnomaliesHistoryAction action, NextDispatcher next) async {
      next(action);
      await api.copyWith(store.state.auth.user.authToken)
                .getUserAnomaliesHistory(store.state.auth.user.id)
                  .then((response) {
                    getUserAnomaliesHistoryHelper(store, response);
                  });
    };
}

getEventAnomaliesHistory(){
    return (Store<AppState> store, GetUserEventHistoryAction action, NextDispatcher next) async {
      next(action);
      store.dispatch(FinishGetUserEventHistoryAction(
              userId: store.state.auth.user.id, list: []).getEvents());
    };
}