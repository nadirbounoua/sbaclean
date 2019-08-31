import 'package:sbaclean/models/comment.dart';
import 'package:meta/meta.dart';

@immutable
class AnomalyDetailsState {

  final List<Comment> comments;
  final bool isCommentsLoading;
  final bool isAddCommentsLoading;

  AnomalyDetailsState({
        this.comments = const [],
        this.isCommentsLoading = false,
        this.isAddCommentsLoading = false
    });

  AnomalyDetailsState copyWith({
    List<Comment> comments,
    bool isCommentsLoading,
    bool isAddCommentsLoading
    }) {
    return AnomalyDetailsState(
      comments: comments ?? this.comments,
      isCommentsLoading: isCommentsLoading ?? this.isCommentsLoading,
      isAddCommentsLoading: isAddCommentsLoading ?? this.isAddCommentsLoading
    );
  }
}