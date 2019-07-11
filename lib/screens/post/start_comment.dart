import 'package:flutter/material.dart';
import 'package:sbaclean/models/app_state_comment.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sbaclean/screens/post/post.dart';
import 'package:redux/redux.dart';
import '../../redux/reducers_comment.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../post/middle.dart';
import 'comment_input.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Comments';
  final store = Store<AppStateComment>(appStateReducers,
      initialState: AppStateComment(), middleware: [thunkMiddleware]);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppStateComment>(
      store: store,
      child: MaterialApp(
        title: _title,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Add Comment"),
          ),
          body: Center(
            child: Column(
              children: <Widget>[Comments()],
            ),
          ),
        ),
      ),
    );
  }
}
