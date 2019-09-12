import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/participation_actions.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/event.dart';
import 'package:sbaclean/models/participation.dart';
import 'package:sbaclean/store/app_state.dart';
import '../../../styles/colors.dart';

class EventPreview extends StatefulWidget {
    Event event;
    bool closed;
    EventPreview({this.event, this.closed});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EventPreviewState(event: event,closed: closed);
  }
  
}

class EventPreviewState extends State<EventPreview> {
  Event event;
  bool closed;

  EventPreviewState({Key key,  this.event,this.closed});
  bool _isButtonDisabled;

    @override
  void initState() {
    _isButtonDisabled = true;
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(event.starts_at).toLocal();
    String date = dateTime.year.toString() + "/"+ dateTime.month.toString()+'/'+ dateTime.day.toString();

    // TODO: implement build
    return StoreConnector<AppState, dynamic>(
        converter: (Store<AppState> store) {
      return (BuildContext context, String event) =>
              store.dispatch(addParticipation(context, store.state.auth.user.authToken,
                  new Participation(user: store.state.auth.user.id.toString(), event: event)));

    }, builder: (BuildContext context, addParticipationAction) {
      if(!closed){
        _isButtonDisabled = false;
      }
      else {
        _isButtonDisabled = true;
      }
      return Card(
      child:    Card(
      child:IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Image.network(
                     event.post.imageUrl,
                     width: MediaQuery.of(context).size.width/3,
                     height: MediaQuery.of(context).size.width/3,
                     fit: BoxFit.fill,
                     ),
        Expanded(
            child: Column(
            children: [
              Container(
                height: 2*MediaQuery.of(context).size.width/9,
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
                              event.post.title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
                                
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                            ),
                            Container(
                              child: Text(
                                event.post.description,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16
                              ),
                            ),
                            )
                          ],
                        ),
                         
                        Text(date,textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
        ],
      ),
    ),
  ),          
              Container(
                margin: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.width/9,
                  child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(event.max_participants.toString(),
                          style: TextStyle(
                            fontSize: 16
                          ),),
                        Padding(
                          padding: EdgeInsets.all(2),
                        ),
                        Icon(Icons.person,
                          size: 30, 
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),

                  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          
                          FlatButton(
                            color: colorStyles['primary'],
                            onPressed: () {
                              if (_isButtonDisabled) {
                              } else {
                                addParticipationAction(context,event.id.toString());
                                closed = true;
                              }
                            },
                            child: new Text(_isButtonDisabled
                                ? "Hold on..."
                                : "Participate"),
                          ),
                        ],
                      ),
                    
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                  ],
                ),
                  
                ],
              ),
                ),
            
            ]),
          ),
        ]),
      ),
    )
      );}
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
              event.post.title,
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
              event.starts_at,
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
                    event.post.description,
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
                    "Max Participant : " + event.max_participants.toString(),
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
                      print("you participate in this event");
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