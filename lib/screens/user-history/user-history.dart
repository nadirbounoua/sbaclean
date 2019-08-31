import 'package:flutter/material.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/screens/user-history/widgets/item.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/main.dart';
import 'package:sbaclean/actions/user_history_actions.dart';
import 'package:sbaclean/widgets/drawer/drawer.dart';

class UserHistoryScreen extends StatefulWidget {
  

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserHistoryState();
  }
}

class _UserHistoryState extends State<UserHistoryScreen> {
List<Entry> data = [];

@override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) {

        data = <Entry>[
          Entry(
            title: store.state.userHistoryState.isLoading ? 
              Row(
                children: <Widget>[
                  SizedBox(
                    child:CircularProgressIndicator(
                      strokeWidth: 2.5, 
                      backgroundColor: Colors.white,
                      ),
                    height: 20,
                    width: 20,
                    ),Padding(padding: EdgeInsets.all(8),),Text('Anomalies')],) 
                : Text('Anomalies'),
            children: <Anomaly> [

            ]
            )
        ];
        data[0].children = store.state.userHistoryState.userPosts;
        return Scaffold(
          //drawer: DrawerWidget(actualRoute: "History",),
          appBar: AppBar(
            title: const Text('Votre historique'),
          ),
          body: ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                EntryItem(data[index]),
            itemCount: data.length,
          ),
      );
      },
      onDidChange: (store) {
      
      },
      onInit: (store) {
        store.dispatch(GetUserAnomaliesHistoryAction(list: []));


      },
    );
      
    
  }
  
}
// One entry in the multilevel list displayed by this app.


// The entire multilevel list displayed by this app.

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.


void main() {
  runApp(UserHistoryScreen());
}
