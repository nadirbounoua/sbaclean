import 'package:flutter/material.dart';
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
//void main() => runApp(Feed());
 
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
    void initState() {
      // TODO: implement initState
      super.initState();

        final getReactions = GetUserReactionAction([]);
        final getAnomalies = GetAnomaliesAction([]);
        
        MyApp.store.dispatch(getReactions.getReactions());
        MyApp.store.dispatch(getAnomalies.getAnomalies());
        
        Future.wait([
          getAnomalies.completer.future,
          getReactions.completer.future,
        ]).then((c)  {
                  
      });

      timer = Timer.periodic(Duration(seconds: 45), (Timer t) async  {
        bool changed = await api.copyWith(MyApp.store.state.userState.user.authToken)
                                .checkNewPosts(MyApp.store.state.feedState);

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
            ),
            IconButton(
              onPressed: () {
                _showMaterialSearch(context);
              },
              tooltip: 'Search',
              icon: new Icon(Icons.search),
            )],
        ),
        drawer: DrawerWidget(actualRoute: "Feed",),
        body: 
          Stack(
            alignment: Alignment.topCenter  ,
            children: store.state.feedState.postsChanged ? <Widget>[
              RefreshIndicator(
                key: _refreshIndicatorKey,
                child:PostList(posts: store.state.feedState.anomalies),
                color: Colors.blueAccent,
                onRefresh: () {
                  GetAnomaliesAction action = new GetAnomaliesAction(anomalies);
                  store.dispatch(action.getAnomalies());
                  return action.completer.future;
                }),
              PostsChangedNotification(store),
              
            ] :
            <Widget>[
              RefreshIndicator(
                key: _refreshIndicatorKey,
                child:PostList(posts: store.state.feedState.anomalies),
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
        ),
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {

            Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreenWidget()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.yellow
        ),
        );
      } 
    );
  }
  _showMaterialSearch(BuildContext context) {
    Navigator.of(context)
      .push(_buildMaterialSearchPage(context))
      .then((dynamic value) {
      });
  }

   _buildMaterialSearchPage(BuildContext context) {
    return new MaterialPageRoute<dynamic>(
      settings: new RouteSettings(
        name: 'material_search',
        isInitialRoute: false,
      ),
      builder: (BuildContext context) {
        return new Material(
          child: new MaterialSearch<dynamic>(
            placeholder: 'Search',
            getResults: (String criteria) async {
              if (criteria.isEmpty) {
                setState(() {
                 anomalies = [];
               });
              } else {
              var list = await api.copyWith(MyApp.store.state.userState.user.authToken)
                                  .queryPosts(criteria);
               setState(() {
                 anomalies = parseAnomalies(list);
               });
              }
              return anomalies.map((anomaly) => new MaterialSearchResult<dynamic>(
                value: anomaly, //The value must be of type <String>
                text: anomaly.post.title, //String that will be show in the list
                //icon: anomaly.imageUrl == "/media/images/default.png" ? Icons.image : ImageIcon(Image.network(src))
                //.network(anomaly.imageUrl ,width: 24, height: 24,)
              )).toList();
            },

            onSelect: (dynamic value) => Navigator.push(context, MaterialPageRoute(builder: (context) => AnomalyDetails(anomaly: value,))),
            onSubmit: (dynamic value) => Navigator.push(context, MaterialPageRoute(builder: (context) => AnomalyDetails(anomaly: value,))),
          ),
        );
      }
    );
  }



}


