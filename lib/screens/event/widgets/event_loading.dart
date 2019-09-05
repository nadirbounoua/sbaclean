import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/event.dart';
import '../../../styles/colors.dart';

class EventLoading extends StatelessWidget {
  EventLoading({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child:    Card(
      child:IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],

                      ),
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 3,
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
                            Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],

                        borderRadius: BorderRadius.all(Radius.circular(50))),
                      width: 1.5*MediaQuery.of(context).size.width / 3,
                      height: 15,
                      ),
                            Padding(
                              padding: EdgeInsets.all(8),
                            ),
                            Container(
                              child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],

                        borderRadius: BorderRadius.all(Radius.circular(50))),
                      width: MediaQuery.of(context).size.width /3,
                      height: 15,
                      ),
                            )
                          ],
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
                        Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],

                        borderRadius: BorderRadius.all(Radius.circular(50))),
                      width: 1.5*MediaQuery.of(context).size.width / 3,
                      height: 15,
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
    ),
    );
  }
}
