import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/store/app_state.dart';

import 'package:sbaclean/backend/api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sbaclean/backend/utils.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

enum Actions {AddAnomalyAction,ChoosePickerCameraAction,ChoosePickerGalleryAction, GetAnomaliesAction}
Api api = Api();
class SetLoadingAction {
  final bool isLoading;
  SetLoadingAction(this.isLoading);
}

class RemoveLoadingAction {
  final bool isLoading;
  RemoveLoadingAction(this.isLoading);
}


class AddPositionAction {
  final bool havePosition;
  final Position position;
  final List<Placemark> placemark;
  AddPositionAction(this.position, this.placemark, this.havePosition);

    ThunkAction<AppState> getPosition() {
      return (Store<AppState> store) async {        
        final myPosition =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        final myLocation = await Geolocator().placemarkFromCoordinates(myPosition.latitude, myPosition.longitude);
        final havePosition = true;
        store.dispatch(new AddPositionAction(myPosition, myLocation, havePosition));

        //final placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);

  };
}
}

class DeletePositionAction {
  final bool havePosition;
  final Position position;
  final List<Placemark> placemark;
  DeletePositionAction(this.position, this.placemark, this.havePosition);

    ThunkAction<AppState> deletePosition() {
      return (Store<AppState> store) async {
        final myPosition =  null;
        final myLocation = null;
        print('k');
        store.dispatch(new DeletePositionAction(myPosition, myLocation, false));
        //final placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);

  };
}
}


class ChoosePickerCameraAction {
  final bool value;
  ChoosePickerCameraAction({this.value});
  ThunkAction<AppState> chooseCamera() {
    return (Store<AppState> store) {
      print("true");
      store.dispatch(new ChoosePickerCameraAction(value: true));
    };
  }
}

class ChoosePickerGalleryAction {
  final bool value;
  ChoosePickerGalleryAction({this.value});
}

class SetAnomalyImageAction {
  final File image;
  SetAnomalyImageAction({this.image});

  ThunkAction<AppState> setImage() {
    return (Store<AppState> store) async {
    File image;
    if (store.state.postFeedState.chooseCamera)
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    else 
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    store.dispatch(new SetAnomalyImageAction(image: image));
    };
    
  }
}
