import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
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
    TypedMiddleware<AppState, SetAnomalyImageAction>(setImage()),
    TypedMiddleware<AppState, ChoosePickerCameraAction>(chooseCamera()),
    TypedMiddleware<AppState, ChoosePickerGalleryAction>(chooseGallery()),
    TypedMiddleware<AppState, DeleteAnomalyImageAction>(removeImage()),
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

setImage() {
  return (Store<AppState> store, SetAnomalyImageAction action, NextDispatcher next) async {
    next(action);
    File image;

    if (store.state.postFeedState.chooseCamera)
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    else 
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    store.dispatch(new FinishSetAnomalyImageAction(image: image));
  };
}

chooseCamera() {
  return (Store<AppState> store, ChoosePickerCameraAction action, NextDispatcher next) async {
    next(action);
  };
}

chooseGallery() {
  return (Store<AppState> store, ChoosePickerGalleryAction action, NextDispatcher next) async {
    next(action);
  };
}

removeImage() {
  return (Store<AppState> store, DeleteAnomalyImageAction action, NextDispatcher next) async {
    next(action);
  };
}