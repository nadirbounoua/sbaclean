import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart' as prefix0;
import 'package:sbaclean/actions/anomaly_details_actions.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/middlewares/middlewares.dart';
import 'package:sbaclean/models/user.dart';
import 'package:sbaclean/screens/anomaly_details/anomaly_details.dart';
import 'package:sbaclean/screens/login/login_screen.dart';
import 'package:sbaclean/screens/main_screen.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/reducers/reducers.dart';
import 'package:redux/redux.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sbaclean/store/auth_state.dart';
import 'actions/auth_actions.dart';
import 'backend/utils.dart';
import 'models/anomaly.dart';
import 'models/post.dart';
import 'projectSettings.dart' as ProjectSettings;
import 'dart:async';
import 'package:background_fetch/background_fetch.dart';
import 'package:http/http.dart' as http;

Timer timer;
void backgroundFetchHeadlessTask() async {
  double latitude;
  double longitude;
    print('[BackgroundFetch] Headless event received.');
   await Geolocator().getCurrentPosition().then((position) {
     latitude = position.latitude;
     longitude = position.longitude;
   });
   await http.post(ProjectSettings.apiUrl+"/api/v1/notification/send_notification/", body: {
     "latitude" : latitude.toString(),
     "longitude" : longitude.toString(),
     "distance" : 1.toString(),
     "postId" : 1.toString()
   });
   BackgroundFetch.finish();
}



Future<void> initPlatformState(Store<AppState> store) async {
      Api api = Api();
      await OneSignal.shared
              .init(ProjectSettings.oneSignalAppId);
      OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

      OneSignal.shared.setRequiresUserPrivacyConsent(true);

      OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
        
          print("notification" + notification.payload.additionalData.toString());
        
      });

      OneSignal.shared
          .setNotificationOpenedHandler((OSNotificationOpenedResult result) async {
            String anomalyResponse = await api.copyWith(store.state.auth.user.authToken)
                .getOneAnomaly(result.notification.payload.additionalData['id'] as int);
            Anomaly anomaly = parseOneAnomaly(anomalyResponse);
            Response postResponse = await api.copyWith(store.state.auth.user.authToken)
                .getPost(anomaly.postId);
            Post post = parseOnePost(postResponse.body);
            anomaly.post = post;
            await api.copyWith(store.state.auth.user.authToken)
              .getUserPostReaction(anomaly.post.id, store.state.auth.user.id)
              .then((response) {
                 anomaly.post.userReaction = parseOneReaction(response);
            });
            GetUserPostReactionAction getUserPostReactionAction= GetUserPostReactionAction(anomaly: anomaly);
            store.dispatch(getUserPostReactionAction);
            MyApp.navigatorKey.currentState.pushNamed('anomalyDetail',arguments: anomaly);
      });

      OneSignal.shared
      .setInAppMessageClickedHandler((OSInAppMessageAction action) {
        
      });

      OneSignal.shared
          .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
        print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
        store.dispatch(SetUserOneSignalIdAction(id :changes.to.userId));
      });

      OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
        print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
      });

      OneSignal.shared.setEmailSubscriptionObserver(
          (OSEmailSubscriptionStateChanges changes) {
        print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
      });

      // NOTE: Replace with your own app ID from https://www.onesignal.com
      

      OneSignal.shared
          .setInFocusDisplayType(OSNotificationDisplayType.notification);

      // Some examples of how to use In App Messaging public methods with OneSignal SDK

  }

Future<void> initPlatformStateBackground() async {
  // Configure BackgroundFetch.
  BackgroundFetch.configure(BackgroundFetchConfig(
      minimumFetchInterval: 15,
      stopOnTerminate: false,
      enableHeadless: true
  ), () async {
    // This is the fetch-event callback.
    print('[BackgroundFetch] Event received');
    // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
    // for taking too long in the background.
    backgroundFetchHeadlessTask();
    BackgroundFetch.finish();
  });
}

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
  await initPlatformState(store);
 // await connectToService();
  //await startBackgroundTask();

  runApp(MyApp(store1: store,));
    BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

  // ...
}

class MyApp extends StatefulWidget{
  static var store;
  static GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

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
          navigatorKey: MyApp.navigatorKey,
          onGenerateRoute: (routeSetting) {
            switch (routeSetting.name) {
              case 'anomalyDetail':{

                return MaterialPageRoute(builder: (context) => AnomalyDetails(anomaly: routeSetting.arguments,));

              }
                
               default:
                return MaterialPageRoute(builder: (context) => MainScreen());
            }
          },
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
    initPlatformStateBackground();
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