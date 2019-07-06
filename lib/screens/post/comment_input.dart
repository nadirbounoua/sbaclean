import 'package:flutter/material.dart';
import 'package:learning2/models/comment.dart';
import '../../redux/actions_user.dart';
import '../../redux/actions_comment.dart';
import 'dart:convert';
import '../../models/app_state_comment.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../redux/reducers_comment.dart';

class CommentInput extends StatefulWidget {
  @override
  CommentInputState createState() => CommentInputState();
}

class CommentInputState extends State<CommentInput> {
  int commentOwner;
  int commentPost;
  String commentContent;

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppStateComment, _ViewModel>(
      converter: (store) => _ViewModel(
            addItemToList: (commentowner,commentpost,text) => store.dispatch(new AddCommentAction(
                    Comment(
                        commentOwner: commentowner,
                        commentPost: commentpost,
                        commentContent: text))
                .addComment()),
          ),
      builder: (context, viewModel) => TextField(
          decoration: InputDecoration(hintText: "Enter a comment"),
          controller: controller,
          onSubmitted: (text) {
            viewModel.addItemToList(1,1,text);
            controller.text = "";
          }),
    );
  }
}

typedef AddItem = Function(int commentOwner, int commentPost, String comentContent);

//typedef AddItem(String text);

class _ViewModel {
  final AddItem addItemToList;
  _ViewModel({this.addItemToList});
}
