import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/store/app_state.dart';

import '../models/city.dart';
import '../backend/api.dart';
import '../backend/utils.dart';




Api api = Api();
  



class GetCitiesAction {
  final List<City> cities;
  GetCitiesAction(this.cities);

  ThunkAction<AppState> getCities() {
    return (Store<AppState> store) async {
      final response = await api.getCities();
      List<City> cities = parseCities(response);
      print("cities"+cities.toString());
      store.dispatch(new GetCitiesAction(cities));
    };
  }
}

