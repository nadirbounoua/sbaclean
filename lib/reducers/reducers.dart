import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/reducers/feed_reducer.dart';
import 'package:sbaclean/reducers/post_feed_reducer.dart';
import 'package:sbaclean/reducers/user_history_reducer.dart';


AppState appStateReducers(AppState state, dynamic action) {
    return AppState(
          feedState: feedReducer(state.feedState, action),
          postFeedState: postFeedReducer(state.postFeedState, action),
          userHistoryState: userHistoryReducer(state.userHistoryState, action)
        );
}

