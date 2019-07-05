import 'user.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

@immutable
class AppStateUser {

  final List<User> users;

    AppStateUser({this.users = const []});

 
}