import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/backend/utils.dart';
import 'dart:async';
import 'package:sbaclean/models/user.dart';

import 'package:sbaclean/store/feed_state.dart';

Api api = Api();
class AddAnomalyAction {
  final Anomaly anomaly;
  final User user;
  AddAnomalyAction({this.anomaly, this.user});

  ThunkAction<AppState> postAnomaly() {
  return (Store<AppState> store) async {

    final responsePost = await api.copyWith(store.state.userState.user.authToken)
                                  .createPost(anomaly,user);
    //final response = await api.getPosts();
    store.dispatch(new AddAnomalyAction(anomaly: anomaly));

    //store.dispatch(new GetAnomaliesAction([]).getAnomalies());

  };

}
}

class GetAnomaliesAction {
  final List<Anomaly> list;
  Completer completer=  new Completer();
  GetAnomaliesAction(this.list);

  ThunkAction<AppState> getAnomalies() {
    return (Store<AppState> store) async {
      final response = await api.copyWith(store.state.userState.user.authToken)
                                .getPosts();
      List<Anomaly> anomalyList = parsePost(response);
      for (var anomaly in anomalyList) {
        for (var reaction in store.state.feedState.userReactions) {
          if (anomaly.id == reaction.post) anomaly.userReaction = reaction;
        }
      }
      store.dispatch(new GetAnomaliesAction(anomalyList));
      completer.complete();
    };
  }
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

  ThunkAction<AppState> setLike() {
    return (Store<AppState> store) async {
      print("Action" + reaction.toString());
      var response = await api.copyWith(store.state.userState.user.authToken)
                              .setReactionPost(anomaly, reaction);
      reaction = Reaction.fromJson(response);
      print(response);
      store.dispatch( new SetReactionAction(anomaly:anomaly, reaction: reaction));
    };
  }
}

class DeleteReactionAction {
  Anomaly anomaly;
  Reaction reaction;

  DeleteReactionAction({this.anomaly, this.reaction});

  ThunkAction<AppState> deleteReaction() {
    return (Store<AppState> store) async {
        reaction = anomaly.userReaction;
        await api.copyWith(store.state.userState.user.authToken)
                  .deleteReaction(reaction);
        store.dispatch(new DeleteReactionAction(anomaly: anomaly, reaction: reaction));
    };
  }
}

class UpdateReactionAction {
  Anomaly anomaly;
  Reaction reaction;

  UpdateReactionAction({this.anomaly, this.reaction});

  ThunkAction<AppState> updateReaction() {
    return (Store<AppState> store) async {
        reaction = anomaly.userReaction;
        reaction.isLike = !reaction.isLike;
        var response = await  api.copyWith(store.state.userState.user.authToken)
                                  .updateReaction(reaction);
        print(reaction);
        reaction = Reaction.fromJson(response);
        store.dispatch( new UpdateReactionAction(anomaly:anomaly, reaction: reaction));

    };
  }
}

class GetUserReactionAction {
  List<Reaction> list;
  Completer completer=  new Completer();
  GetUserReactionAction(this.list);

  ThunkAction<AppState> getReactions() {
    return (Store<AppState> store) async {
      final response = await api.copyWith(store.state.userState.user.authToken)
                                .getUserReaction(1);
      list = parseReaction(response);
      store.dispatch(new GetUserReactionAction(list));
      completer.complete();
    };
  }
}

