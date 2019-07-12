import 'package:sbaclean/models/user.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

@immutable
class UserState {

  final User user;

  UserState({this.user});

  UserState copyWith({
      User user
  }) {
      print("Token"+ user.authToken);
      return UserState(
        user: user ?? this.user
      );
  }
}