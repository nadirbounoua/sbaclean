import 'package:flutter/material.dart';
import 'package:sbaclean/screens/event/widgets/add_event_screen.dart';
import '../settings/settings.dart';
import '../../models/anomaly.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/actions/feed_actions.dart';
import 'package:redux/redux.dart';
import 'dart:async';
import 'package:sbaclean/main.dart';
import 'package:sbaclean/screens/main/main.dart';
import 'package:sbaclean/screens/feed/widgets/change_notification.dart';
import 'package:sbaclean/screens/feed/widgets/post_list.dart';
import 'package:material_search/material_search.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/screens/anomaly_details/anomaly_details.dart';
import 'package:sbaclean/widgets/drawer/drawer.dart';
import 'package:unicorndial/unicorndial.dart';
//void main() => runApp(Feed());
import 'package:sbaclean/screens/feed/widgets/post_loading.dart';
 
class FeedScreen extends StatefulWidget {
  FeedScreen({Key key, this.anomalies, this.searchresult}) : super(key: key);
  static const String _title = 'Signalements';
  List<Anomaly> anomalies = [];
  bool searchresult;

  @override
  _FeedState createState() {
    // TODO: implement createState
    return _FeedState();
  }
}

class _FeedState extends State<FeedScreen> {
   _FeedState({this.anomalies,this.searchresult}); 
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();
  bool loading = false;
  List<Anomaly> anomalies = [];
  bool searchresult;
  Timer timer;
  Api api = Api();


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) =>  store,
      builder: (context,store) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.topCenter  ,
            children: store.state.feedState.postsChanged ? <Widget>[
              RefreshIndicator(
                key: _refreshIndicatorKey,
                child:PostList(posts: store.state.feedState.anomalies),
                color: Colors.blueAccent,
                onRefresh: () {
                  final getReactions = GetUserReactionAction([]);
                  final getAnomalies = RefreshAnomaliesAction([]);
                  FinishRefreshAnomaliesAction.completer = Completer();
                  store.dispatch(getReactions);
                  store.dispatch(getAnomalies);
                  
                  
                return FinishRefreshAnomaliesAction.completer.future;
                }),
              PostsChangedNotification(store),
              
            ] :
            <Widget>[
              RefreshIndicator(
                key: _refreshIndicatorKey,
                child: store.state.feedState.isAnomaliesLoading ?
                  ListView(children: <Widget>[
                    PostLoading(),
                    PostLoading(),
                    PostLoading()
                  ],
                  physics: NeverScrollableScrollPhysics(),
                  )
                  : 
                  PostList(posts: store.state.feedState.anomalies),
                color: Colors.blueAccent,
                onRefresh: () {
                  final getReactions = GetUserReactionAction([]);
                  final getAnomalies = RefreshAnomaliesAction([]);
                  FinishRefreshAnomaliesAction.completer = Completer();
                  store.dispatch(getReactions);
                  store.dispatch(getAnomalies);
                  
                  
                return FinishRefreshAnomaliesAction.completer.future;
                }),              
            ],
        ),
        
        floatingActionButton:UnicornDialer(
          parentButton: Icon(Icons.add),
          childButtons: <UnicornButton>[
            UnicornButton(
              hasLabel: true,
              labelText: "Ajouter une anomalie",
              labelHasShadow: true,
              labelBackgroundColor: Colors.grey[400],
              labelColor: Colors.black54,
              currentButton: FloatingActionButton(
                heroTag: 'btn1',
                mini: true,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreenWidget())),
                backgroundColor: Colors.orange[400],
                child: Icon(Icons.warning),
              ),
            ),
            UnicornButton(
              hasLabel: true,
              labelText: "Ajouter un événement",
              labelHasShadow: true,
              labelBackgroundColor: Colors.grey[400],
              labelColor: Colors.black54,
              currentButton: FloatingActionButton(
                heroTag: 'btn2',
                mini: true,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddEventScreen())),
                backgroundColor: Colors.red[400],
                child: Icon(Icons.event),
              ),
            )

          ],
        ),
        );
      },
      onDispose: (store) => timer.cancel(),
      onInit: (store)  {
        store.dispatch(GetUserReactionAction([]));
        store.dispatch(GetAnomaliesAction([]));
        timer = Timer.periodic(Duration(seconds: 45), (Timer t) async  {
        bool changed = await api.copyWith(MyApp.store.state.auth.user.authToken)
                                .checkNewPosts(MyApp.store.state.feedState);

        if (changed) store.dispatch(new SetPostsChanged(changed: changed));
        });
       // store.dispatch(action)
      },
    );
  }

}


