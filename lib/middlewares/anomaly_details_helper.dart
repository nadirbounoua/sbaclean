import 'package:redux/redux.dart';
import 'package:sbaclean/actions/anomaly_details_actions.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/comment.dart';
import 'package:sbaclean/store/app_state.dart';

getCommentsHelper(Store<AppState> store, dynamic response){
  print(response);
  List<Comment> commentList = parseComment(response);
  Future.delayed(Duration(seconds: 3), () => store.dispatch(new FinishGetCommentsAction(list: commentList)));

}
addCommentHelper(Store<AppState> store, dynamic response){
  
  Comment comment = createCommentFromJsonPost(response);
  store.dispatch(new FinishAddCommentsAction(item: comment));

}

