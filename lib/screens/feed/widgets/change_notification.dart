import 'package:flutter/material.dart';
import 'package:learning2/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:learning2/redux/actions.dart';
class PostsChangedNotification extends StatelessWidget {
  Store<AppState> store;
  PostsChangedNotification(this.store);
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Container(

        child:RaisedButton(
          child: Text('Nouvelles publications...'),
          onPressed: () => store.dispatch(new GetAnomaliesAction([]).getAnomalies()),
          color: Colors.blueAccent,
          elevation: 1.0,
          
        ) ,
        );
    }
}