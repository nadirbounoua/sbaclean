import 'package:flutter/material.dart';
import 'user_ranking_preview.dart';
import '../../models/user.dart';
class RankList extends StatelessWidget {
  final List<User> rank;

  RankList({Key key, this.rank}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rank.length,
      itemBuilder: (context, index) {
        print(rank[index].username);
        return RankPreview(
          rank: (index+1).toString(),
          username: rank[index].username,
          email:rank[index].email,
        );
      },
    );
  }
}

