import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/feed_actions.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostPreview extends StatelessWidget {
  final Anomaly anomaly;
  PostPreview({Key key, this.anomaly}) : super(key: key);     

  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only( bottom: 20.0),
                  child: anomaly.imageUrl == "/media/images/default.png" ?
                  Icon(
                    Icons.image,
                    size: 100,              
                  ):
                  CachedNetworkImage(
                    imageUrl: anomaly.imageUrl,
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
                    store.state.feedState.anomalies
                    .firstWhere((e) => e.id == anomaly.id)
                    .reactions.length >0 ?
                    Text(
                      store.state.feedState.anomalies
                    .firstWhere((e) => e.id == anomaly.id)
                    .reactionsCount.toString(),
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
                        .userReaction != null ?
                         store.state.feedState.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .userReaction.isLike 
                         
                         ?  Colors.blue : Colors.grey : Colors.grey),
                      onPressed: () =>
                        store.state.feedState.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .userReaction != null ?
                        !store.state.feedState.anomalies
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
                        store.state.feedState.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .userReaction != null ?
                         ! store.state.feedState.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .userReaction.isLike 
                         
                         ?  Colors.black : Colors.grey : Colors.grey),
                      onPressed: () {
                        store.state.feedState.anomalies
                        .firstWhere((e) => e.id == anomaly.id)
                        .userReaction != null ?
                        store.state.feedState.anomalies
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
    );
  }

}