import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:sbaclean/models/user.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/store/user_state.dart';

import 'package:redux/redux.dart';
import 'package:sbaclean/actions/feed_actions.dart';
import 'package:cached_network_image/cached_network_image.dart';


class PostLoading extends StatelessWidget {
  PostLoading({Key key}) : super(key: key);     

  

  @override
  Widget build(BuildContext context) {
    return         Center(
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
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],)
                    
                     ,
                     
                  ),
                  Padding(padding: EdgeInsets.all(8),),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],

                        borderRadius: BorderRadius.all(Radius.circular(50))),
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 15,
                      ), 
                  
                  
                ],
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: 
                    Container(
                      color: Colors.grey[200],
                      height: MediaQuery.of(context).size.height *0.4,
                      width: MediaQuery.of(context).size.width -8,
                      
                    )                      
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
                          Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],

                        borderRadius: BorderRadius.all(Radius.circular(50))),
                      width: MediaQuery.of(context).size.width / 6,
                      height: 15,
                      ),
                        ],
                      ),
                      onPressed: () {
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                      },
                    ),
                  ),
                   Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],

                        borderRadius: BorderRadius.all(Radius.circular(50))),
                      width: MediaQuery.of(context).size.width / 6,
                      height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
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