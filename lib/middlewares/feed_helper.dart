import 'package:redux/redux.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/post.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/actions/feed_actions.dart';

getAnomalies(Store<AppState> store, String response ) async {
    
      List<Anomaly> anomalyList = parseAnomalies(response);
      for (var anomaly in anomalyList) {
        for (var reaction in store.state.feedState.userReactions) {
          if (anomaly.post == reaction.post) anomaly.post.userReaction = reaction;
        }
      }
      Future.delayed(Duration(seconds: 3),()=> store.dispatch(FinishGetAnomaliesAction(anomalies: anomalyList)));

}

addAnomalyHelper(Store<AppState> store, String response, Post post) async{
    Anomaly anomaly = await parseOneAnomaly(response);
    //final response = await api.getPosts();
    store.dispatch(new AddAnomalyAction(post: post, anomaly: anomaly));
}