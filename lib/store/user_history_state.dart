import 'package:sbaclean/models/anomaly.dart';
import 'package:meta/meta.dart';


@immutable
class UserHistoryState {

  final List<Anomaly> userPosts;
  final bool isLoading;
  UserHistoryState({
            this.userPosts = const [],
            this.isLoading = false
  });

  UserHistoryState copyWith({
      List<Anomaly> userPosts,
      bool isLoading
  }) {
      return UserHistoryState(
        userPosts: userPosts ?? this.userPosts,
        isLoading: isLoading ?? this.isLoading
      );
  }
}