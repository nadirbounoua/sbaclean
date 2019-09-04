import 'package:flutter/material.dart';
import '../feed/feed.dart';

class AnomaliesTab extends StatelessWidget {
    AnomaliesTab({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return new Center(
            child: new FeedScreen(),
        );
    }

}