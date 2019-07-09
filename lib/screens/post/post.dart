import 'package:flutter/material.dart';
import 'package:learning2/screens/post/comment_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning2/models/app_state_comment.dart';

class Post extends StatelessWidget{
  Widget build(BuildContext context){
    return StoreConnector<AppStateComment,AppStateComment>(
      converter: (store) =>  store.state,
      builder: (context,state) {
        return Scaffold(
        appBar: AppBar(
          title: Text('Comments'),
        ),
        body: CommentList(comments: state.comments),
        );
      } 
    );
  }
}