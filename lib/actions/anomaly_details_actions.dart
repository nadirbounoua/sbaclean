import 'package:sbaclean/models/comment.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/backend/utils.dart';
import 'dart:io';

enum Actions { AddCommentAction, GetCommentsAction }
Api api = Api();

class AddCommentAction {
  final Comment item;

  AddCommentAction(this.item);

}

class GetCommentsAction {
  List<Comment> list ;
  String postId;
  GetCommentsAction({this.list, this.postId});

}

class FinishGetCommentsAction {
  List<Comment> list ;
  String postId;
  FinishGetCommentsAction({this.list, this.postId});
}

class FinishAddCommentsAction {
  final Comment item;
  FinishAddCommentsAction({this.item });
}