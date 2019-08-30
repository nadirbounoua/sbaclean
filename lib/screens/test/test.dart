import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/feed_actions.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/widgets/drawer/drawer.dart';
import 'package:sbaclean/reducers/reducers.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/middlewares/feed_middleware.dart';

void main() => runApp(Test());

class Test extends StatefulWidget {
    static final  store = Store<AppState>(appStateReducers,
  initialState: AppState.newAppState(),
  middleware: feedMiddleware()
  
  );
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestState(store: store);
  }

}

class TestState extends State<Test> {
  Store<AppState> store;

  TestState({this.store});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreProvider(
      store: store,
      child: MaterialApp(
        home: Scaffold(
          body: StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store){
        return Container(color: Colors.amber, width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            store.state.isLoading ? CircularProgressIndicator() : Text("done"),
         
          ],
        ),
        );
      },
      onInit: (store) => {
        store.dispatch(GetAnomaliesAction([]))
      },
    ),
   
        ),
      )

       );
    
      
  }

}