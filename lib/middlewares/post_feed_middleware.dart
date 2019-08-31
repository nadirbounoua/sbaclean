import 'package:geolocator/geolocator.dart';
import 'package:redux/redux.dart';
import 'dart:convert';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/actions/post_feed_actions.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/middlewares/feed_helper.dart';
import 'package:sbaclean/middlewares/post_feed_helper.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/store/app_state.dart';

Api api = Api();

List<Middleware<AppState>> postFeedMiddleware() {
  return [
    TypedMiddleware<AppState, AddPositionAction>(getPosition()),
    TypedMiddleware<AppState, DeletePositionAction>(deletePosition()),

  ];
}

getPosition(){
  return (Store<AppState> store, AddPositionAction action, NextDispatcher next) async {
      next(action);
      final myPosition =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      await Geolocator().placemarkFromCoordinates(myPosition.latitude, myPosition.longitude)
            .then((location) {
                getPositionHelper(store, myPosition, location);
            });
        
  };
}

deletePosition(){
  return (Store<AppState> store, DeletePositionAction action, NextDispatcher next) async {
    next(action);
    store.dispatch(FinishDeletePostionAction());
  };
}
