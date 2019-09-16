import 'package:redux/redux.dart';
import 'package:sbaclean/actions/anomaly_details_actions.dart';

import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/store/feed_state.dart';
import 'package:sbaclean/actions/feed_actions.dart';

Reducer<FeedState> feedReducer = combineReducers([
  new TypedReducer<FeedState, SetPostsChanged>(setPostsChanged),
  //new TypedReducer<FeedState, SetReactionAction>(setReaction),
  new TypedReducer<FeedState, FinishSetReactionAction>(finishSetReaction),
  new TypedReducer<FeedState, FinishUpdateReactionAction>(finishUpdateReaction),

  new TypedReducer<FeedState, FinishDeleteReactionAction>(deleteReaction),
  //new TypedReducer<FeedState, UpdateReactionAction>(updateReaction),
  new TypedReducer<FeedState, GetAnomaliesAction>(load),

  new TypedReducer<FeedState, GetUserReactionAction>(getUserReactions),
  new TypedReducer<FeedState, FinishGetUserReactionAction>(finishGetUserReaction),

  new TypedReducer<FeedState, GetAnomaliesAction>(getAnomalies),
  new TypedReducer<FeedState, AddAnomalyAction>(addItem),
  new TypedReducer<FeedState, FinishAddAnomalyAction>(finishAddItem),
  new TypedReducer<FeedState, FinishAddAnomalyAction>(finishAddItemContent),
  new TypedReducer<FeedState, SilentAddAnomalyAction>(silentAddAnomaly),

  new TypedReducer<FeedState, AddAnomalyAction>(addItem),
  new TypedReducer<FeedState, FinishGetAnomaliesAction>(finishLoadAnomalies),
  new TypedReducer<FeedState, FinishGetAnomaliesAction>(finishLoad),

  new TypedReducer<FeedState, RefreshAnomaliesAction>(refreshAnomalies),
  
  new TypedReducer<FeedState, FinishRefreshAnomaliesAction>(finishRefreshAnomalies),
  new TypedReducer<FeedState, FinishRefreshAnomaliesAction>(finishRefreshAnomaliesContent),
  new TypedReducer<FeedState, GetUserPostReactionAction>(getUserReaction),
  new TypedReducer<FeedState, FinisheDeleteOneAnomalyAction>(finishDeleteAnomaly)


]);

FeedState setPostsChanged(FeedState state,SetPostsChanged action) {
  return state.copyWith(postsChanged: action.changed);
}

FeedState getUserReaction(FeedState state,GetUserPostReactionAction action) {
  Anomaly anomaly = action.anomaly;
  List<Anomaly> list = state.anomalies;
  list.removeWhere((item) => item.id == anomaly.id);
  list.add(anomaly);
  return state.copyWith(anomalies: list);
}


FeedState deleteReaction(FeedState state, FinishDeleteReactionAction action) {
  
  List<Anomaly> list = List.from(state.anomalies)..removeWhere((anomaly) => anomaly.post.id == action.anomaly.post.id);
  Anomaly anomaly = action.anomaly;
  anomaly.post.userReaction.isLike ? anomaly.post.reactionsCount -- : anomaly.post.reactionsCount ++;
  anomaly.post.userReaction = null;
  anomaly.post.reactions.removeWhere((id)=> id == action.reaction.id);
  
  return state.copyWith(
    anomalies: List.from(list)
    ..add(anomaly)
    ..sort((anomaly, anomaly1) => anomaly1.id.compareTo(anomaly.id) )
  );

}

FeedState finishUpdateReaction(FeedState state, FinishUpdateReactionAction action) {

  List<Anomaly> list = List.from(state.anomalies)..removeWhere((anomaly) => anomaly.post.id == action.anomaly.post.id);
  Anomaly anomaly = action.anomaly;
  anomaly.post.userReaction = action.reaction;
  anomaly.post.reactions.removeWhere((id)=> id == action.reaction.id);
  anomaly.post.reactions..add(anomaly.post.userReaction.id);
  anomaly.post.userReaction.isLike ? anomaly.post.reactionsCount +=2 : anomaly.post.reactionsCount -=2;

  return state.copyWith(
    anomalies: List.from(list)
    ..add(anomaly)
    ..sort((anomaly, anomaly1) => anomaly1.id.compareTo(anomaly.id) )
  );

}

