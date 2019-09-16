import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/participation_actions.dart';
import 'package:sbaclean/models/participation.dart';
import 'package:sbaclean/screens/anomaly_details/anomaly_details.dart';
import 'package:sbaclean/store/app_state.dart';


class MapSample extends StatefulWidget {

  Store<AppState> store;
  MapSample({this.store});
  @override
  State<MapSample> createState() => MapSampleState(store: store);
}

class MapSampleState extends State<MapSample> {
  Store<AppState> store;
  Completer<GoogleMapController> _controller = Completer();
  MapSampleState({this.store});
  getIcons() async {

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: StoreConnector<AppState,Store<AppState>>(
        converter: (store) =>store,
        builder: (context, store) {
        final CameraPosition _kGooglePlex = CameraPosition(
              //target: LatLng(37.422, -122.084),
            target: LatLng(store.state.auth.user.position.latitude, store.state.auth.user.position.longitude),
            zoom: 14.4746,
          );

      final CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target:LatLng(store.state.auth.user.position.latitude, store.state.auth.user.position.longitude),
          tilt: 59.440717697143555,
          zoom: 19.151926040649414);
      Set<Marker> markersSet =  Set();
      store.state.feedState.anomalies.forEach((anomaly) {
        try {
          markersSet.add(Marker(
          position: LatLng(double.parse(anomaly.post.latitude), double.parse(anomaly.post.longitude)),
          markerId: MarkerId(anomaly.post.id.toString()),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> AnomalyDetails(anomaly: anomaly,)))
        ));
        } catch (e) {
        }
             });
      try {
      store.state.eventState.events.forEach((event){
        markersSet.add(Marker(
          markerId: MarkerId(event.post.id.toString()),
          position: LatLng(double.parse(event.post.latitude), double.parse(event.post.longitude)),
          onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Participation à "+ event.post.title),
                      content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Voulez vous participer a cet événement ?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Annuler'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text('Particper'),
                                  onPressed: () {
                                    store.dispatch(
                                        addParticipation(
                                          context,
                                          store.state.auth.user.authToken,
                                          new Participation(
                                              user: store.state.auth.user.id.toString(), event: event.id.toString())));
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                    );
                  }
                );
          }
        ));
      });
      } catch (e) {
      }

      return Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
         
        GoogleMap( 
          mapType: MapType.normal,
          markers: markersSet,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
          Container(
            height: 100,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25))

            ),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.location_on, color: Colors.yellow,),
                  Text("Anomaly"),

                ],
              ),
              Padding(padding: EdgeInsets.all(8),),
              Row(
                children: <Widget>[
                  Icon(Icons.location_on, color: Colors.red,),
                  Text("Evénement"),


                ],
              )
            ],
          ),
          ),
         
  
        ],
      );
      
      
        },
      ),
          
    );
  }

}