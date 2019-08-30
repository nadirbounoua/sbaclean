import 'package:redux/redux.dart';

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
  new TypedReducer<FeedState, AddAnomalyAction>(loadAddAnomaly),
  new TypedReducer<FeedState, FinishAddAnomalyAction>(finishAddAnomaly),
  new TypedReducer<FeedState, FinishAddAnomalyAction>(finishAddAnomalyContent),

  new TypedReducer<FeedState, AddAnomalyAction>(addItem),
  new TypedReducer<FeedState, FinishGetAnomaliesAction>(finishLoadAnomalies),
  new TypedReducer<FeedState, FinishGetAnomaliesAction>(finishLoad),

]);

FeedState setPostsChanged(FeedState state,SetPostsChanged action) {
  return state.copyWith(postsChanged: action.changed);
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
    ..sort((anomaly, anomaly1) => anomaly.post.id > anomaly1.id ? 1 : -1 )
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
    ..sort((anomaly, anomaly1) => anomaly.post.id > anomaly1.id ? 1 : -1 )
  );

}

FeedState getUserReactions(FeedState state,GetUserReactionAction action){
  List<Reaction> list = action.list;
  return state.copyWith(userReactions: list);
}

FeedState getAnomalies(FeedState state, GetAnomaliesAction action) {
  print('feed reducer: getAnomalies');

  return state.copyWith(anomalies: List.from(action.list));
}

FeedState finishLoadAnomalies(FeedState state, FinishGetAnomaliesAction action) {

  return state.copyWith(anomalies: List.from(action.anomalies));
}


FeedState addItem(FeedState state, AddAnomalyAction action) {
  var list = List.from(state.anomalies)..add(action.anomaly,);
  print(list);
  return state.copyWith(anomalies: List.from(state.anomalies)..add(action.anomaly));
}

FeedState load(FeedState state, GetAnomaliesAction action) {
  print("isloading reducer: getAnomalies: load");
  return state.copyWith(isAnomaliesLoading: true);
}

FeedState finishLoad(FeedState state, FinishGetAnomaliesAction action) {
  print("isloading reducer: getAnomalies: false");

  return state.copyWith(isAnomaliesLoading: false);
}

FeedState loadAddAnomaly(FeedState state, AddAnomalyAction action) {
  return state.copyWith(isAnomaliesLoading: true);
}

FeedState finishAddAnomaly(FeedState state, FinishAddAnomalyAction action) {
  return state.copyWith(isAnomaliesLoading: false);
}

FeedState finishAddAnomalyContent(FeedState state, FinishAddAnomalyAction action) {
  return state.copyWith(anomalies: List.from(state.anomalies)..add(action.anomaly));
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
    ..sort((anomaly, anomaly1) => anomaly.post.id > anomaly1.id ? 1 : -1 )
  );
}