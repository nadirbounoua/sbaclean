import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sbaclean/main.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/post.dart';
import '../feed/feed.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:sbaclean/screens/main/widgets/image_chooser.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/actions/post_feed_actions.dart';
import 'package:sbaclean/actions/feed_actions.dart';
import 'package:sbaclean/backend/api.dart';

//import 'package:sbaclean/redux/reducers.dart';
import 'package:sbaclean/store/app_state.dart';

typedef OnSaveAnomaly = Function(String title, String description, String longitude, String latitude);


//void main() => runApp(MyApp());

/// This Widget is the main application widget.


/// This is the stateless widget that the main application instantiates.
class PostScreenWidget extends StatefulWidget {
  PostScreenWidget({Key key}) : super(key: key);


  @override
  _MyStatefulWidgetState createState() {
    // TODO: implement createState
    return _MyStatefulWidgetState();
  }
}

class _MyStatefulWidgetState extends State<PostScreenWidget> {
  bool isLoading=false;
  bool havePosition = false;
  Position position;
  List<Placemark> placemark;
  String description;
  String title;
  String latitude;
  String longitude;
  String imageUrl; 
  final anomalyTypes = ['Accident', 'Panne', "Fuite d'eau", 'Incendie',] ;
  TextEditingController titleController =TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '') ;
  ImageChooser imageChooser;
  final _formKey = GlobalKey<FormState>();
  File _image;
  Api api = Api();
  String dropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    dropdownValue = anomalyTypes[0];
    title = anomalyTypes[0];
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    titleController.dispose();
    descriptionController.dispose();
    final  deleteAnomalyImageAction = DeleteAnomalyImageAction(image: null);
    final deletePositionAction = DeletePositionAction(null, null, false) ;

    //MyApp.store.dispatch(deleteAnomalyImageAction.setImage());
    //MyApp.store.dispatch(deletePositionAction.deletePosition());
    Future.wait([
      deleteAnomalyImageAction.completer.future,
      deletePositionAction.completer.future
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un post')),

      body:Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: StoreConnector<AppState,Store<AppState>>(
                converter: (store) => store,
                builder: (context, store) {
                return IconButton(
                  icon: (store.state.postFeedState.image == null) ? Icon(Icons.image) : Image.file(store.state.postFeedState.image,height: 100,width: 100,),
                  iconSize: (store.state.postFeedState.image != null ) ? 60 : 24,
                  onPressed:  () async {

                    await showDialog(
                      context: context,
                      builder: (context) {
                        return ImageChooser();
                      });

                    store.dispatch(new SetAnomalyImageAction());

                },
              );
                },
                onDispose: (store) {
                  store.dispatch(DeletePositionAction(null,null,false));
                  store.dispatch(DeleteAnomalyImageAction());
                },
              ),
              title: Text(title),
              subtitle: 
              StoreConnector<AppState,AppState>(
                converter: (store) {
                  return store.state;
                },
                builder: (context, state) => 
                  state.postFeedState.havePosition ? Text(state.postFeedState.placemark[0].locality + ", "+state.postFeedState.placemark[0].country) 
                  : Text("")
                ,
              )
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 0),
                    child:                  
                    Row(
                    
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      Text("Choisissez le type d'anomalie :", 
                        textAlign: TextAlign.start,
                        style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16
                                ),
                        ) ,
                      Padding(padding: EdgeInsets.all(8),),
                      DropdownButton<String>(
                         
                    value: dropdownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        title = newValue;
                        dropdownValue = newValue;
                      });
                      title = newValue;

                    },
                    items: anomalyTypes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),
                   ),
                    ],
                  ),
  
                  ),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: null,
                    validator: (value) {
                      if (value.isEmpty){
                        return 'Please enter some text';
                      }
                      description = value;
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.blue),
                    
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8),),
                ],
              ),
            ),
            StoreConnector<AppState, AppState>(
              converter: (store1) => store1.state,
              builder: (context, state) =>
                StoreConnector<AppState,Store<AppState>>(
                  converter: (store) => store, 
                  builder: (context, store) {
                    return MaterialButton(
                      
                      onPressed:() {
                        state.postFeedState.havePosition ? 
                        store.dispatch(new DeletePositionAction(null, null, false)) 
                        : store.dispatch(new AddPositionAction(position, placemark, havePosition));
                        },
                      child:
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          !state.postFeedState.havePosition ?
                           state.postFeedState.isGpsLoading ? 
                            SizedBox(
                              child:CircularProgressIndicator(
                                strokeWidth: 2.5, 
                                backgroundColor: Colors.white,
                                ),
                              height: 20,
                              width: 20,
                              )
                          : Icon(Icons.gps_fixed)
                          : Icon(Icons.delete),
                          Padding(padding: EdgeInsets.all(8),),
                          !state.postFeedState.havePosition ?
                           state.postFeedState.isGpsLoading ? Text('Loacalisation GPS ..') : Text('Ajouter ma position') : Text("Supprimer ma position") 
                        ],
                      ),
                      color:state.postFeedState.havePosition ? Colors.red : Colors.blue,
                      textColor: Colors.white,
                      );
                  },
                )
                ),
            ButtonTheme.bar(
              // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Annuler'),
                    onPressed: () {/* ... */},
                  ),
                  StoreConnector<AppState,OnSaveAnomaly>(
                    converter: (Store<AppState> store) {
                      return (title, description, latitude, longitude) {
                        store.dispatch(new AddAnomalyAction(
                          post: Post(
                            title: title,
                            description: description, 
                            latitude: latitude, 
                            longitude: longitude),
                          user: store.state.auth.user,
                          anomaly: Anomaly()
                          ));
                      };
                    },

                    builder: (BuildContext context, onSave) {
                      return new 
                        StoreConnector<AppState,AppState> (
                          converter: (store) => store.state,
                          builder: (context, state) =>
                            FlatButton(
                              child: state.feedState.isAddAnomalyLoading ? 
                                Text('En train de poster ...', style: TextStyle(color: Colors.grey[400]),): Text("Poster"),
                              onPressed: state.feedState.isAddAnomalyLoading ?
                               () {} 
                              : () async {
                              
                              if (_formKey.currentState.validate()){
                                print(title);
                                onSave(title,description, state.postFeedState.position.latitude.toString(), state.postFeedState.position.longitude.toString());
                                _formKey.currentState.reset();
                                Navigator.pop(context);
                                }
                              },
                              )
                          ,
                        )
                      ;
                      
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
  ,
  


    );
   
  }

}

