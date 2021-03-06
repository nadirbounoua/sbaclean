import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/post.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/actions/feed_actions.dart';

getAnomalies(Store<AppState> store, List<Response> response ) async {
      List<Anomaly> anomalyList = await parseAnomalies(response);
      for (var anomaly in anomalyList) {
        for (var reaction in store.state.feedState.userReactions) {
          if (anomaly.post.id == reaction.post) anomaly.post.userReaction = reaction;
        }
      }
      store.dispatch(FinishGetAnomaliesAction(anomalies: anomalyList));

}

addAnomalyHelper(Store<AppState> store, dynamic response, Post post) async{
    Anomaly anomaly = await parseOneAnomalyPost(response);
    //final response = await api.getPosts();
    anomaly.post.owner = store.state.auth.user;
    store.dispatch(new FinishAddAnomalyAction(anomaly: anomaly));
}

getReactionsHelper(Store<AppState> store, String response) async{

    List<Reaction> list = await parseReaction(response);
    store.dispatch(FinishGetUserReactionAction(list: list));
}

setReactionHelper(Store<AppState> store, dynamic response, Anomaly anomaly){
    Reaction reaction = Reaction.fromJson(response);
    store.dispatch( new FinishSetReactionAction(anomaly:anomaly, reaction: reaction));
}

deleteReactionHelper(Store<AppState> store, Anomaly anomaly, Reaction reaction) {
    store.dispatch(new FinishDeleteReactionAction(anomaly: anomaly, reaction: reaction));

}

updateReactionHelper(Store<AppState> store, dynamic response, Anomaly anomaly, Reaction reaction) {
        reaction = Reaction.fromJson(response);
        store.dispatch( new FinishUpdateReactionAction(anomaly:anomaly, reaction: reaction));
}

refreshAnomaliesHelper(Store<AppState> store, List<Response> response ) async{
  List<Anomaly> anomalyList = await parseAnomalies(response);
      for (var anomaly in anomalyList) {
        for (var reaction in store.state.feedState.userReactions) {
          print(reaction);
          if (anomaly.post.id == reaction.post) anomaly.post.userReaction = reaction;
        }
      }
    Future.delayed(Duration(seconds: 3),()=>store.dispatch(FinishRefreshAnomaliesAction(anomalyList)));
}