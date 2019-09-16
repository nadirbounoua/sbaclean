import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/feed_actions.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/screens/user-history/widgets/history_list.dart';
import 'package:sbaclean/store/app_state.dart';
import '../../../styles/colors.dart';

class AnomalyHistoryPreview extends StatefulWidget  implements ListItem{
  Anomaly anomaly;
  int score;
  AnomalyHistoryPreview({Key key,  this.anomaly}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AnomalyHistoryPreviewState(anomaly: anomaly);
  }

 
}

class AnomalyHistoryPreviewState extends State<AnomalyHistoryPreview> {

  Anomaly anomaly;

  AnomalyHistoryPreviewState({this.anomaly});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) => Column(
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
                  height: 3*MediaQuery.of(context).size.width/24,
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
                  margin: EdgeInsets.only(top: 1*MediaQuery.of(context).size.width/24,),
                  padding: EdgeInsets.all(4),
                  height: MediaQuery.of(context).size.width/12,
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 2*MediaQuery.of(context).size.width/3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8),
                          ),
                          Icon(Icons.comment,
                            size: 24, 
                            color: Colors.grey,
                          ),

                          Padding(
                            padding: EdgeInsets.all(4),
                          ),
                          Text(anomaly.post.comments.length.toString(),
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

                          Padding(
                            padding: EdgeInsets.all(4),
                          ),
                          Text(anomaly.post.reactionsCount.toString(),

                            style: TextStyle(
                              fontSize: 14
                            ),
                          ),
                          /*Expanded(
                            child: 
                              Container(
                                color: Colors.red,
                                child: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () { store.dispatch(DeleteAnomalyAction(anomaly: anomaly));},
                               ),
                              )                     
                          )*/
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
    )
    );
      
  }
  
}