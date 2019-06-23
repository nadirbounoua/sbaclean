import 'package:flutter/material.dart';
import 'screens/main/main.dart';
import 'package:learning2/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'redux/reducers.dart';
import 'package:redux_thunk/redux_thunk.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  final store = Store<AppState>(appStateReducers,
  initialState: AppState(anomalies: []),
  middleware: [thunkMiddleware]
  );
  @override
  Widget build(BuildContext context) {
    return
      StoreProvider<AppState>(
        store:store , 
        child:      MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
      ),
    )
    );

  }
}