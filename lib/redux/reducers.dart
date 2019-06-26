import '../models/app_state.dart';
import '../models/anomaly.dart';
import 'actions.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:geolocator/geolocator.dart';
typedef OnSaveAnomaly = Function(String title, String description, String longitude, String latitude);

AppState appStateReducers(AppState state, dynamic action) {
  if (action is AddAnomalyAction) {
    return addItem(state.anomalies, action);
  }  

  if (action is GetAnomaliesAction) {
    return getAnomalies(state.anomalies,action );
  }

  if (action is AddPositionAction) {
    return getPostion(state.position, action);
  }

  if (action is DeletePositionAction) {
    return deletePosition(state.position, action);
  }

  if (action is SetLoadingAction) {
    return setLoading(action);
  }

  if (action is RemoveLoadingAction) {
    return removeLoading(action);
  }

  if (action is ChoosePickerCameraAction) {
    return chooseCamera(action);
  }

  if (action is ChoosePickerGalleryAction) {

    return chooseGallery(action);
  }

  if (action is SetAnomalyImageAction){
    return setPostImage(action);
  }

  if (action is SetPostsChanged){
    return setPostsChanged(state,action);
  }

  return state;
}

AppState addItem(List<Anomaly> items, AddAnomalyAction action) {
  return AppState(anomalies: List.from(items)..add(action.item));
}

AppState getAnomalies(List<Anomaly> items, GetAnomaliesAction action) {
  return AppState(anomalies: List.from(action.list));
}

AppState getPostion(Position position, AddPositionAction action){
  
  if (action.position != null)   
    return AppState(position: action.position,placemark: action.placemark, havePosition: action.havePosition);

  return AppState(position: position);
}

AppState deletePosition(Position position, DeletePositionAction action){
    return AppState(position: action.position,placemark: action.placemark, havePosition: action.havePosition);
}

AppState setLoading(SetLoadingAction action) {
  return AppState(isLoading: action.isLoading);
}

AppState removeLoading(RemoveLoadingAction action) {
  return AppState(isLoading: action.isLoading);
}

AppState chooseCamera(ChoosePickerCameraAction action) {
  print('Action value: '+ action.value.toString());

  return AppState(chooseCamera: action.value);
}

AppState chooseGallery(ChoosePickerGalleryAction action) {
  print('Action value: '+ action.value.toString());

  return AppState(chooseCamera: action.value);
}

AppState setPostImage(SetAnomalyImageAction action) {
  return AppState(image: action.image);
}

AppState setPostsChanged(AppState state,SetPostsChanged action) {
  return AppState(postsChanged: action.changed,anomalies: state.anomalies);
}