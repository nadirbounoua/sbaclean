import 'package:flutter/material.dart';
import 'package:learning2/screens/post/comment_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning2/models/app_state_comment.dart';
import '../post/post.dart';
import '../../redux/actions_comment.dart';
import '../post/start_comment.dart';
import 'comment_input.dart';



class Comments extends StatelessWidget {
  Widget build(BuildContext context) {
    return StoreConnector<AppStateComment, VoidCallback>(
      converter: (store) =>
          () => store.dispatch(new GetCommentsAction([]).getComments()),
      builder: (context, callback) {
        return Column(
          children: <Widget>[
           CommentInput(),
            FlatButton(
            child: const Text('All comments'),
            onPressed: () async {
              callback();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Post()));
            }),

          ],
         );
      },
    );
  }
}
