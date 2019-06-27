import 'package:flutter/material.dart';
import 'post_preview.dart';
import '../../../models/anomaly.dart';
class PostList extends StatelessWidget {
  final List<Anomaly> posts;

  PostList({Key key, this.posts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostPreview(anomaly: posts[index],);
        },
      );
  }
}