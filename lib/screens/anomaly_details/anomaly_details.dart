import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:sbaclean/actions/anomaly_details_actions.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/screens/anomaly_details/widgets/comment_input.dart';
import 'package:sbaclean/screens/anomaly_details/widgets/comment_list.dart';
import 'package:sbaclean/screens/anomaly_details/widgets/comment_loading.dart';
import 'package:sbaclean/store/anomaly_details_state.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/feed_actions.dart';
import 'package:sbaclean/main.dart';

class AnomalyDetails extends StatefulWidget {
  final Anomaly anomaly;
  AnomalyDetails({Key key, this.anomaly}) : super(key: key);

  @override
  AnomalyDetailsScreenState createState() => AnomalyDetailsScreenState(anomaly: anomaly);


}

class AnomalyDetailsScreenState extends State<AnomalyDetails> {
   Anomaly anomaly;

  AnomalyDetailsScreenState({this.anomaly});

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
        ),
        body:Center(
        child: Card(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  decoration: new BoxDecoration(
                  ),
                  child: anomaly.post.imageUrl == "/media/images/default.png" ?
                  Icon(
                    Icons.image,
                    size: 100,
                  ):
                  CachedNetworkImage(
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
                Column(
                  children: <Widget>[
                    Text(anomaly.post.title
                      ,
                      style: new TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Text(anomaly.post.description),
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
                            child: (anomaly.post.comments.length > 0) 
                                    ? Text(anomaly.post.comments.length.toString()+ ' Commentaires')
                                    : Text("Pas de commentaires"),
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
                        :store.dispatch(new SetReactionAction(
                                              anomaly: anomaly, 
                                              reaction: Reaction(
                                                          isLike: true, 
                                                          post: anomaly.post.id, 
                                                          reactionOwner:  int.parse(store.state.userState.user.id)
                                                        )
                                              )
                          )
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
                        :store.dispatch(new SetReactionAction(anomaly: anomaly, reaction: Reaction(isLike: false, post: anomaly.post.id, reactionOwner: int.parse(store.state.userState.user.id))));
                      },
                    ),
                  ),

                  )
                ],
              ),
           StoreConnector<AppState,Store<AppState>>(
                  converter: (store) => store,
                  onInit: (store) {
                    store.dispatch(GetCommentsAction(list: [],postId: anomaly.post.id.toString()));

                  },
                  builder: (context, store) =>
                  store.state.anomalyDetailsState.isCommentsLoading ?
                    Column(children: <Widget>[
                      CommentLoading(),
                      CommentLoading(),
                      CommentLoading()
                    ],):
                   CommentsList(
                    comments: store.state.anomalyDetailsState.comments,
                ),
                ),
                StoreConnector<AppState,Store<AppState>>(
                  converter: (store) => store,
                  builder: (context,store) => CommentInput(
                    commentOwner: int.parse(store.state.userState.user.id),
                    commentPost: anomaly.post.id,
                  ),
                ), 
          ],
        ),
      ),
    )

     );

;
  }
  
}