import 'package:flutter/material.dart';
import '../settings/settings.dart';
import '../../models/anomaly.dart';
import '../../backend/api.dart';
import 'widgets/post_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning2/models/app_state.dart';
import 'package:learning2/redux/actions.dart';
import 'package:learning2/redux/reducers.dart';
import 'package:redux/redux.dart';
import 'dart:async';
import 'package:learning2/main.dart';
import 'package:learning2/screens/feed/widgets/change_notification.dart';
//void main() => runApp(Feed());
 
class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);
  static const String _title = 'Signalements';


  @override
  _FeedState createState() {
    // TODO: implement createState
    return _FeedState();
  }
}

class _FeedState extends State<Feed> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();
  bool loading = false;
  List<Anomaly> list;
  Timer timer;
  
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      timer = Timer.periodic(Duration(seconds: 10), (Timer t) async  {
        bool changed  = await api.checkNewPosts(MyApp.store);
        if (changed) MyApp.store.dispatch(new SetPostsChanged(changed: changed));
        });
    }

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
        appBar: AppBar(
          title: Text('Signalements'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                semanticLabel: 'settings',
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
              },
            )
          ],
        ),
        body: 
          Stack(
            alignment: Alignment.topCenter  ,
            children: store.state.postsChanged ? <Widget>[
              RefreshIndicator(
                key: _refreshIndicatorKey,
                child:PostList(posts: store.state.anomalies),
                color: Colors.blueAccent,
                onRefresh: () {
                  GetAnomaliesAction action = new GetAnomaliesAction(list);
                  store.dispatch(action.getAnomalies());
                  return action.completer.future;
                }),
              PostsChangedNotification(store),
              
            ] :
            <Widget>[
              RefreshIndicator(
                key: _refreshIndicatorKey,
                child:PostList(posts: store.state.anomalies),
                color: Colors.blueAccent,
                onRefresh: () {
                 final getReactions = GetUserReactionAction([]);
                          final getAnomalies = GetAnomaliesAction([]);
                          
                          store.dispatch(getReactions.getReactions());
                          store.dispatch(getAnomalies.getAnomalies());
                          
                          Future.wait([
                            getAnomalies.completer.future,
                            getReactions.completer.future,
                          ]).then((c)  {
                            
                });
                return getReactions.completer.future;
                }),              
            ],
          )
        
        );
      } 
    );
  }
}


