import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/screens/anomaly_details/anomaly_details.dart';
import 'package:sbaclean/store/app_state.dart';


class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

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
        markersSet.add(Marker(
          position: LatLng(double.parse(anomaly.post.latitude), double.parse(anomaly.post.longitude)),
          markerId: MarkerId(anomaly.post.id.toString()),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> AnomalyDetails(anomaly: anomaly,)))
        ));
      });
      try {
              store.state.eventState.events.forEach((event){
        markersSet.add(Marker(
          markerId: MarkerId(event.post.id.toString()),
          position: LatLng(double.parse(event.post.latitude), double.parse(event.post.longitude)),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ));
      });
      } catch (e) {
      }

      return GoogleMap(
        
        mapType: MapType.normal,
        markers: markersSet,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      );
  
        },
      ),
          
    );
  }

}