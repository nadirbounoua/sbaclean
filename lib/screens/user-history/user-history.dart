/*import 'package:flutter/material.dart';
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
        return ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                EntryItem(data[index]),
            itemCount: data.length,
          
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
*/