import 'package:sbaclean/models/anomaly.dart';
import 'package:meta/meta.dart';


@immutable
class UserHistoryState {

  final List<Anomaly> userPosts;
  UserHistoryState({
            this.userPosts = const []
  });

  UserHistoryState copyWith({
      List<Anomaly> userPosts
  }) {
      return UserHistoryState(
        userPosts: userPosts ?? this.userPosts
      );
  }
}