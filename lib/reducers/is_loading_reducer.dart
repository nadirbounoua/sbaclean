import 'package:redux/redux.dart';
import 'package:sbaclean/actions/feed_actions.dart';

Reducer<bool> isLoadingReducer = combineReducers([
  new TypedReducer<bool, FinishGetAnomaliesAction>(finishLoad),
  new TypedReducer<bool, GetAnomaliesAction>(load),


]);

bool load(bool state, GetAnomaliesAction action) {
  print("isloading reducer: getAnomalies: load");
  return true;
}

bool finishLoad(bool state, FinishGetAnomaliesAction action) {
  print("isloading reducer: getAnomalies: false");

  return false;
}
