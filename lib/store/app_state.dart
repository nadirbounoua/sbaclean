import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:sbaclean/store/feed_state.dart';
import 'package:sbaclean/store/user_history_state.dart';
import 'package:sbaclean/store/post_feed_state.dart';


@immutable
class AppState {

  final FeedState feedState;
  final PostFeedState postFeedState;
  final UserHistoryState userHistoryState;

  AppState({this.feedState,this.postFeedState, this.userHistoryState});


  static AppState newAppState({FeedState feedState,PostFeedState postFeedState, UserHistoryState userHistoryState}) {

    return new AppState(
      feedState: feedState ?? new FeedState(),
      postFeedState: postFeedState ?? PostFeedState(),
      userHistoryState : userHistoryState ?? UserHistoryState()

    );
  }

}