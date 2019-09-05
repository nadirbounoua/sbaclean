import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../containers/profile_page.dart';

import 'package:sbaclean/styles/colors.dart';
import 'package:sbaclean/actions/auth_actions.dart';
import 'package:sbaclean/store/app_state.dart';
import '../models/profile.dart';
import 'settings/settings.dart';
import '../models/user.dart';
import '../screens/event/event_screen.dart';
import '../actions/event_actions.dart';
import 'user_ranking/user_ranking_screen.dart'; 
class MainDrawer extends StatelessWidget {

    MainDrawer({Key key}): super(key: key);
    Profile pro = new Profile();


    @override
    Widget build(BuildContext context) {
        return new StoreConnector<AppState, dynamic>(
            converter: (store) => (BuildContext context) { store.dispatch(logout(context)); },
            builder: (BuildContext context, logout) =>
            new Drawer(
                child: new ListView(
                    children: <Widget>[
                    new Container(
                        height: 120.0,
                        child: new DrawerHeader(
                        padding: new EdgeInsets.all(0.0),
                        decoration: new BoxDecoration(
                            color: new Color(0xFFECEFF1),
                        ),
                        child: new Center(
                            child: new FlutterLogo(
                            colors: colorStyles['primary'],
                            size: 54.0,
                            ),
                        ),
                        ),
                    ),
                    new ListTile(
                        leading: new Icon(Icons.account_circle),
                        title: new Text('Profile'),
                        onTap: () => {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage()),
                          )
                        }
                    ),
                      new ListTile(
                          leading: new Icon(Icons.grade),
                          title: new Text('Ranking'),
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserRankingScreen()),
                            )
                          }
                      ),
                    new ListTile(
                        leading: new Icon(Icons.build),
                        title: new Text('Settings'),
                        onTap: () =>  {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Settings()),
                          )
                        }
                    ),

                    new ListTile(
                        leading: new Icon(Icons.info),
                        title: new Text('About'),
                        onTap: () =>  {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EventScreen()),
                          )
                        }
                    ),
                    new Divider(),
                    new ListTile(
                        leading: new Icon(Icons.exit_to_app),
                        title: new Text('Sign Out'),
                        onTap: () => logout(context)
                    ),
                    ],
                )
            )
        );
    }

}