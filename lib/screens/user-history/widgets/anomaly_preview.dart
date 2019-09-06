import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/screens/user-history/widgets/history_list.dart';
import '../../../styles/colors.dart';

class AnomalyHistoryPreview extends StatelessWidget  implements ListItem{
  Anomaly anomaly;
  int score;
  AnomalyHistoryPreview({Key key,  this.anomaly}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Column(
      children: <Widget>[
        Container(
      margin: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.width/4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        boxShadow: [
             BoxShadow(
              color: Colors.grey[300],
              blurRadius: 10.0,
            )
          ]
      ),
      
      child:IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Image.network(
                     anomaly.post.imageUrl,
                     width: MediaQuery.of(context).size.width/4,
                     height: MediaQuery.of(context).size.width/4,
                     fit: BoxFit.fill,
                     ),
        Expanded(
            child: Column(
            children: [
              Container(
                height: 2*MediaQuery.of(context).size.width/12,
                width: 2*MediaQuery.of(context).size.width/3,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child:
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              anomaly.post.title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(4),
                            ),
                            Container(
                              child: Text(
                                anomaly.post.description,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14
                              ),
                            ),
                            )
                          ],
                        ),
                         
                        Text(calculateTime(anomaly.post.createdAt),textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 14
                          ),
                        ),
        ],
      ),
    ),
  ),          
              Container(
                padding: EdgeInsets.all(4),
                height: MediaQuery.of(context).size.width/12,
                  child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8),
                        ),
                        Text(anomaly.post.comments.length.toString(),
                          style: TextStyle(
                            fontSize: 14
                          ),),
                        Padding(
                          padding: EdgeInsets.all(8),
                        ),
                        Icon(Icons.comment,
                          size: 24, 
                          color: Colors.grey,
                        ),
                         Padding(
                          padding: EdgeInsets.all(8),
                        ),
                        Text(anomaly.post.reactionsCount.toString(),

                          style: TextStyle(
                            fontSize: 14
                          ),),
                        Padding(
                          padding: EdgeInsets.all(8),
                        ),
                        Icon(Icons.show_chart,
                          size: 24, 
                          color: Colors.grey,
                        ),

                      ],
                    ),
                  ),

                  
                  
                ],
              ),
                ),
            
            ]),
          ),
        ]),
      ),
    
    
    )
      ],
    );
      
      }
}

/*Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Text(
              anomaly.post.title,
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
              anomaly.starts_at,
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
                    anomaly.post.description,
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
                    "Max Participant : " + anomaly.max_participants.toString(),
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
                  FlatButton(
                    color: colorStyles['primary'],
                    onPressed:() {
                      print("you participate in this anomaly");
                    },
                    child: new Text('Participate'),
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
    );*/