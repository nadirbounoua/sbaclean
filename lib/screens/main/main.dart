import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

typedef OnSaveAnomaly = Function(String title, String description, String longitude, String latitude, String imageUrl);


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
  String description ='' ;
  String title = '' ;
  String latitude;
  String longitude;
  String imageUrl; 
  TextEditingController titleController =TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '') ;
  ImageChooser imageChooser;
  final _formKey = GlobalKey<FormState>();
  File _image;
  Api api = Api();
  String dropdownValue = 'Accident';

  Future getImage(camera) async {
    var image;
    if (camera)
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    else 
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    titleController.dispose();
    descriptionController.dispose();
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

                    store.dispatch(new SetAnomalyImageAction().setImage());

                },
              );
                },
              ),
              title: Text('Accident de voiture'),
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
                    
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      Text("Choisissez le type d'anomalie :", textAlign: TextAlign.start,) ,
                       DropdownButton<String>(
                         
                    value: dropdownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        title = newValue;
                        dropdownValue = newValue;
                      });
                      title = newValue;

                    },
                    items: <String>['Accident', 'Panne', "Fuite d'eau", 'Incendie',]
                      .map<DropdownMenuItem<String>>((String value) {
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
                StoreConnector<AppState,VoidCallback>(
                  converter: (store) => state.postFeedState.havePosition ? 

                  () => store.dispatch(new DeletePositionAction(position, placemark, havePosition).deletePosition())
                  : () => store.dispatch(new AddPositionAction(position, placemark, havePosition).getPosition())
                  ,
                  builder: (context, callback) {
                    return MaterialButton(
                      onPressed: callback,
                      child:
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.gps_fixed),
                          state.postFeedState.havePosition ? Text('Supprimer ma position') : Text('Ajouter ma position') 
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
                      return (title, description, latitude, longitude, imageUrl) {
                        store.dispatch(new AddAnomalyAction(
                          anomaly: Anomaly(
                            title: title,
                            description: description, 
                            latitude: latitude, 
                            longitude: longitude, 
                            imageUrl: imageUrl),
                          user: store.state.userState.user
                          ).postAnomaly());
                      };
                    },

                    builder: (BuildContext context, onSave) {
                      return new 
                        StoreConnector<AppState,AppState> (
                          converter: (store) => store.state,
                          builder: (context, state) =>
                            FlatButton(
                              child: const Text('Poster'),
                              onPressed: () async {
                              if (_formKey.currentState.validate()){
                                var imageurl = await api.upload(state.postFeedState.image);
                                print(title);
                                onSave(title,description, state.postFeedState.position.latitude.toString(), state.postFeedState.position.longitude.toString(), imageurl);
                                Navigator.pop(context);
                                }
                              },
                              )
                          ,
                        )
                      ;
                      
                    },
                  ),
                  StoreConnector<AppState,Store<AppState>>(
                    converter: (store) => store,
                    builder: (context,store) {
                      return FlatButton(
                        child: const Text('Skip'),
                        onPressed: () async  {
                          /*final getReactions = GetUserReactionAction([]);
                          final getAnomalies = GetAnomaliesAction([]);
                          
                          store.dispatch(getReactions.getReactions());
                          store.dispatch(getAnomalies.getAnomalies());
                          
                          Future.wait([
                            getAnomalies.completer.future,
                            getReactions.completer.future,
                          ]).then((c)  {
                           
                          });
*/
                           var result= await api.upload(store.state.postFeedState.image);
                            print(result);
                            //Navigator.pop(context);

                    });
                    },)
                  ,
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