FeedState getUserReactions(FeedState state,GetUserReactionAction action){
  List<Reaction> list = action.list;
  return state.copyWith(userReactions: list);
}

FeedState getAnomalies(FeedState state, GetAnomaliesAction action) {
  print('feed reducer: getAnomalies');

  return state.copyWith(anomalies: List.from(action.list)
    ..sort((anomaly, anomaly1) => anomaly1.id.compareTo(anomaly.id) )
  );
}

FeedState finishLoadAnomalies(FeedState state, FinishGetAnomaliesAction action) {

  return state.copyWith(anomalies: List.from(action.anomalies)
    ..sort((anomaly, anomaly1) => anomaly1.id.compareTo(anomaly.id) )
  );
}




FeedState load(FeedState state, GetAnomaliesAction action) {
  print("isloading reducer: getAnomalies: load");
  return state.copyWith(isAnomaliesLoading: true);
}

FeedState finishLoad(FeedState state, FinishGetAnomaliesAction action) {
  print("isloading reducer: getAnomalies: false");

  return state.copyWith(isAnomaliesLoading: false);
}

FeedState finishGetUserReaction(FeedState state, FinishGetUserReactionAction action) {
  return state.copyWith(userReactions: action.list);
}

FeedState finishSetReaction(FeedState state, FinishSetReactionAction action) {
  List<Anomaly> list = List.from(state.anomalies)..removeWhere((anomaly) => anomaly.post.id == action.anomaly.post.id);
  Anomaly anomaly = action.anomaly;
  Reaction reaction = action.reaction;
  anomaly.post.reactions.add(action.reaction.id);
  anomaly.post.userReaction = reaction;
  anomaly.post.userReaction.isLike ? anomaly.post.reactionsCount++ : anomaly.post.reactionsCount --;
  return state.copyWith(
    anomalies: List.from(list)
    ..add(anomaly)
    ..sort((anomaly, anomaly1) => anomaly1.id.compareTo(anomaly.id) )
  );
}

FeedState finishRefreshAnomaliesContent(FeedState state, FinishRefreshAnomaliesAction action) {
  FinishRefreshAnomaliesAction.completer.complete();
  return state.copyWith(anomalies: List.from(action.list)
    ..sort((anomaly, anomaly1) => anomaly1.id.compareTo(anomaly.id) )
  );
}

FeedState refreshAnomalies(FeedState state, RefreshAnomaliesAction action) {
  return state.copyWith(isAnomaliesLoading: true);
}

FeedState finishRefreshAnomalies(FeedState state, FinishRefreshAnomaliesAction action) {
  return state.copyWith(isAnomaliesLoading: false);
}

FeedState finishAddItemContent(FeedState state, FinishAddAnomalyAction action) {
  var list = List.from(state.anomalies)..add(action.anomaly,);
  return state.copyWith(anomalies: List.from(state.anomalies)..add(action.anomaly)
    ..sort((anomaly, anomaly1) => anomaly1.id.compareTo(anomaly.id) )
  );
}

FeedState finishAddItem(FeedState state, FinishAddAnomalyAction action) {
  
  return state.copyWith(isAddAnomalyLoading: false);
}

FeedState addItem(FeedState state, AddAnomalyAction action) {
  
  return state.copyWith(isAddAnomalyLoading: true);
}

FeedState finishDeleteAnomaly(FeedState state, FinisheDeleteOneAnomalyAction action){
  List<Anomaly> list = state.anomalies;
  list.removeWhere((anomaly) => anomaly.id == action.anomaly.id);
  list.sort((anomaly, anomaly1) => anomaly1.id.compareTo(anomaly.id));
  return state.copyWith(anomalies: list);

}

FeedState silentAddAnomaly(FeedState state, SilentAddAnomalyAction action) {
  
  return state.copyWith(anomalies: List.from(state.anomalies)
    ..removeWhere((anomaly) => anomaly.id == action.anomaly.id)
    ..add(action.anomaly)
    ..sort((anomaly, anomaly1) => anomaly1.id.compareTo(anomaly.id) )
  );
}