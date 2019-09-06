import 'package:redux/redux.dart';

import 'package:sbaclean/store/user_history_state.dart';
import 'package:sbaclean/actions/user_history_actions.dart';

Reducer<UserHistoryState> userHistoryReducer = combineReducers([
  new TypedReducer<UserHistoryState ,GetUserAnomaliesHistoryAction>(getUserAnomaliesHistory),
  new TypedReducer<UserHistoryState ,FinishGetUserAnomaliesHistoryAction>(finishGetUserAnomaliesHistoryContent),
  new TypedReducer<UserHistoryState ,FinishGetUserAnomaliesHistoryAction>(finishGetUserAnomaliesHistory),
  new TypedReducer<UserHistoryState ,GetUserEventHistoryAction>(getUserEventsHistory),
  new TypedReducer<UserHistoryState ,FinishGetUserEventHistoryAction>(finishGetUserEventsHistory),
  new TypedReducer<UserHistoryState ,FinishGetUserEventHistoryAction>(finishGetUserEventsHistoryContent),
  new TypedReducer<UserHistoryState ,ShowAnomalyAction>(showAnomaly),
  new TypedReducer<UserHistoryState ,ShowEventAction>(showEvent),




]);

UserHistoryState showAnomaly(UserHistoryState state, ShowAnomalyAction action) {
  return state.copyWith(showEvent: false);
}

UserHistoryState showEvent(UserHistoryState state, ShowEventAction action) {
  return state.copyWith(showEvent: true);
}


UserHistoryState getUserAnomaliesHistory(UserHistoryState state, GetUserAnomaliesHistoryAction action) {
  return state.copyWith(isLoading: true);
}

UserHistoryState getUserEventsHistory(UserHistoryState state, GetUserEventHistoryAction action) {
  return state.copyWith(isEventLoading: true);
}

UserHistoryState finishGetUserEventsHistory(UserHistoryState state, FinishGetUserEventHistoryAction action) {
  return state.copyWith(isEventLoading: false);
}

UserHistoryState finishGetUserEventsHistoryContent(UserHistoryState state, FinishGetUserEventHistoryAction action) {
  print('reducer');
  print('reducer list' +action.list.toString());

  return state.copyWith(userEvents: action.list);
}

UserHistoryState finishGetUserAnomaliesHistory(UserHistoryState state, FinishGetUserAnomaliesHistoryAction action) {
  print("done");
  return state.copyWith(isLoading: false);

}

UserHistoryState finishGetUserAnomaliesHistoryContent(UserHistoryState state, FinishGetUserAnomaliesHistoryAction action) {
  return state.copyWith(userPosts: action.list);

}
