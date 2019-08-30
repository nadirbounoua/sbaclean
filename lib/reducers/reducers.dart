import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/reducers/feed_reducer.dart';
import 'package:sbaclean/reducers/post_feed_reducer.dart';
import 'package:sbaclean/reducers/user_history_reducer.dart';
import 'package:sbaclean/reducers/reducers_user.dart';
import 'anomaly_details_reducer.dart';
import 'package:sbaclean/reducers/is_loading_reducer.dart';

AppState appStateReducers(AppState state, dynamic action) {
    return AppState(
          feedState: feedReducer(state.feedState, action),
          postFeedState: postFeedReducer(state.postFeedState, action),
          userHistoryState: userHistoryReducer(state.userHistoryState, action),
          userState: userStateReducers(state.userState, action),
          anomalyDetailsState: anomalyDetailsReducer(state.anomalyDetailsState, action),
          isLoading: isLoadingReducer(state.isLoading, action)
    );
}

