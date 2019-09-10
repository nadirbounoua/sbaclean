import 'package:sbaclean/reducers/auth_reducer.dart';
import 'package:sbaclean/reducers/city_reducer.dart';
import 'package:sbaclean/reducers/event_reducer.dart';
import 'package:sbaclean/reducers/participation_reducer.dart';
import 'package:sbaclean/reducers/report_reducer.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/reducers/feed_reducer.dart';
import 'package:sbaclean/reducers/post_feed_reducer.dart';
import 'package:sbaclean/reducers/user_history_reducer.dart';
import 'package:sbaclean/reducers/reducers_user.dart';
import 'anomaly_details_reducer.dart';

AppState appStateReducers(AppState state, dynamic action) {
    return AppState(
          feedState: feedReducer(state.feedState, action),
          postFeedState: postFeedReducer(state.postFeedState, action),
          userHistoryState: userHistoryReducer(state.userHistoryState, action),
          anomalyDetailsState: anomalyDetailsReducer(state.anomalyDetailsState, action),
          auth: authReducer(state.auth,action),
          eventState: eventReducer(state.eventState, action),
          cityState: cityReducer(state.cityState, action),
          participationState: participationReducer(state.participationState, action),
          reportState: reportReducer(state.reportState, action)
    );
}

