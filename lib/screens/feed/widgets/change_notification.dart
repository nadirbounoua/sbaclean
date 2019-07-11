import 'package:flutter/material.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/feed_actions.dart';
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