/*import 'package:flutter/material.dart';
import 'package:sbaclean/screens/post/comment_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sbaclean/store/comment_state.dart';
import '../post/post.dart';
import 'package:sbaclean/actions/comment_actions.dart';
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
              await callback();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Post()));
            }),

          ],
         );
      },
    );
  }
}
*/