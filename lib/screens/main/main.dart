import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_search/material_search.dart';
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
  Placemark placemark;
  List<Placemark> positionPlacemark;
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

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return StoreConnector<AppState, Store<AppState>>(
      onDispose: (store) {
        store.dispatch(DeletePositionAction(null,null,false));
        store.dispatch(DeleteAnomalyImageAction());
      },
      converter: (store) => store,
      builder: (context, store) => Scaffold(
      appBar: AppBar(title: const Text('Ajouter un post')),

      body:Card(
        child: SingleChildScrollView(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              child: (store.state.postFeedState.image == null) ? 
                Image.asset('assets/24px.png',
                  filterQuality: FilterQuality.high,              
                  height: MediaQuery.of(context).size.height *0.4,
                  width: MediaQuery.of(context).size.width - 8,             
                )
              : Image.file(store.state.postFeedState.image,
                  filterQuality: FilterQuality.high,              
                  height: MediaQuery.of(context).size.height *0.4,
                  width: MediaQuery.of(context).size.width - 8,
                ),
              onTap: () async {

                    await showDialog(
                      context: context,
                      builder: (context) {
                        return ImageChooser();
                      });

                    store.dispatch(new SetAnomalyImageAction());

              },
            ),
            Padding(padding: EdgeInsets.all(2),),
                        
            Row(
              children: <Widget>[
                Text('Type :',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16
                  ),
                ),
                Padding(padding: EdgeInsets.all(4),
                ),
                 Text(title, 
                  style: TextStyle(
                    fontSize: 16

                  ),
                 ),
              ],
              
            ),
            store.state.postFeedState.havePosition ? Text(store.state.postFeedState.placemark.locality + ", "+store.state.postFeedState.placemark.country) 
                  : Container(width: 0, height: 0,),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 0, top: 8),
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
            MaterialButton(

              onPressed:() {
                store.state.postFeedState.havePosition ? 
                store.dispatch(new DeletePositionAction(null, null, false)) 
                : store.dispatch(new AddPositionAction(position, placemark, havePosition));
                },
              child:
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  !store.state.postFeedState.havePosition ?
                   store.state.postFeedState.isGpsLoading ? 
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
                  !store.state.postFeedState.havePosition ?
                   store.state.postFeedState.isGpsLoading ? Text('Loacalisation GPS ..') : Text('Ajouter ma position') : Text("Supprimer ma position") 
                ],
              ),
              color: store.state.postFeedState.havePosition ? Colors.red : Colors.blue,
              textColor: Colors.white,
              ),
            store.state.postFeedState.havePosition ? Padding(padding: EdgeInsets.all(0),) : 
            MaterialButton(
                      
                      onPressed:() {
                        _showMaterialSearch(context, store);
                        },
                      child:
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.search),
                          Padding(padding: EdgeInsets.all(8),),
                          Text('Chercher par addresse') 
                        ],
                      ),
                      color: Colors.grey,
                      textColor: Colors.white,
                      ),
            ButtonTheme.bar(
              // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Annuler'),
                    onPressed: () {/* ... */},
                  ),
                  FlatButton(
                    child: store.state.feedState.isAddAnomalyLoading ? 
                      Text('En train de poster ...', style: TextStyle(color: Colors.grey[400]),): Text("Poster"),
                    onPressed: store.state.feedState.isAddAnomalyLoading ?
                     () {} 
                    : () async {
                    
                    if (_formKey.currentState.validate()){
                      store.dispatch(new AddAnomalyAction(
                          post: Post(
                            title: title,
                            description: description, 
                            latitude: store.state.postFeedState.position.latitude.toString(), 
                            longitude: store.state.postFeedState.position.longitude.toString()),
                          user: store.state.auth.user,
                          anomaly: Anomaly()
                          ));
                      _formKey.currentState.reset();
                      Navigator.pop(context);
                      }
                    },
                    ), 
                ],
              ),
            ),
          ],
        ),
  
        )     ),
    ),
  );
   
  }

  _showMaterialSearch(BuildContext context, Store<AppState> store) {
    Navigator.of(context)
      .push(_buildMaterialSearchPage(context, store))
      .then((dynamic value) {
      });
  }

  _buildMaterialSearchPage(BuildContext context, Store<AppState> store) {
    return 
        MaterialPageRoute<dynamic>(
      settings: new RouteSettings(
        name: 'material_search',
        isInitialRoute: false,
      ),
      builder: (BuildContext context) {
        return new Material(
          child: 
            MaterialSearch<dynamic>(
            placeholder: 'Search',
            getResults: (String criteria) async {
              if (criteria.isEmpty) {
                
                setState(() {
                 positionPlacemark = [];
               });
              } else {
               Geolocator().placemarkFromAddress(criteria)
                    .then((onValue) => setState((){
                        positionPlacemark = onValue;
                    }))
                    .catchError((onError) => print("error"));
              
               
              }
              return positionPlacemark.map((position) => new MaterialSearchResult<dynamic>(
                value: position, //The value must be of type <String>
                text:position.thoroughfare 
              +','+
              position.locality
              +','+
              position.administrativeArea
              +','+
              position.country, //String that will be show in the list
                //icon: anomaly.imageUrl == "/media/images/default.png" ? Icons.image : ImageIcon(Image.network(src))
                //.network(anomaly.imageUrl ,width: 24, height: 24,)
              )).toList();
            },

            onSelect: (dynamic value) {
              print(value);
              store.dispatch(AddPositionFromSearchAction(null, value, true));
              Navigator.pop(context);
            } ,
            onSubmit: (dynamic value) {
              print(value);
              store.dispatch(AddPositionFromSearchAction(null, value, true));
              Navigator.pop(context);
            },
          ),
       
        );
      }
    );
      
  }

}

