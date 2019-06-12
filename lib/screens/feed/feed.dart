import 'package:flutter/material.dart';
import '../settings/settings.dart';
import '../../models/anomaly.dart';
import '../../backend/api.dart';
import 'widgets/post_list.dart';

void main() => runApp(Feed());
 
class Feed extends StatelessWidget {
  static const String _title = 'Signalements';
  Api api = Api();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                semanticLabel: 'settings',
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
              },
            )
          ],
        ),
        body: FutureBuilder<List<Anomaly>>(
          future: api.getPosts(),
          builder: (context,snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
              ? PostList(posts: snapshot.data)
              : Center(child: CircularProgressIndicator());
        
          },
        ),
      ),
    );
  }
}



