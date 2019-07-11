import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

@immutable
class PostFeedState {

  final bool chooseCamera;
  final Position position;
  final bool havePosition;
  final List<Placemark> placemark;
  final File image;
  final bool isLoading;
  PostFeedState({
            this.chooseCamera,
            this.position,
            this.placemark,
            this.havePosition = false,
            this.image,
            this.isLoading
  });

  PostFeedState copyWith({
      bool chooseCamera,
      Position position,
      bool havePosition,
      List<Placemark> placemark,
      File image
  }) {
      return PostFeedState(
        chooseCamera: chooseCamera ?? this.chooseCamera,
        position: position ?? this.position,
        havePosition: havePosition ?? this.havePosition,
        placemark: placemark ?? this.placemark,
        image: image ?? this.image
      );
  }
}