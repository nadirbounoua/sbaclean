import 'package:sbaclean/models/comment.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/store/comment_state.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/backend/utils.dart';
import 'dart:io';

enum Actions { AddCommentAction, GetCommentsAction }
Api api = Api();

class AddCommentAction {
  final Comment item;

  AddCommentAction(this.item);

  ThunkAction<AppStateComment> addComment() {
    return (Store<AppStateComment> store) async {
      final responseComment = await api.createComment(item);
      store.dispatch(new AddCommentAction(item));
    };
  }
}

class GetCommentsAction {
  final List<Comment> list;
  GetCommentsAction(this.list);

  ThunkAction<AppStateComment> getComments() {
    return (Store<AppStateComment> store) async {
      final response = await api.getComments();
      List<Comment> commentList = parseComment(response);
      store.dispatch(new GetCommentsAction(commentList));
    };
  }
}