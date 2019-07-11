import 'package:flutter/material.dart';
import 'package:sbaclean/widgets/drawer/drawer.dart';

void main() => runApp(Settings());

class Settings extends StatelessWidget {
  static const String _title = "Paramètres";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        drawer: DrawerWidget(actualRoute: "Settings",),
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: SettingsList(),
      ),
    );
  }
}

class SettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            child: const Text("Compte", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Compte()));
            },
          ),
          FlatButton(
            child: const Text("Général", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),),
            onPressed: () {},
          ),
          FlatButton(
            child: const Text("Notifications", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),),
            onPressed: () {},
          ),
          FlatButton(
            child: const Text("Aide", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class Compte extends StatelessWidget {
  static const String _title = 'Mon compte';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: CompteForm(),
      ),
    );
  }


}

class CompteForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Prénom',
              labelStyle: TextStyle(color: Colors.blue),
              contentPadding: EdgeInsets.only(top: 50),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nom',
              labelStyle: TextStyle(color: Colors.blue),
              contentPadding: EdgeInsets.only(top: 50),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Biographie',
              labelStyle: TextStyle(color: Colors.blue),
              contentPadding: EdgeInsets.only(top: 50),
            ),
          ),
          ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Annuler'),
                  onPressed: () {
//                    Navigator.push(context, Material)
                  },
                ),
                FlatButton(
                  child: const Text('Sauvegarder'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}