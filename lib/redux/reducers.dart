import '../models/app_state.dart';
import '../models/anomaly.dart';
import 'actions.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:geolocator/geolocator.dart';
typedef OnSaveAnomaly = Function(String title, String description, String longitude, String latitude);

AppState appStateReducers(AppState state, dynamic action) {
  if (action is AddAnomalyAction) {
    return addItem(state.anomalies, action);
  }  

  if (action is GetAnomaliesAction) {
    return getAnomalies(state.anomalies,action );
  }

  if (action is AddPositionAction) {
    return getPostion(state.position, action);
  }
  return state;
}

AppState addItem(List<Anomaly> items, AddAnomalyAction action) {
  return AppState(anomalies: List.from(items)..add(action.item));
}

AppState getAnomalies(List<Anomaly> items, GetAnomaliesAction action) {
  return AppState(anomalies: List.from(action.list));
}

AppState getPostion(Position position, AddPositionAction action){
  
  if (action.position != null)   
    return AppState(position: action.position);

  return AppState(position: position);
}