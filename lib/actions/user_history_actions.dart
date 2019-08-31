import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/models/reaction.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sbaclean/backend/utils.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

Api api = Api();

class GetUserAnomaliesHistoryAction {
  List<Anomaly> list;
  String userId;
  Completer completer=  new Completer();

  GetUserAnomaliesHistoryAction({this.list,this.userId});

}

class FinishGetUserAnomaliesHistoryAction{
  List<Anomaly> list;
  FinishGetUserAnomaliesHistoryAction({this.list});

}