import 'package:redux/redux.dart';

import 'package:sbaclean/store/user_history_state.dart';
import 'package:sbaclean/actions/user_history_actions.dart';

Reducer<UserHistoryState> userHistoryReducer = combineReducers([
  new TypedReducer<UserHistoryState ,GetUserAnomaliesHistoryAction>(getUserAnomaliesHistory),
  new TypedReducer<UserHistoryState ,FinishGetUserAnomaliesHistoryAction>(finishGetUserAnomaliesHistoryContent),
  new TypedReducer<UserHistoryState ,FinishGetUserAnomaliesHistoryAction>(finishGetUserAnomaliesHistory),



]);


UserHistoryState getUserAnomaliesHistory(UserHistoryState state, GetUserAnomaliesHistoryAction action) {
  return state.copyWith(isLoading: true);
}

UserHistoryState finishGetUserAnomaliesHistory(UserHistoryState state, FinishGetUserAnomaliesHistoryAction action) {
  print("done");
  return state.copyWith(isLoading: false);

}

UserHistoryState finishGetUserAnomaliesHistoryContent(UserHistoryState state, FinishGetUserAnomaliesHistoryAction action) {
  return state.copyWith(userPosts: action.list);

}
