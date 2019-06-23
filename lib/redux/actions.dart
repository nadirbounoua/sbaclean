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

class SetLoadingAction {
  final bool isLoading;
  SetLoadingAction(this.isLoading);
}

class RemoveLoadingAction {
  final bool isLoading;
  RemoveLoadingAction(this.isLoading);
}


class AddPositionAction {
  final bool havePosition;
  final Position position;
  final List<Placemark> placemark;

  AddPositionAction(this.position, this.placemark, this.havePosition,);

    ThunkAction<AppState> getPosition() {
      return (Store<AppState> store) async {        
        final myPosition =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        final myLocation = await Geolocator().placemarkFromCoordinates(myPosition.latitude, myPosition.longitude);
        final havePosition = true;
        store.dispatch(new AddPositionAction(myPosition, myLocation, havePosition));

        //final placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);

  };
}
}

class DeletePositionAction {
  final bool havePosition;
  final Position position;
  final List<Placemark> placemark;
  DeletePositionAction(this.position, this.placemark, this.havePosition);

    ThunkAction<AppState> deletePosition() {
      return (Store<AppState> store) async {
        final myPosition =  null;
        final myLocation = null;
        print('k');
        store.dispatch(new DeletePositionAction(myPosition, myLocation, false));
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

