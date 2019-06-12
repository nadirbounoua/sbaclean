

import 'package:flutter/material.dart';
import '../../main/main.dart';

class PostPreview extends StatelessWidget {
  String title;
  String description;
  PostPreview({Key key,  this.title, this.description}) : super(key: key);     

  

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
                    Text(title
                      ,
                      style: new TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Text(description),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      padding: EdgeInsets.only(left: 10),
                      textColor: Colors.grey,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.comment,
                            size: 25,
                            color: Colors.grey,
                          ),
                          Container(
                            child: Text('124 Commentaires'),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                      },
                    ),
                  ),
                  Text(
                    "2493",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_up, color: Colors.blue),
                      onPressed: () {/* ... */},
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      onPressed: () {/* ... */},
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

}