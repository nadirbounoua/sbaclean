import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/store/app_state.dart';

import '../models/city.dart';
import '../backend/api.dart';
import '../backend/utils.dart';




  


final Function getCities = (BuildContext context) {
  Api api = Api();
  return (Store<AppState> store) async{
    final response = await api.getCities();
    List<City> cities = parseCities(response);
    store.dispatch(new GetCitiesAction(cities));
  };
};


class GetCitiesAction {
  final List<City> cities;
  GetCitiesAction(this.cities);
}

