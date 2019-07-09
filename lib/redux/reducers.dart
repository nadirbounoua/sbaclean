import '../models/app_state.dart';
import '../models/anomaly.dart';
import 'package:learning2/models/reaction.dart';
import 'actions.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:geolocator/geolocator.dart';
typedef OnSaveAnomaly = Function(String title, String description, String longitude, String latitude, String imageUrl);

AppState appStateReducers(AppState state, dynamic action) {
  if (action is AddAnomalyAction) {
     return addItem(state, action); 
 }  

  if (action is GetAnomaliesAction) {
    return getAnomalies(state.anomalies,action );
  }

  if (action is AddPositionAction) {
    return getPostion(state, action);
  }

  if (action is DeletePositionAction) {
    return deletePosition(state, action);
  }

  if (action is SetLoadingAction) {
    return setLoading(action);
  }

  if (action is RemoveLoadingAction) {
    return removeLoading(action);
  }

  if (action is ChoosePickerCameraAction) {
    return chooseCamera(state,action);
  }

  if (action is ChoosePickerGalleryAction) {

    return chooseGallery(state,action);
  }

  if (action is SetAnomalyImageAction){
    return setPostImage(state,action);
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

  if (action is UpdateReactionAction) {
    return updateReaction(state, action);
  }

  if (action is GetUserReactionAction) {
    return getUserReactions(state, action);
  }
  
  return state;
}



AppState addItem(AppState state, AddAnomalyAction action) {
  var list = List.from(state.anomalies)..add(action.item);
  print(list);
  return AppState( userReactions: state.userReactions, anomalies: List.from(state.anomalies)..add(action.item));
}

AppState getAnomalies(List<Anomaly> items, GetAnomaliesAction action) {
  return AppState(anomalies: List.from(action.list));
}

AppState getPostion(AppState state, AddPositionAction action){

  if (action.position != null)   
    return AppState(userReactions: state.userReactions,image: state.image,anomalies: state.anomalies,position: action.position,placemark: action.placemark, havePosition: action.havePosition);

  return AppState(userReactions: state.userReactions,image: state.image,anomalies: state.anomalies, position: state.position);
}

 AppState deletePosition(AppState state, DeletePositionAction action){ 
  return AppState(userReactions: state.userReactions,image: state.image,anomalies: state.anomalies,position: action.position,placemark: action.placemark, havePosition: action.havePosition);
}

AppState setLoading(SetLoadingAction action) {
  return AppState(isLoading: action.isLoading);
}

AppState removeLoading(RemoveLoadingAction action) {
  return AppState(isLoading: action.isLoading);
}

AppState chooseCamera(AppState state,ChoosePickerCameraAction action) {
  print('Action value: '+ action.value.toString());

  return AppState(userReactions: state.userReactions,image: state.image,anomalies : state.anomalies,chooseCamera: action.value);
}

AppState chooseGallery(AppState state,ChoosePickerGalleryAction action) {
  print('Action value: '+ action.value.toString());

  return AppState(userReactions: state.userReactions,image: state.image,anomalies: state.anomalies,chooseCamera: action.value);
}


 AppState setPostImage(AppState state,SetAnomalyImageAction action) { 
  return AppState(userReactions: state.userReactions,anomalies : state.anomalies, image: action.image);
}

AppState setPostsChanged(AppState state,SetPostsChanged action) {
  return AppState(userReactions: state.userReactions,image: state.image,anomalies: state.anomalies,position: state.position,placemark: state.placemark, havePosition: state.havePosition,postsChanged: action.changed);
}

AppState setReaction(AppState state, SetReactionAction action) {
  
  List<Anomaly> list = List.from(state.anomalies)..removeWhere((anomaly) => anomaly.id == action.anomaly.id);
  Anomaly anomaly = action.anomaly;
  Reaction reaction = action.reaction;
  anomaly.reactions.add(action.reaction.id);
  anomaly.userReaction = reaction;
  
  return AppState(
    anomalies: List.from(list)
    ..add(anomaly)
    ..sort((anomaly, anomaly1) => anomaly.id > anomaly1.id ? 1 : -1 )
  );
}

AppState deleteReaction(AppState state, DeleteReactionAction action) {
  
  List<Anomaly> list = List.from(state.anomalies)..removeWhere((anomaly) => anomaly.id == action.anomaly.id);
  Anomaly anomaly = action.anomaly;
  anomaly.userReaction = null;
  anomaly.reactions.removeWhere((id)=> id == action.reaction.id);
  
  return AppState(
    anomalies: List.from(list)
    ..add(anomaly)
    ..sort((anomaly, anomaly1) => anomaly.id > anomaly1.id ? 1 : -1 )
  );

}

AppState updateReaction(AppState state, UpdateReactionAction action) {

  List<Anomaly> list = List.from(state.anomalies)..removeWhere((anomaly) => anomaly.id == action.anomaly.id);
  Anomaly anomaly = action.anomaly;
  anomaly.userReaction = action.reaction;
  anomaly.reactions.removeWhere((id)=> id == action.reaction.id);
  anomaly.reactions..add(anomaly.userReaction.id);

  return AppState(
    anomalies: List.from(list)
    ..add(anomaly)
    ..sort((anomaly, anomaly1) => anomaly.id > anomaly1.id ? 1 : -1 )
  );

}

AppState getUserReactions(AppState state,GetUserReactionAction action){
  List<Reaction> list = action.list;
  return AppState(userReactions: list);
}

