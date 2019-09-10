import 'package:redux/redux.dart';
import 'package:sbaclean/store/city_state.dart';

import '../models/event.dart';
import '../actions/city_actions.dart';

Reducer<CityState> cityReducer = combineReducers([
  new TypedReducer<CityState, GetCitiesAction>(getCities),

]);

CityState getCities(CityState state, GetCitiesAction action) {
  return state.copyWith(cities: action.cities);
}

