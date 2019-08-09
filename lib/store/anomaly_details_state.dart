import 'package:sbaclean/models/comment.dart';
import 'package:meta/meta.dart';

class AnomalyDetailsState {

  List<Comment> comments;

  AnomalyDetailsState({this.comments});

  AnomalyDetailsState copyWith({List<Comment> comments}) {
    return AnomalyDetailsState(
      comments: comments ?? this.comments
    );
  }
}