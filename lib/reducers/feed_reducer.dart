import 'package:redux/redux.dart';

import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/store/feed_state.dart';
import 'package:sbaclean/actions/feed_actions.dart';

Reducer<FeedState> feedReducer = combineReducers([
  new TypedReducer<FeedState, SetPostsChanged>(setPostsChanged),
  new TypedReducer<FeedState, SetReactionAction>(setReaction),
  new TypedReducer<FeedState, DeleteReactionAction>(deleteReaction),
  new TypedReducer<FeedState, UpdateReactionAction>(updateReaction),
  new TypedReducer<FeedState, GetUserReactionAction>(getUserReactions),
  new TypedReducer<FeedState, GetAnomaliesAction>(getAnomalies),
  new TypedReducer<FeedState, AddAnomalyAction>(addItem),

]);

FeedState setPostsChanged(FeedState state,SetPostsChanged action) {
  return state.copyWith(postsChanged: action.changed);
}

FeedState setReaction(FeedState state, SetReactionAction action) {
  
  List<Anomaly> list = List.from(state.anomalies)..removeWhere((anomaly) => anomaly.id == action.anomaly.id);
  Anomaly anomaly = action.anomaly;
  Reaction reaction = action.reaction;
  anomaly.reactions.add(action.reaction.id);
  anomaly.userReaction = reaction;
  
  return state.copyWith(
    anomalies: List.from(list)
    ..add(anomaly)
    ..sort((anomaly, anomaly1) => anomaly.id > anomaly1.id ? 1 : -1 )
  );
}

FeedState deleteReaction(FeedState state, DeleteReactionAction action) {
  
  List<Anomaly> list = List.from(state.anomalies)..removeWhere((anomaly) => anomaly.id == action.anomaly.id);
  Anomaly anomaly = action.anomaly;
  anomaly.userReaction = null;
  anomaly.reactions.removeWhere((id)=> id == action.reaction.id);
  
  return state.copyWith(
    anomalies: List.from(list)
    ..add(anomaly)
    ..sort((anomaly, anomaly1) => anomaly.id > anomaly1.id ? 1 : -1 )
  );

}

FeedState updateReaction(FeedState state, UpdateReactionAction action) {

  List<Anomaly> list = List.from(state.anomalies)..removeWhere((anomaly) => anomaly.id == action.anomaly.id);
  Anomaly anomaly = action.anomaly;
  anomaly.userReaction = action.reaction;
  anomaly.reactions.removeWhere((id)=> id == action.reaction.id);
  anomaly.reactions..add(anomaly.userReaction.id);

  return state.copyWith(
    anomalies: List.from(list)
    ..add(anomaly)
    ..sort((anomaly, anomaly1) => anomaly.id > anomaly1.id ? 1 : -1 )
  );

}

FeedState getUserReactions(FeedState state,GetUserReactionAction action){
  List<Reaction> list = action.list;
  return state.copyWith(userReactions: list);
}

FeedState getAnomalies(FeedState state, GetAnomaliesAction action) {
  return state.copyWith(anomalies: List.from(action.list));
}


FeedState addItem(FeedState state, AddAnomalyAction action) {
  var list = List.from(state.anomalies)..add(action.anomaly,);
  print(list);
  return state.copyWith(anomalies: List.from(state.anomalies)..add(action.anomaly));
}

