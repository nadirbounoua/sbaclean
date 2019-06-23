import 'package:learning2/models/anomaly.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:learning2/models/app_state.dart';
import 'package:learning2/backend/api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:learning2/backend/utils.dart';

enum Actions {AddAnomalyAction,ChoosePickerCameraAction,ChoosePickerGalleryAction, GetAnomaliesAction}
Api api = Api();

class AddAnomalyAction {
  final Anomaly item;

  AddAnomalyAction(this.item);

  ThunkAction<AppState> postAnomaly() {
  return (Store<AppState> store) async {
    final responsePost = await api.createPost(item);
    //final response = await api.getPosts();
    
    store.dispatch(new AddAnomalyAction(item));

    //store.dispatch(new GetAnomaliesAction([]).getAnomalies());

  };

}
}

class GetAnomaliesAction {
  final List<Anomaly> list;
  GetAnomaliesAction(this.list);

  ThunkAction<AppState> getAnomalies() {
    return (Store<AppState> store) async {
      final response = await api.getPosts();
      List<Anomaly> anomalyList = parsePost(response);
      store.dispatch(new GetAnomaliesAction(anomalyList));
    };
  }
}



class AddPositionAction {
  final Position position;

  AddPositionAction(this.position);

    ThunkAction<AppState> getPosition() {
      return (Store<AppState> store) async {
        final myPosition =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        store.dispatch(new AddPositionAction(myPosition));
        //final placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);

  };
}
}

class ChoosePickerCameraAction {
  final bool value;
  ChoosePickerCameraAction(this.value);
}

class ChoosePickerGalleryAction {
  final bool value;
  ChoosePickerGalleryAction(this.value);
}

