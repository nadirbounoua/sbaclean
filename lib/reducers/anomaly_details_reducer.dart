import 'package:redux/redux.dart';


import 'package:sbaclean/store/anomaly_details_state.dart';
import 'package:sbaclean/actions/anomaly_details_actions.dart';

//typedef OnSaveComment = Function(int commentOwner, int commentPost, String comentContent);

Reducer<AnomalyDetailsState> anomalyDetailsReducer = combineReducers([
  new TypedReducer<AnomalyDetailsState, AddCommentAction>(addComment),
  new TypedReducer<AnomalyDetailsState, GetCommentsAction>(getComments),
  new TypedReducer<AnomalyDetailsState, FinishGetCommentsAction>(finishGetComments),
  new TypedReducer<AnomalyDetailsState, FinishGetCommentsAction>(finishGetCommentsContent),
  new TypedReducer<AnomalyDetailsState, FinishAddCommentsAction>(finishAddComment),
  new TypedReducer<AnomalyDetailsState, FinishAddCommentsAction>(finishAddCommentContent),

]);

AnomalyDetailsState addComment(AnomalyDetailsState state, AddCommentAction action) {
  return state.copyWith(isAddCommentsLoading: true);
}

AnomalyDetailsState getComments(AnomalyDetailsState state, GetCommentsAction action) {
  return state.copyWith(isCommentsLoading: true);
}

AnomalyDetailsState finishGetComments(AnomalyDetailsState state, FinishGetCommentsAction action) {
  return state.copyWith(isCommentsLoading: false);
}

AnomalyDetailsState finishGetCommentsContent(AnomalyDetailsState state, FinishGetCommentsAction action) {
  return state.copyWith(comments: action.list);
}

AnomalyDetailsState finishAddCommentContent(AnomalyDetailsState state, FinishAddCommentsAction action) {
  return state.copyWith(comments: List.from(state.comments)..add(action.item));
}


AnomalyDetailsState finishAddComment(AnomalyDetailsState state, FinishAddCommentsAction action) {
  return state.copyWith(isAddCommentsLoading: false);
}