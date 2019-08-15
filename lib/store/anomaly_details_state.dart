import 'package:sbaclean/models/comment.dart';
import 'package:meta/meta.dart';

@immutable
class AnomalyDetailsState {

  final List<Comment> comments;

  AnomalyDetailsState({this.comments = const []});

  AnomalyDetailsState copyWith({List<Comment> comments}) {
    return AnomalyDetailsState(
      comments: comments ?? this.comments
    );
  }
}