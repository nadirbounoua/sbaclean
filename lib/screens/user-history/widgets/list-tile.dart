import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/screens/anomaly_details/anomaly_details.dart';

class ListElement extends StatelessWidget {
  final Anomaly anomaly;
  ListElement({this.anomaly});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return 
    GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          new MaterialPageRoute(builder: (context) => AnomalyDetails(anomaly: anomaly,)));
      },
      child: Container(
        margin: EdgeInsets.all(8),
        child:  Row(
        
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(8), ),
          anomaly.imageUrl == "/media/images/default.png" ?
          Icon(
            Icons.image,
            size: 100,
          ):
          Image.network(anomaly.imageUrl,width: 100, height: 100,),
          Container(
            margin: EdgeInsets.only(left: 8),
            child : Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Text(
                  anomaly.title,
                  style: TextStyle(fontSize: 25),
            ),
              ],
            )
          )

        ],
      ),
      )
    ,
    );
    
   }
}