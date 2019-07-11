import 'package:sbaclean/models/comment.dart';

import '../models/app_state_comment.dart';
import '../models/comment.dart';
import 'actions_comment.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

//typedef OnSaveComment = Function(int commentOwner, int commentPost, String comentContent);

AppStateComment appStateReducers(AppStateComment state, dynamic action) {
  if (action is AddCommentAction) {
    return addComment(state.comments,action);
  }  
    return getComments(state.comments,action);
  
}

AppStateComment addComment(List<Comment> items, AddCommentAction action) {
  return AppStateComment(comments: List.from(items)..add(action.item));
}

AppStateComment getComments(List<Comment> items, GetCommentsAction action) {
  return AppStateComment(comments: List.from(action.list));
}

