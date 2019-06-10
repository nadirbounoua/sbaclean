import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'feed.dart';

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
  List<Placemark> placemark;

  @override
  Widget build(BuildContext context) {
    if (havePosition) {
      try {
        return Center(
          child: AlertDialog(
            title: Text("Your position"),
            content: Text(placemark[0].locality),
          ),
        );
      }
      catch (e) {

      }
    }

    if (this.isLoading)

      return Center(
        child: CircularProgressIndicator(

        ),
      );

    else

    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.image),
              title: Text('Accident de voiture'),
              subtitle: Text('Rue, Quartier, Wilaya, Algérie'),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.blue),
              ),
            ),
            TextFormField(
              maxLines: null,
              controller: TextEditingController(),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.blue),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                setState(() {
                  this.isLoading = true;
                  this.havePosition = true;
                });
                position =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
                print("k2");


                setState(() {
                  this.isLoading = false;
                });
                print(position.longitude);
                print("k");

              },
              child:
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.gps_fixed),
                  Text('Ajouter ma position')
                ],
              ),
              color: Colors.blue,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Feed()));
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

