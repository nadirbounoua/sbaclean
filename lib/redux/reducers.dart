import '../models/app_state.dart';
import '../models/anomaly.dart';
import 'package:learning2/models/reaction.dart';
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
  
  if (action is SetReactionAction) {
    return setReaction(state, action);
  }

  if (action is DeleteReactionAction) {
    return deleteReaction(state, action);
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

AppState setReaction(AppState state, SetReactionAction action) {
  List<Anomaly> list = List.from(state.anomalies)..removeWhere((anomaly) => anomaly.id == action.anomaly.id);
  Anomaly anomaly = action.anomaly;
  Reaction reaction = action.reaction;
  anomaly.reactions.add(action.reaction.id);
  anomaly.userReaction = reaction;
  return AppState(anomalies: List.from(state.anomalies)..add(anomaly));
}

AppState deleteReaction(AppState state, DeleteReactionAction action) {
  List<Anomaly> list = List.from(state.anomalies)..removeWhere((anomaly) => anomaly.id == action.anomaly.id);
  Anomaly anomaly = action.anomaly;
  print(anomaly);
  anomaly.userReaction = null;
  anomaly.reactions.removeWhere((id)=> id == action.reaction.id);
  return AppState(anomalies: List.from(list)..add(anomaly));
}