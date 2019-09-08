import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_search/material_search.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/post_feed_actions.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/models/event.dart';
import 'package:sbaclean/models/post.dart';
import 'package:sbaclean/screens/main/widgets/image_chooser.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/models/user.dart';
import 'package:intl/intl.dart';
import '../../../actions/event_actions.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class AddEventForm extends StatefulWidget {
  @override
  _AddEventFormState createState() => new _AddEventFormState();
}

class _AddEventFormState extends State<AddEventForm> {
  final formKey = new GlobalKey<FormState>();

  String _description;
  int _max;
  String _starts_at;
  Api api = Api();
  bool isLoading=false;
  bool havePosition = false;
  Position position;
  Placemark placemark;
  List<Placemark> positionPlacemark;
  String description;
  String title = 'Le titre de votre événement';
  String latitude;
  String longitude;
  String imageUrl; 
  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,Store<AppState>> (
    converter: (store) =>  store,
    onDispose: (store) {
        store.dispatch(DeletePositionAction(null,null,false));
        store.dispatch(DeleteAnomalyImageAction());
    },
    builder: (context,store) {
    return Card(
      child: Form(
      key: formKey,
      child: new Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          ListTile(
              leading: IconButton(
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
              
                
              ),
              title: Text(title),
              subtitle: store.state.postFeedState.havePosition ? Text(store.state.postFeedState.placemark.locality + ", "+store.state.postFeedState.placemark.country) 
                  : Text(""),
            ),
 
          TextFormField(
            readOnly: store.state.eventState.isPostingEvent,
            decoration: new InputDecoration(labelText: 'Title',
                          enabled: !store.state.eventState.isPostingEvent,
            ),
            validator: (val) =>
            val.isEmpty ? 'Please enter the title' : null,
            onFieldSubmitted: (val)=> setState(() {
              title = val;
            }),
            onSaved: (val) => setState(() {
              title = val;
            }),
          ),
          TextFormField(
            decoration: new InputDecoration(labelText: 'Description',
                          enabled: !store.state.eventState.isPostingEvent,
            ),
            validator: (val) =>
            val.isEmpty ? 'Please enter the description' : null,
            onSaved: (val) => _description = val,
          ),
          TextFormField(
            readOnly: store.state.eventState.isPostingEvent,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(labelText: 'Max Participants',
                          enabled: !store.state.eventState.isPostingEvent,
            ),
            validator: (val) =>
            val.isEmpty ? 'Please enter the max of participants' : null,
            onSaved: (val) => _max = int.parse(val),
          ),
          DateTimePickerFormField(
            inputType: InputType.both,
            format: DateFormat("y-M-d H:m"),
            decoration: new InputDecoration(labelText: 'Starts at',
              enabled: !store.state.eventState.isPostingEvent,
            ),
            onSaved: (val) => _starts_at = val.toString(),

          ),
          Padding(padding: EdgeInsets.all(8),),

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
                   store.state.postFeedState.isGpsLoading ?
                   store.state.postFeedState.gpsError ?
                      Text("Veuillez réessayez")
                    : Text('Loacalisation GPS ..')
                    : Text('Ajouter ma position') 
                    : Text("Supprimer ma position")
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

          new Padding(
            padding: new EdgeInsets.only(top: 8.0),
            child: new FlatButton(
              onPressed:() async {
                _submit();
                if (store.state.postFeedState.position != null && store.state.postFeedState.image != null){
                  store.dispatch(AddEventsAction(event: Event(
                    max_participants: _max,
                    starts_at: _starts_at,
                    post: Post(
                      description: _description,
                      title: title,
                      longitude: store.state.postFeedState.position.longitude.toString(),
                      latitude: store.state.postFeedState.position.latitude.toString(),
                      postOwner: store.state.auth.user.id)), 
                    context: context),
                  );
                } else if (store.state.postFeedState.position == null) {
                  showDialog(context: context, 
                    builder: (context)=> SimpleDialog(
                      children: <Widget>[
                        
                      ],
                    ));
                }

              },
              child: store.state.eventState.isPostingEvent ? CircularProgressIndicator() :new Text('Submit'),
            ),
          ),
        ],
      ),
    ),
    );
  });
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