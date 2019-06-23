import 'anomaly.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';

@immutable
class AppState {

  final List<Anomaly> anomalies;

  final bool chooseCamera;

  Position position;

  AppState({this.anomalies = const [], this.chooseCamera = false, this.position});
}