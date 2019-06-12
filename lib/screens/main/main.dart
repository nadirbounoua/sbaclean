import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../feed/feed.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../projectSettings.dart' as ProjectSettings;
import '../../backend/api.dart';
import 'widgets/image_chooser.dart';
void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatefulWidget {
  MyStatelessWidget({Key key}) : super(key: key);


  @override
  _MyStatefulWidgetState createState() {
    // TODO: implement createState
    return _MyStatefulWidgetState();
  }
}

class _MyStatefulWidgetState extends State<MyStatelessWidget> {
  String apiUrl = ProjectSettings.apiUrl;
  String authToken = ProjectSettings.authToken ;
  bool isLoading=false;
  bool havePosition = false;
  Position position;
  List<Placemark> placemark;
  String description ='' ;
  String title = '' ;
  TextEditingController titleController =TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '') ;
  ImageChooser imageChooser;
  final _formKey = GlobalKey<FormState>();
  File _image;
  bool chooseCamera = false;
  Api api = Api();


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

    if(isLoading) return Center(child: CircularProgressIndicator(),);

    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: IconButton(
                icon: (_image == null) ? Icon(Icons.image) : Image.file(_image,height: 100,width: 100,),
                iconSize: (_image != null ) ? 60 : 24,
                onPressed:  () async {
                  imageChooser = ImageChooser();
                  await showDialog(
                    context: context,
                    child: SimpleDialog(
        title: Text("Choisissez"),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              setState(() {
                chooseCamera = true;
              });
              Navigator.of(context).pop();
            },
            child: Text("Camera"),
          ),
          SimpleDialogOption(
            onPressed: () {
              setState(() {
                chooseCamera = false;
              });
              Navigator.of(context).pop();
            },
            child: Text("Gallery"),
          )
          ],
      ));
                  try {
                  getImage(chooseCamera);

                  } catch (e){

                  }
                },
              ),
              title: Text('Accident de voiture'),
              subtitle: havePosition ?  Text(placemark[0].locality + ", "+placemark[0].country) : Text(""),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.blue),
                    ),
                    validator: (value) {
                      if (value.isEmpty){
                        return 'Please enter some text';
                      }
                      title = value;
                      return null;
                    },
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
              onPressed: havePosition ? () {
                position = null;
                placemark = null;
                setState(() {
                  this.havePosition = false;    
                });
              } : () async {
  
                setState(() {
                  this.isLoading = true;
                  this.havePosition = true;
                });

                position =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
                
                setState(() {
                  this.isLoading = false;
                });
             
              },
              child:
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.gps_fixed),
                  havePosition ? Text('Supprimer ma position') : Text('Ajouter ma position') 
                ],
              ),
              color:havePosition ? Colors.red : Colors.blue,
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
                    child: const Text('Poster'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()){
                        var response = await api.createPost(title,description,position.longitude.toString(),position.latitude.toString());
                        if (response.statusCode != 500)
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Feed()));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

