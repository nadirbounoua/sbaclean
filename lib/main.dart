import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sbaclean/middlewares/middlewares.dart';
import 'package:sbaclean/models/user.dart';
import 'package:sbaclean/screens/login/login_screen.dart';
import 'package:sbaclean/screens/main_screen.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/reducers/reducers.dart';
import 'package:redux/redux.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sbaclean/store/auth_state.dart';
//import 'package:sbaclean/store/middleware.dart';
void main() async {
  final directory = await getApplicationDocumentsDirectory();

  
  File persist;
  File(directory.path +'/loginFile.json').existsSync() ? null : File(directory.path +'/loginFile.json').createSync();
  persist = File(directory.path +'/loginFile.json');
  String content = persist.readAsStringSync();
  User user;
  content.length >0 ? user = User.fromJson(json.decode(content)) : null;
  print(user);
  AppState appState;
  user == null ? appState = AppState.newAppState() : appState =AppState.newAppState(auth: AuthState(isAuthenticated: true, user: user));
  final store = Store<AppState>(
    appStateReducers,
    initialState: appState,
    middleware: middlewares,
  );
  runApp(MyApp(store1: store,));
  // ...
}

class MyApp extends StatefulWidget{
  static var store;
  final store1;
  MyApp({this.store1});
  @override
  State<StatefulWidget> createState() {
    store = store1;
    return MyAppState(store: store);
  }
  
}

class MyAppState extends State<MyApp> {
  PageController _pageController;
  int _page = 0;
  Store<AppState> store;
  static const String _title = 'Flutter Code Sample';

  MyAppState({this.store});

  @override
  Widget build(BuildContext context) {
    return
      StoreProvider<AppState>(
        store:store , 
        child: MaterialApp(
      title: _title,
      routes: <String, WidgetBuilder>{
                '/': (BuildContext context) =>
                    new StoreConnector<AppState, dynamic>(
                        converter: (store) => store.state.auth.isAuthenticated,
                        builder: (BuildContext context, isAuthenticated) =>
                            isAuthenticated
                                ? new MainScreen()
                                : new LoginScreen()),
                '/login': (BuildContext context) => new LoginScreen(),
                '/main': (BuildContext context) => new MainScreen(),
      },
     /* home: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            FeedScreen(),
            Settings(),
            UserHistoryScreen(),
            FeedScreen(),
            FeedScreen(),
            FeedScreen(),

          ],
        ),*/
       /* bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Acceuil"),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.warning),
              title: Text("Anomalies"),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              title: Text("Evénement"),

            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,

        ),
      )*/

    )
    );

  }

    void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}