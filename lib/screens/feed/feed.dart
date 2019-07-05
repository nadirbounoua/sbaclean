import 'package:flutter/material.dart';
import '../settings/settings.dart';
import '../../models/anomaly.dart';
import '../../backend/api.dart';
import 'widgets/post_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning2/models/app_state.dart';
import 'package:learning2/redux/actions.dart';
import 'package:learning2/redux/reducers.dart';
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
  bool loading = false;
  List<Anomaly> list;
  @override
  Widget build(BuildContext context){
    return StoreConnector<AppState,AppState>(
      converter: (store) =>  store.state,
      builder: (context,state) {

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
        body: PostList(posts: state.anomalies),
        );
      } 
    );
  }
}


