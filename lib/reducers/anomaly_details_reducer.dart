import 'package:redux/redux.dart';


import 'package:sbaclean/store/anomaly_details_state.dart';
import 'package:sbaclean/actions/anomaly_details_actions.dart';

//typedef OnSaveComment = Function(int commentOwner, int commentPost, String comentContent);

Reducer<AnomalyDetailsState> anomalyDetailsReducer = combineReducers([
  new TypedReducer<AnomalyDetailsState, AddCommentAction>(addComment),
  new TypedReducer<AnomalyDetailsState, GetCommentsAction>(getComments),


]);

AnomalyDetailsState addComment(AnomalyDetailsState state, AddCommentAction action) {
  return state.copyWith(comments: List.from(state.comments)..add(action.item));
}

AnomalyDetailsState getComments(AnomalyDetailsState state, GetCommentsAction action) {
  return state.copyWith(comments: action.list);
}

