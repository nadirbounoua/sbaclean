import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/participation_actions.dart';
import 'package:sbaclean/actions/event_actions.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/event.dart';
import 'package:sbaclean/models/participation.dart';
import 'package:sbaclean/store/app_state.dart';
import '../../../styles/colors.dart';
import 'package:toast/toast.dart';

import '../../main_screen.dart';


class EventPreview extends StatefulWidget {
  Event event;
  bool closed;
  bool test_user;
  EventPreview({this.event, this.closed, this.test_user});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EventPreviewState(
        event: event, closed: closed, test_user: test_user);
  }
}

class EventPreviewState extends State<EventPreview> {
  Event event;
  bool closed;
  bool test_user;

  EventPreviewState({Key key, this.event, this.closed, this.test_user});
  bool _isButtonDisabled;

  @override
  void initState() {
    _isButtonDisabled = true;
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(event.starts_at).toLocal();
    String date = dateTime.year.toString() +
        "/" +
        dateTime.month.toString() +
        '/' +
        dateTime.day.toString();

    // TODO: implement build
    return StoreConnector<AppState, dynamic>(
        converter: (Store<AppState> store) {
      return (BuildContext context, String event) => store.dispatch(
          addParticipation(
              context,
              store.state.auth.user.authToken,
              new Participation(
                  user: store.state.auth.user.id.toString(), event: event)));
    }, builder: (BuildContext context, addParticipationAction) {
      if (!closed) {
        _isButtonDisabled = false;
      } else {
        _isButtonDisabled = true;
      }
      return Card(
          child: Card(
        child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Image.network(
              event.post.imageUrl,
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 3,
              fit: BoxFit.fill,
            ),
            Expanded(
              child: Column(children: [
                Container(
                  height: 2 * MediaQuery.of(context).size.width / 9,
                  width: 2 * MediaQuery.of(context).size.width / 3,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            StoreConnector<AppState, dynamic>(
                                converter: (Store<AppState> store) {
                                  return (BuildContext context, Event event) =>
                                      store.dispatch(removeEvent(
                                          context,
                                          store.state.auth.user.authToken,
                                           event
                                          ));
                                }, builder: (BuildContext context,
                                removeEventAction) {
                           return  Row(
                            children: <Widget>[
                              Text(
                                event.post.owner.username,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              /*IconButton(
                                  icon: Icon(Icons.delete,color: Colors.black54)
                                  , onPressed: (){
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete Event'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text('You will delete this event.'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('Delete'),
                                          onPressed: () {
                                            removeEventAction(
                                                context, event);
                                            Toast.show("Removed Successfuly", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );


                              })*/
                            ],
                            );}),
                            Padding(
                              padding: EdgeInsets.all(8),
                            ),
                            Container(
                              child: Text(
                                event.post.description,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        Text(
                          date,
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.width / 9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              event.max_participants.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2),
                            ),
                            Icon(
                              Icons.person,
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
                          StoreConnector<AppState, dynamic>(
                              converter: (Store<AppState> store) {
                            return (BuildContext context, String event) =>
                                store.dispatch(removeParticipation(
                                    context,
                                    store.state.auth.user.authToken,
                                    new Participation(
                                        user:
                                            store.state.auth.user.id.toString(),
                                        event: event)));
                          }, builder: (BuildContext context,
                                  removeParticipationAction) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                FlatButton(
                                  color: colorStyles['primary'],
                                  onPressed: () {
                                    if (test_user) {
                                      removeParticipationAction(
                                          context, event.id.toString());
                                      test_user = false;
                                      closed = false;
                                    } else {
                                      if (_isButtonDisabled) {
                                      } else {
                                        addParticipationAction(
                                            context, event.id.toString());
                                        test_user = true;
                                        closed = true;
                                      }
                                    }
                                  },
                                  child: new Text(test_user
                                      ? "Annuller participation"
                                      : _isButtonDisabled
                                          ? "closed"
                                          : "Participate", 
                                          style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            );
                          }),
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
      ));
    });
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
