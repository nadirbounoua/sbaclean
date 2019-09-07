import 'package:redux/redux.dart';


import 'package:sbaclean/store/post_feed_state.dart';
import 'package:sbaclean/actions/post_feed_actions.dart';


Reducer<PostFeedState> postFeedReducer = combineReducers([
  new TypedReducer<PostFeedState, AddPositionAction>(getPostion),
  new TypedReducer<PostFeedState, AddPositionFromSearchAction>(getPostionFromSearch),

  new TypedReducer<PostFeedState, FinishDeletePostionAction>(deletePosition),
  new TypedReducer<PostFeedState, ChoosePickerCameraAction>(chooseCamera),
  new TypedReducer<PostFeedState, ChoosePickerGalleryAction>(chooseGallery),
  new TypedReducer<PostFeedState, DeleteAnomalyImageAction>(deletePostImage),

  new TypedReducer<PostFeedState, FinishAddPositionAction>(finishGetPostion),
  new TypedReducer<PostFeedState, FinishAddPositionAction>(finishGetPostionContent),
  new TypedReducer<PostFeedState, FinishSetAnomalyImageAction>(finishSetAnomalyImage),



]);

PostFeedState finishGetPostionContent(PostFeedState state, FinishAddPositionAction action){

  if (action.position != null)   
    return state.copyWith(position: action.position,placemark: action.placemark, havePosition: action.havePosition);

  return state.copyWith();
}

PostFeedState getPostionFromSearch(PostFeedState state, AddPositionFromSearchAction action){

  if (action.placemark != null)   
    print(action.placemark.country);
    return state.copyWith(position: action.placemark.position,placemark: action.placemark, havePosition: true);

  return state.copyWith();
}

PostFeedState getPostion(PostFeedState state, AddPositionAction action){

  return state.copyWith(isGpsLoading: true);
}

PostFeedState finishGetPostion(PostFeedState state, FinishAddPositionAction action){

  return state.copyWith(isGpsLoading: false);
}

PostFeedState deletePosition(PostFeedState state, FinishDeletePostionAction action){ 
  print("k");
  return PostFeedState();
}

PostFeedState chooseCamera(PostFeedState state,ChoosePickerCameraAction action) {

  return state.copyWith(chooseCamera: action.value);
}

PostFeedState chooseGallery(PostFeedState state,ChoosePickerGalleryAction action) {
  print('Action value: '+ action.value.toString());

  return state.copyWith(chooseCamera: action.value);
}



PostFeedState deletePostImage(PostFeedState state, DeleteAnomalyImageAction action) {
  print(action.image);
  return PostFeedState();
}

PostFeedState finishSetAnomalyImage(PostFeedState state,FinishSetAnomalyImageAction action) { 
  return state.copyWith(image: action.image);
}
