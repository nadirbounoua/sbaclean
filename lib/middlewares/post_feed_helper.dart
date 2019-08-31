import 'package:geolocator/geolocator.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/post_feed_actions.dart';
import 'package:sbaclean/store/app_state.dart';

getPositionHelper(Store<AppState> store, Position myPosition, List<Placemark> myLocation){
  Future.delayed(Duration(seconds: 3), ()=> store.dispatch(new FinishAddPositionAction(myPosition, myLocation, true)));

}