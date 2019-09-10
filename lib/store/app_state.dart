import 'package:meta/meta.dart';
import 'package:sbaclean/screens/anomaly_details/anomaly_details.dart';
import 'package:sbaclean/store/anomaly_details_state.dart';
import 'package:sbaclean/store/auth_state.dart';
import 'package:sbaclean/store/city_state.dart';

import 'package:sbaclean/store/feed_state.dart';
import 'package:sbaclean/store/participation_state.dart';
import 'package:sbaclean/store/report_state.dart';
import 'package:sbaclean/store/user_history_state.dart';
import 'package:sbaclean/store/post_feed_state.dart';
import 'package:sbaclean/store/user_state.dart';
import 'package:sbaclean/models/user.dart';

import 'event_state.dart';

class AppState {

  final FeedState feedState;
  final PostFeedState postFeedState;
  final UserHistoryState userHistoryState;
  final AnomalyDetailsState anomalyDetailsState;
  final CityState cityState;
    final ReportState reportState;

  final bool isLoading;
  final EventState eventState;
  final AuthState auth;
  final ParticipationState participationState;

  AppState({this.feedState,
            this.cityState,
            this.postFeedState, 
            this.userHistoryState, 
            this.anomalyDetailsState,
            this.isLoading,
            this.eventState,
            this.auth,
            this.participationState,
            this.reportState
            });


  static AppState newAppState({
      FeedState feedState,
      PostFeedState postFeedState, 
      CityState cityState,
      ReportState reportState,
      UserHistoryState userHistoryState, 
      AnomalyDetailsState anomalyDetailsState,
      bool isLoading,
      EventState eventState,
      AuthState auth,
      ParticipationState participationState
      }){

    return new AppState(
      feedState: feedState ?? new FeedState(),
      postFeedState: postFeedState ?? PostFeedState(),
      userHistoryState : userHistoryState ?? UserHistoryState(),
      anomalyDetailsState: anomalyDetailsState ?? AnomalyDetailsState(),
      isLoading: isLoading ?? false,
      eventState: eventState ?? EventState(),
      auth: auth ?? AuthState(),
      cityState: cityState ?? new CityState(),
      participationState: participationState ?? ParticipationState(),
      reportState: reportState ?? ReportState()
    );
  }


  static AppState fromJSON(dynamic json) {
    print(json);

    return new AppState(
        auth: json== null ? AuthState() : json['auth'] as AuthState,
        feedState: json== null ? FeedState() : json['feed'] as FeedState,
        postFeedState: json== null ? PostFeedState() : json['postFeed'] as PostFeedState,
        userHistoryState : json== null ? UserHistoryState() : json['userHistory'] as UserHistoryState,
        anomalyDetailsState: json== null ? AnomalyDetailsState() : json['anomalyDetails'] as AnomalyDetailsState,
        eventState: json== null ? EventState() : json['eventState'] as EventState,
    );
  } 

  Map<String, dynamic> toJSON() => <String, dynamic>{
        'auth': this.auth,
        'postFeed': this.postFeedState,
        'userHistory': this.userHistoryState,
        'anomalyDetails': this.anomalyDetailsState,
        'eventState': this.eventState,
        'feed': this.feedState,

    };
}