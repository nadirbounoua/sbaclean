import 'package:flutter/material.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/comment.dart';

class CommentPreview extends StatelessWidget {
  Comment comment;
  CommentPreview({Key key,  this.comment}) : super(key: key);     

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
                    comment.owner.username,
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
                    //DateTime.parse(created_at).subtract(DateTime.now().)
                    calculateTime(comment.created_at)
                    ,
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
                          comment.commentContent,
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