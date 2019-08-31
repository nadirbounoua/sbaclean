import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sbaclean/actions/post_feed_actions.dart';
import 'package:sbaclean/store/app_state.dart';
final state_key = GlobalKey<ImageChooserState>();


class ImageChooser extends StatefulWidget {
  ImageChooser({Key key}) : super(key: key);

  @override
  ImageChooserState createState() {
    // TODO: implement createState
    
    return ImageChooserState();
  }
}

class ImageChooserState extends State<ImageChooser> {
  bool chooseCamera = false;

  @override
  Widget build(BuildContext context) {
        return new SimpleDialog(
          title: Text("Choisissez"),
          children: <Widget>[
            StoreConnector<AppState, VoidCallback>(
             converter: (store) {
            return () => store.dispatch(new ChoosePickerCameraAction(value: true));
             },
  
           builder: (context,callback) {
             return new
            SimpleDialogOption(
              onPressed: () {
              callback();
              Navigator.of(context).pop();
            },
            child: Text("Camera"),
          );}),
            StoreConnector<AppState, VoidCallback>(
             converter: (store) {
            return () => store.dispatch(new ChoosePickerGalleryAction(value: false));
             },
  
           builder: (context,callback) {
             return new
            SimpleDialogOption(
              onPressed: () {
              callback();
              Navigator.of(context).pop();
            },
            child: Text("Gallery"),
          );})
          ],
      );
      
    }
    

  }
