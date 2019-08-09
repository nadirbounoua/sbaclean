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

  ThunkAction<AppState> addComment() {
    return (Store<AppState> store) async {
      final responseComment = await api.copyWith(store.state.userState.user.authToken).createComment(item);
      store.dispatch(new AddCommentAction(item));
    };
  }
}

class GetCommentsAction {
  List<Comment> list ;
  String postId;
  GetCommentsAction({this.list, this.postId});

  ThunkAction<AppState> getComments() {
    return (Store<AppState> store) async {
      final response = await api.copyWith(store.state.userState.user.authToken).getComments(postId);
      List<Comment> commentList = parseComment(response);
      store.dispatch(new GetCommentsAction(list: commentList).getComments());
    };
  }
}
