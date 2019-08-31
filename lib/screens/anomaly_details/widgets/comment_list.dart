import 'package:flutter/material.dart';
import 'package:sbaclean/screens/anomaly_details/widgets/comment_preview.dart';
import 'package:sbaclean/models/comment.dart';

class CommentsList extends StatelessWidget {
  final List<Comment> comments;
  var list = <CommentPreview>[] ;


  CommentsList({Key key, this.comments}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    comments.forEach((comment) => list.add(CommentPreview(comment: comment,)));
    return Column(
      children: list,
    );
  }
}



// GetUser getuser = new GetUser();
//         User item;
//         Map map = new Map();
        
//         if (map != null) {
//           if (map.containsKey(comments[index].commentOwner)) {
//             item = map[comments[index].commentOwner];
//           } else {
//             print('aaaaaaaaaaaaaa');
//             final user = getuser.getUser(comments[index].commentOwner);
//             user.then((value){
//             print(value.username);
//             item = value;
//             map[comments[index].commentOwner] = value;
//             }, onError: print);
//           }
//         } else {
//             print('bbbbbbbbbbbbb');
//             final user = getuser.getUser(comments[index].commentOwner);
//             user.then((value) {
//             item = value;
//             map[comments[index].commentOwner] = value;
//             }, onError: print);
//         }