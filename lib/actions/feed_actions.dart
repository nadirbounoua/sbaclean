import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/backend/utils.dart';
import 'dart:async';
import 'package:sbaclean/models/user.dart';
import 'package:sbaclean/models/post.dart';
import 'package:sbaclean/store/feed_state.dart';

Api api = Api();
class LoadAction{}

class FinishGetAnomaliesAction{
  List<Anomaly> anomalies;
  static Completer completer = Completer();
  FinishGetAnomaliesAction({this.anomalies});
}

class FinishAddAnomalyAction{
  Anomaly anomaly;
  FinishAddAnomalyAction({this.anomaly});
}

class FinishGetUserReactionAction{
  List<Reaction> list;
  FinishGetUserReactionAction({this.list});
}

class FinishSetReactionAction {
  Anomaly anomaly;
  Reaction reaction;
  final bool isLike; 
  FinishSetReactionAction({this.anomaly, this.reaction, this.isLike});

}



class FinishDeleteReactionAction {
  Anomaly anomaly;
  Reaction reaction;
  FinishDeleteReactionAction({this.anomaly, this.reaction});

}

class FinishUpdateReactionAction {
  Anomaly anomaly;
  Reaction reaction;
  FinishUpdateReactionAction({this.anomaly, this.reaction});

}
class AddAnomalyAction {
  final Post post;
  Anomaly anomaly;
  final User user;
  AddAnomalyAction({this.post, this.user, this.anomaly});

  ThunkAction<AppState> postAnomaly() {
  return (Store<AppState> store) async {

    final responsePost = await api.copyWith(store.state.userState.user.authToken)
                                  .createAnomaly(post,user);

    //store.dispatch(new GetAnomaliesAction([]).getAnomalies());

  };

}
}

class GetAnomaliesAction {
  final List<Anomaly> list;
  Completer completer=  new Completer();
  GetAnomaliesAction(this.list);

}

class RefreshAnomaliesAction {
  final List<Anomaly> list;
  Completer completer=  new Completer();
  RefreshAnomaliesAction(this.list);
}

class FinishRefreshAnomaliesAction {
  final List<Anomaly> list;
  static Completer completer=  new Completer();
  FinishRefreshAnomaliesAction(this.list);
}

class SetPostsChanged {
  final bool changed;
  SetPostsChanged({this.changed});
}

class SetReactionAction {
  Anomaly anomaly;
  Reaction reaction;
  final bool isLike; 
  SetReactionAction({this.isLike, this.anomaly, this.reaction});


}

class DeleteReactionAction {
  Anomaly anomaly;
  Reaction reaction;

  DeleteReactionAction({this.anomaly, this.reaction});

}

class UpdateReactionAction {
  Anomaly anomaly;
  Reaction reaction;

  UpdateReactionAction({this.anomaly, this.reaction});

}

class GetUserReactionAction {
  List<Reaction> list;
  Completer completer=  new Completer();
  GetUserReactionAction(this.list);

}

