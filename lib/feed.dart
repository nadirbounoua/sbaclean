import 'package:flutter/material.dart';
import 'main.dart';
import 'settings.dart';

void main() => runApp(Feed());


class Feed extends StatelessWidget {
  static const String _title = 'Signalements';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                semanticLabel: 'settings',
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
              },
            )
          ],
        ),
        body: PostPreview(),
      ),
    );
  }
}

class PostPreview extends StatelessWidget {
  PostPreview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                  decoration: new BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1))
                  ),
                  child: Icon(
                    Icons.image,
                    size: 100,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Accident de voiture',
                      style: new TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Text('Rue, Quartier, Wilaya, Algérie'),
                  ],
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    child: FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.comment,
                            size: 25,
                            color: Colors.white,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text('Commenter'),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                      },
                    ),
                  ),
                  FlatButton(
                    child: Icon(Icons.keyboard_arrow_up),
                    onPressed: () {/* ... */},
                  ),
                  FlatButton(
                    child: Icon(Icons.keyboard_arrow_down),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
