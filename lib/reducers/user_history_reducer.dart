import 'package:redux/redux.dart';

import 'package:sbaclean/store/user_history_state.dart';
import 'package:sbaclean/actions/user_history_actions.dart';

Reducer<UserHistoryState> userHistoryReducer = combineReducers([
  new TypedReducer<UserHistoryState ,GetUserAnomaliesHistoryAction>(getUserAnomaliesHistory),

]);


UserHistoryState getUserAnomaliesHistory(UserHistoryState state, GetUserAnomaliesHistoryAction action) {
  return state.copyWith(userPosts: action.list);
}
