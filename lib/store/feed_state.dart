import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:meta/meta.dart';


@immutable
class FeedState {

  final List<Anomaly> anomalies;
  final bool postsChanged;
  final List<Reaction> userReactions;

  FeedState({this.anomalies = const [], 
            this.postsChanged = false,
            this.userReactions = const [],
  });

  FeedState copyWith({
      List<Anomaly> anomalies,
      bool postsChanged,
      List<Reaction> userReactions,
  }) {
    return FeedState(
      anomalies: anomalies ?? this.anomalies,
      postsChanged: postsChanged ?? this.postsChanged,
      userReactions: userReactions ?? this.userReactions
    );
  }
}