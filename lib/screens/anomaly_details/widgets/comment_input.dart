import 'package:flutter/material.dart';
import 'package:sbaclean/models/comment.dart';
import 'package:sbaclean/actions/anomaly_details_actions.dart';
import 'package:sbaclean/store/anomaly_details_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sbaclean/store/app_state.dart';

class CommentInput extends StatefulWidget {
  int commentOwner;
  int commentPost;

  CommentInput({this.commentOwner,this.commentPost});

  @override
  CommentInputState createState() => CommentInputState(commentOwner: commentOwner, commentPost: commentPost);
}

class CommentInputState extends State<CommentInput> {
  int commentOwner;
  int commentPost;
  String commentContent;
  final TextEditingController controller = TextEditingController();

  CommentInputState({this.commentOwner, this.commentPost});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel(
            addItemToList: (commentowner,commentpost,text) => store.dispatch(new AddCommentAction(
                    Comment(
                        commentOwner: commentowner,
                        commentPost: commentpost,
                        commentContent: text))),
          ),
      builder: (context, viewModel) => TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: "Enter a comment"),
          controller: controller,
          
          onSubmitted: (text) {
            viewModel.addItemToList(commentOwner,commentPost,text);
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
