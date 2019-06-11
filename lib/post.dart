import 'package:flutter/material.dart';

void main() => runApp(Post());

class Post extends StatelessWidget {
  static String _title = "Login";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: PostWidget(),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  PostWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Commentaires",
              style: TextStyle(
                fontSize: 30,
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Text(
              "Nom Prénom",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
            ),
            Text(
              "•",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
            ),
            Text(
              "9h",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            new Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 6),
                  ),
                  Text(
                  "Lorem ipsum dolor sit amet, est iaculis mi pede vehicula mauris ut, nibh vestibulum pede curabitur lectus est dolor. Ligula praesent,"
                      " nonummy sem sed velit etiam, nunc harum eu ipsum magnis praesent sagittis,"
                      " facilisis eu, odio condimentum volutpat.",
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Text(
              "Nom Prénom",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
            ),
            Text(
              "•",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
            ),
            Text(
              "9h",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            new Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 6),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, est iaculis mi pede vehicula mauris ut, nibh vestibulum pede curabitur lectus est dolor. Ligula praesent,"
                        " nonummy sem sed velit etiam, nunc harum eu ipsum magnis praesent sagittis,"
                        " facilisis eu, odio condimentum volutpat.",
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Text(
              "Nom Prénom",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
            ),
            Text(
              "•",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
            ),
            Text(
              "9h",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            new Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 6),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, est iaculis mi pede vehicula mauris ut, nibh vestibulum pede curabitur lectus est dolor. Ligula praesent,"
                        " nonummy sem sed velit etiam, nunc harum eu ipsum magnis praesent sagittis,"
                        " facilisis eu, odio condimentum volutpat.",
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        Divider(
          color: Colors.grey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Text(
              "Nom Prénom",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
            ),
            Text(
              "•",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
            ),
            Text(
              "9h",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            new Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 6),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, est iaculis mi pede vehicula mauris ut, nibh vestibulum pede curabitur lectus est dolor. Ligula praesent,"
                        " nonummy sem sed velit etiam, nunc harum eu ipsum magnis praesent sagittis,"
                        " facilisis eu, odio condimentum volutpat.",
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),

          ],
        ),
      ],
    );
  }
}