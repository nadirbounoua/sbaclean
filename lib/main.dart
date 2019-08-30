import 'package:flutter/material.dart';
import 'package:sbaclean/middlewares/feed_middleware.dart';
import 'screens/main/main.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/reducers/reducers.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/screens/feed/feed.dart';
import 'package:sbaclean/screens/user-history/user-history.dart';
import 'package:sbaclean/screens/settings/settings.dart';
//import 'package:sbaclean/store/middleware.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  static final  store = Store<AppState>(appStateReducers,
  initialState: AppState.newAppState(),
  middleware: feedMiddleware()
  );
  @override
  State<StatefulWidget> createState() => MyAppState(store: store);
  
  
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
      home: Scaffold(
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
        ),
        bottomNavigationBar: BottomNavigationBar(
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
      )

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