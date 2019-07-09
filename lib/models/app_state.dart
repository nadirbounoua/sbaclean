import 'anomaly.dart';
import 'package:learning2/models/reaction.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

@immutable
class AppState {

  final List<Anomaly> anomalies;
  final bool chooseCamera;
  final bool isLoading;
  final Position position;
  final bool havePosition;
  final List<Placemark> placemark;
  final File image;
  final bool postsChanged;
  final List<Reaction> userReactions;

  AppState({this.anomalies = const [], 
            this.chooseCamera,
            this.position,
            this.placemark,
            this.havePosition = false,
            this.isLoading = false, 
            this.image, 
            this.postsChanged = false,
            this.userReactions = const []
  });
}