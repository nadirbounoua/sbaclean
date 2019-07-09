import 'package:flutter/material.dart';
import 'post_preview.dart';
import '../../../models/anomaly.dart';
import 'package:learning2/screens/anomaly_details/anomaly_details.dart';
class PostList extends StatelessWidget {
  final List<Anomaly> posts;

  PostList({Key key, this.posts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {

          return GestureDetector(
            onLongPress: () => showDialog(context: context, child: SimpleDialog(children: <Widget>[SimpleDialogOption(child: Text("Signalez la publication"),)],)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> AnomalyDetails(anomaly:posts[index]))),
            child: PostPreview(anomaly: posts[index],),)
          ;
        },
      );
  }
}