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

class FinishAddPositionAction {
  final bool havePosition;
  final Position position;
  final Placemark placemark;
  FinishAddPositionAction(this.position, this.placemark, this.havePosition);
}

class AddPositionAction {
  final bool havePosition;
  final Position position;
  final Placemark placemark;
  AddPositionAction(this.position, this.placemark, this.havePosition);

}

class AddPositionFromSearchAction {
  final bool havePosition;
  final Position position;
  final Placemark placemark;
  AddPositionFromSearchAction(this.position, this.placemark, this.havePosition);

}

class PositionErrorAction {

}

class RemovePositionErrorAction {
  
}

class DeletePositionAction {
  final bool havePosition;
  final Position position;
  final Placemark placemark;
  Completer completer = Completer();
  DeletePositionAction(this.position, this.placemark, this.havePosition);

}

class FinishDeletePostionAction{
  
}

class ChoosePickerCameraAction {
  final bool value;
  ChoosePickerCameraAction({this.value});
}

class ChoosePickerGalleryAction {
  final bool value;
  ChoosePickerGalleryAction({this.value});
}

class SetAnomalyImageAction {
  final File image;
  SetAnomalyImageAction({this.image});
}

class FinishSetAnomalyImageAction {
  final File image;
  FinishSetAnomalyImageAction({this.image});

}

class DeleteAnomalyImageAction {
  final File image;
  Completer completer = Completer();
  DeleteAnomalyImageAction({this.image});
}

