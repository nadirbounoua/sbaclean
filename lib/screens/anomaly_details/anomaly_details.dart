import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:learning2/models/anomaly.dart';
import 'package:learning2/models/reaction.dart';
import 'package:learning2/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:learning2/redux/actions.dart';

class AnomalyDetails extends StatelessWidget {
  final Anomaly anomaly;
  AnomalyDetails({Key key, this.anomaly}) : super(key: key);     

  

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
        ),
        body:Center(
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
                  child: anomaly.imageUrl == "/media/images/default.png" ?
                  Icon(
                    Icons.image,
                    size: 100,
                  ):
                  Image.network(anomaly.imageUrl,width: 100, height: 100,)
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(anomaly.title
                      ,
                      style: new TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Text(anomaly.description),
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
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                      },
                    ),
                  ),
                  StoreConnector<AppState,Store<AppState>>(
                    converter: (store) => store,
                    builder: (context, store) => 
                    store.state.anomalies
                    .firstWhere((e) => e.id == anomaly.id)
                    .reactions.length >0 ?
                    Text(
                      store.state.anomalies
                    .firstWhere((e) => e.id == anomaly.id)
                    .reactions.length.toString(),
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
                        store.state.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .userReaction != null ?
                         store.state.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .userReaction.isLike 
                         
                         ?  Colors.blue : Colors.grey : Colors.grey),
                      onPressed: () =>
                        store.state.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .userReaction != null ?
                        !store.state.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .userReaction.isLike ? 
                          
                        store.dispatch(new UpdateReactionAction(anomaly: anomaly, reaction: anomaly.userReaction).updateReaction())
                        :store.dispatch( new DeleteReactionAction(anomaly: anomaly).deleteReaction())
                        :store.dispatch(new SetReactionAction(anomaly: anomaly, reaction: Reaction(isLike: true, post: anomaly.id, reactionOwner: 1)).setLike())
                          
                        
                     
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
                        store.state.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .userReaction != null ?
                         ! store.state.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .userReaction.isLike 
                         
                         ?  Colors.black : Colors.grey : Colors.grey),
                      onPressed: () {
                        store.state.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .userReaction != null ?
                        store.state.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .userReaction.isLike ?
                        store.dispatch(new UpdateReactionAction(anomaly: anomaly, reaction: anomaly.userReaction).updateReaction())
                        :store.dispatch( new DeleteReactionAction(anomaly: anomaly).deleteReaction())
                        :store.dispatch(new SetReactionAction(anomaly: anomaly, reaction: Reaction(isLike: false, post: anomaly.id, reactionOwner: 1)).setLike());
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

}