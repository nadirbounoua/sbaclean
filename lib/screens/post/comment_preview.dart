import 'package:flutter/material.dart';

class CommentPreview extends StatelessWidget {
  String commentOwner;
  String commentPost;
  String commentContent;
  CommentPreview({Key key,  this.commentOwner, this.commentPost, this.commentContent}) : super(key: key);     

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Text(
                    commentOwner,
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
                    commentPost,
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
                          commentContent,
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
            ],
          );
  }
}