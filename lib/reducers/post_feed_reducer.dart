import 'package:redux/redux.dart';


import 'package:sbaclean/store/post_feed_state.dart';
import 'package:sbaclean/actions/post_feed_actions.dart';


Reducer<PostFeedState> postFeedReducer = combineReducers([
  new TypedReducer<PostFeedState, AddPositionAction>(getPostion),
  new TypedReducer<PostFeedState, DeletePositionAction>(deletePosition),
  new TypedReducer<PostFeedState, ChoosePickerCameraAction>(chooseCamera),
  new TypedReducer<PostFeedState, ChoosePickerGalleryAction>(chooseGallery),
  new TypedReducer<PostFeedState, SetAnomalyImageAction>(setPostImage),
  new TypedReducer<PostFeedState, DeleteAnomalyImageAction>(deletePostImage)

]);


PostFeedState getPostion(PostFeedState state, AddPositionAction action){

  if (action.position != null)   
    return state.copyWith(position: action.position,placemark: action.placemark, havePosition: action.havePosition);

  return state.copyWith();
}

PostFeedState deletePosition(PostFeedState state, DeletePositionAction action){ 
  return PostFeedState();
}

PostFeedState chooseCamera(PostFeedState state,ChoosePickerCameraAction action) {

  return state.copyWith(chooseCamera: action.value);
}

PostFeedState chooseGallery(PostFeedState state,ChoosePickerGalleryAction action) {
  print('Action value: '+ action.value.toString());

  return state.copyWith(chooseCamera: action.value);
}

PostFeedState setPostImage(PostFeedState state,SetAnomalyImageAction action) { 
  return state.copyWith(image: action.image);
}

PostFeedState deletePostImage(PostFeedState state, DeleteAnomalyImageAction action) {
  print(action.image);
  return PostFeedState();
}
