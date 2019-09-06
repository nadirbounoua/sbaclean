import 'package:flutter/material.dart';
import 'package:sbaclean/screens/feed/feed.dart';
import 'package:sbaclean/screens/settings/settings.dart';
import 'package:sbaclean/screens/user-history/user-history.dart';

class DrawerWidget extends StatelessWidget {

  String actualRoute;
  DrawerWidget({this.actualRoute});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text("Header"),
            decoration: BoxDecoration(
              color: Colors.blue
            ),  
          ),
          ListTile(
            title: Text("Fil d'actualité"),
            onTap: () {
              navigate(context, actualRoute, "Feed", FeedScreen());
            },
          ),
          ListTile(
            title: Text("Paramétres"),
            onTap: () {
              navigate(context, actualRoute, "Settings", Settings());

            },
          ),
          ListTile(
            title: Text("Se déconnecter"),
          )
        ],
      ),
    );
  }

  navigate(BuildContext context,String actualRoute, String title, Widget route) {
    if (actualRoute != title) {
      Navigator.pop(context);
      Navigator.push(context, new MaterialPageRoute(builder: (context) => route));
    }
  }
}