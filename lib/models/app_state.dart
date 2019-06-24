import 'anomaly.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

@immutable
class AppState {

  final List<Anomaly> anomalies;

  final bool chooseCamera;
  final bool isLoading;
  Position position;
  bool havePosition;
  List<Placemark> placemark;
  File image;
  AppState({this.anomalies = const [], this.chooseCamera, this.position,this.placemark,this.havePosition = false, this.isLoading = false, this.image});
}