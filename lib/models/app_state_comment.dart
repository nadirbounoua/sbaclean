import 'comment.dart';
import 'package:meta/meta.dart';

@immutable
class AppStateComment {

  final List<Comment> comments;

  AppStateComment({this.comments = const []});
}