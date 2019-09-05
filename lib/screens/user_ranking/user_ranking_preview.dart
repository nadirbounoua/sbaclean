import 'package:flutter/material.dart';
class RankPreview extends StatelessWidget {
  String rank;
  String username;
  String email;
  RankPreview({Key key,  this.rank, this.username,this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return ListTile(
        title : Text(username),
        subtitle: Text(email),
        leading: CircleAvatar(
        child: Text(rank))
    );

  }
}