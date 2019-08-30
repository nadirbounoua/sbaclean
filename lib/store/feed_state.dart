import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:meta/meta.dart';


@immutable
class FeedState {

  final List<Anomaly> anomalies;
  final bool postsChanged;
  final List<Reaction> userReactions;
  final bool isAnomaliesLoading;
  final bool isAddAnomalyLoading;
  FeedState({this.anomalies = const [], 
            this.postsChanged = false,
            this.userReactions = const [],
            this.isAnomaliesLoading = false,
            this.isAddAnomalyLoading = false
  });

  FeedState copyWith({
      List<Anomaly> anomalies,
      bool postsChanged,
      List<Reaction> userReactions,
      bool isAnomaliesLoading,
      bool isAddAnomalyLoading,
  }) {
    return FeedState(
      anomalies: anomalies ?? this.anomalies,
      postsChanged: postsChanged ?? this.postsChanged,
      userReactions: userReactions ?? this.userReactions,
      isAnomaliesLoading: isAnomaliesLoading ?? this.isAnomaliesLoading,
      isAddAnomalyLoading: isAddAnomalyLoading ?? this.isAddAnomalyLoading
    );
  }
}