import 'package:meta/meta.dart';
import 'package:sbaclean/store/anomaly_details_state.dart';
import 'package:sbaclean/store/auth_state.dart';

import 'package:sbaclean/store/feed_state.dart';
import 'package:sbaclean/store/user_history_state.dart';
import 'package:sbaclean/store/post_feed_state.dart';
import 'package:sbaclean/store/user_state.dart';
import 'package:sbaclean/models/user.dart';

import 'event_state.dart';

@immutable
class AppState {

  final FeedState feedState;
  final PostFeedState postFeedState;
  final UserHistoryState userHistoryState;
  final UserState userState;
  final AnomalyDetailsState anomalyDetailsState;
  final bool isLoading;
  final EventState eventState;
  final AuthState auth;
  AppState({this.feedState,
            this.postFeedState, 
            this.userHistoryState, 
            this.userState, 
            this.anomalyDetailsState,
            this.isLoading,
            this.eventState,
            this.auth
            });


  static AppState newAppState({
      FeedState feedState,
      PostFeedState postFeedState, 
      UserHistoryState userHistoryState, 
      UserState userState,
      AnomalyDetailsState anomalyDetailsState,
      bool isLoading,
      EventState eventState,
      AuthState auth
      }){

    return new AppState(
      feedState: feedState ?? new FeedState(),
      postFeedState: postFeedState ?? PostFeedState(),
      userHistoryState : userHistoryState ?? UserHistoryState(),
      userState: userState ?? UserState(user: User()),
      anomalyDetailsState: anomalyDetailsState ?? AnomalyDetailsState(),
      isLoading: isLoading ?? false,
      eventState: eventState ?? EventState(),
      auth: auth ?? AuthState()
    );
  }

}