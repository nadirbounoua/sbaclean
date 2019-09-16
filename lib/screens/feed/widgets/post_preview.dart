import 'package:flutter/gestures.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:sbaclean/actions/report_actions.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/models/report.dart';
import 'package:sbaclean/models/user.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/store/user_state.dart';

import 'package:redux/redux.dart';
import 'package:toast/toast.dart';

import 'package:sbaclean/actions/feed_actions.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostPreview extends StatefulWidget {
  final Anomaly anomaly;
  bool reported;

  PostPreview({Key key, this.anomaly, this.reported}) : super(key: key);

   @override
  PostPreviewState createState() {
    return PostPreviewState(
        anomaly: this.anomaly,
        reported: this.reported
       );
  }
}

class PostPreviewState extends State<PostPreview> {
  final Anomaly anomaly;
  bool reported;
  bool _isButtonDisabled;
  PostPreviewState({Key key, this.anomaly, this.reported});

  @override
  void initState() {
    _isButtonDisabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
            converter: (Store<AppState> store) {
              return (BuildContext context, String anomaly) =>
                  store.dispatch(addReport(context, store.state.auth.user.authToken,
                      new Report(user: store.state.auth.user.id.toString(), anomaly: anomaly)));

            }, builder: (BuildContext context, addReportAction) { 
    return Center(
      child: Padding(
      padding: EdgeInsets.only(
        bottom: 8),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                     "assets/dopeman0x.jpeg",
                     width: 50,
                     height: 50,
                     ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 12
                      ),
                      child: 
                        Text(
                          anomaly.post.owner.username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ), 
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        right: 8
                      ),
                      child: Text(
                        calculateTime(anomaly.post.createdAt)
                      )
                  ),
                  IconButton(
                    icon: Icon(Icons.info,color: Colors.blueGrey),
                    onPressed: () {
                      print(reported.toString()+"-----------"+anomaly.id.toString());
                      if(!reported){
                        _isButtonDisabled = false;
                      }
                      else {
                        _isButtonDisabled = true;
                      }
                      if(_isButtonDisabled){
                        Toast.show("Already reported", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                      }
                      else {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Report Anomaly'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('You will report this anomaly.'),
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
                                  child: Text('Report'),
                                  onPressed: () {
                                    addReportAction(context,anomaly.id.toString());
                                    reported = true;
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },

                  ),
                ],
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: anomaly.post.imageUrl == "/media/images/default.png" ?
                  Icon(
                    Icons.image,
                    size: 100,              
                  ):
                  CachedNetworkImage(
                    placeholder: (context, string) => 
                      Container(color: Colors.grey[200],
                        height: MediaQuery.of(context).size.height *0.4,
                        width: MediaQuery.of(context).size.width -8,),
                    imageUrl: anomaly.post.imageUrl,
                    imageBuilder: (context, image) =>
                    Image(
                      image: image,
                      filterQuality: FilterQuality.low,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height *0.4,
                      width: MediaQuery.of(context).size.width - 8,
                      
                    )
                      
                  )


                ),
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
                            child: Text(anomaly.post.comments.length.toString()),
                          ),
                        ],
                      ),
                      onPressed: () {
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                      },
                    ),
                  ),
                  StoreConnector<AppState,Store<AppState>>(
                    converter: (store) => store,
                    builder: (context, store) => 
                    store.state.feedState.anomalies
                    .firstWhere((e) => e.id == anomaly.id)
                    .post.reactions.length >0 ?
                    Text(
                      store.state.feedState.anomalies
                    .firstWhere((e) => e.id == anomaly.id)
                    .post.reactionsCount.toString(),
                    style: TextStyle(color: Colors.blue),
                    ) : Text("")
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    child: StoreConnector<AppState,Store<AppState>>(
                      converter: (store) => store,
                      builder: (context,store) => 
                      IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_up, 
                        color: 
                        store.state.feedState.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .post.userReaction != null ?
                         store.state.feedState.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .post.userReaction.isLike 
                         
                         ?  Colors.blue : Colors.grey : Colors.grey),
                      onPressed: () =>
                        store.state.feedState.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .post.userReaction != null ?
                        !store.state.feedState.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .post.userReaction.isLike ? 
                          
                        store.dispatch(new UpdateReactionAction(anomaly: anomaly, reaction: anomaly.post.userReaction))
                        :store.dispatch( new DeleteReactionAction(anomaly: anomaly))
                        :store.dispatch(new SetReactionAction(anomaly: anomaly, reaction: Reaction(isLike: true, post: anomaly.post.id, reactionOwner: store.state.auth.user.id)))
                          
                        
                     
                    ),
                  ),
                    ),
                    
                    
                  Container(
                    padding: EdgeInsets.all(0),
                    child: StoreConnector<AppState,Store<AppState>>(
                      converter: (store) => store,
                      builder: (context,store) => 
                      IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down, 
                        color: 
                        store.state.feedState.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .post.userReaction != null ?
                         ! store.state.feedState.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .post.userReaction.isLike 
                         
                         ?  Colors.black : Colors.grey : Colors.grey),
                      onPressed: () {
                        store.state.feedState.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .post.userReaction != null ?
                        store.state.feedState.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .post.userReaction.isLike ?
                        store.dispatch(new UpdateReactionAction(anomaly: anomaly, reaction: anomaly.post.userReaction))
                        :store.dispatch( new DeleteReactionAction(anomaly: anomaly))
                        :store.dispatch(new SetReactionAction(anomaly: anomaly, reaction: Reaction(isLike: false, post: anomaly.post.id, reactionOwner: store.state.auth.user.id)));
                      },
                    ),
                  ),

                  )
                ],
              ),
          ],
        ),
      ),

    )
    );
  }
    );
  }

}
