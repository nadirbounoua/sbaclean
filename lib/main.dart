import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'feed.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
  bool isLoading=false;
  bool havePosition = false;
  Position position;
  bool chooseCamera ;
  List<Placemark> placemark;

  final _formKey = GlobalKey<FormState>();

  File _image;

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

                  await showDialog(
                    context: context,
                    child: SimpleDialog(
                    title: Text("Choisissez"),
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () {
                            chooseCamera = true;
                            Navigator.of(context).pop();
                        },
                        child: Text("Camera"),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                            chooseCamera = false;
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
                    decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.blue),
                    ),
                    validator: (value) {
                      if (value.isEmpty){
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLines: null,
                    validator: (value) {
                      if (value.isEmpty){
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: TextEditingController(),
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
                    onPressed: () {
                      if (_formKey.currentState.validate() && _image != null){
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

