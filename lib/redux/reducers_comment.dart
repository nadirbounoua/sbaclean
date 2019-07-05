import 'package:learning2/models/comment.dart';

import '../models/app_state_comment.dart';
import '../models/comment.dart';
import 'actions_comment.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:geolocator/geolocator.dart';


AppStateComment appStateReducers(AppStateComment state, dynamic action) {
  if (action is AddCommentAction) {
    return addItem(state.comments,action);
  }  
    return getComments(state.comments,action );
  
}

AppStateComment addItem(List<Comment> items, AddCommentAction action) {
  return AppStateComment(comments: List.from(items)..add(action.item));
}

AppStateComment getComments(List<Comment> items, GetCommentsAction action) {
  return AppStateComment(comments: List.from(action.list));
}

