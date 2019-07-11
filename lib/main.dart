import 'package:flutter/material.dart';
import 'screens/main/main.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/reducers/reducers.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/screens/feed/feed.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  static final  store = Store<AppState>(appStateReducers,
  initialState: AppState.newAppState(),
  middleware: [thunkMiddleware]
  );
  @override
  Widget build(BuildContext context) {
    return
      StoreProvider<AppState>(
        store:store , 
        child:      MaterialApp(
      title: _title,
      home: FeedScreen(),
      
    )
    );

  }
}