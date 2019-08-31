import 'package:flutter/material.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/comment.dart';

class CommentLoading extends StatelessWidget {
  CommentLoading({Key key,}) : super(key: key);     

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
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],

                        borderRadius: BorderRadius.all(Radius.circular(50))),
                      width: MediaQuery.of(context).size.width / 1.6,
                      height: 15,
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
                        Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],

                        borderRadius: BorderRadius.all(Radius.circular(50))),
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 15,
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