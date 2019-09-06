import 'package:sbaclean/models/anomaly.dart';
import 'package:meta/meta.dart';
import 'package:sbaclean/models/event.dart';


@immutable
class UserHistoryState {

  final List<Anomaly> userPosts;
  final List<Event> userEvents;
  final bool isLoading;
  final bool isEventLoading;
  final bool showEvent;
  UserHistoryState({
            this.userPosts = const [],
            this.isLoading = false,
            this.isEventLoading = false,
            this.userEvents = const [],
            this.showEvent = false
  });

  UserHistoryState copyWith({
      List<Anomaly> userPosts,
      bool isLoading,
      bool isEventLoading,
      List<Event> userEvents,
      bool showEvent
  }) {
      return UserHistoryState(
        userPosts: userPosts ?? this.userPosts,
        isLoading: isLoading ?? this.isLoading,
        isEventLoading: isEventLoading ?? this.isEventLoading,
        userEvents: userEvents ?? this.userEvents,
        showEvent: showEvent ?? this.showEvent
      );
  }
}