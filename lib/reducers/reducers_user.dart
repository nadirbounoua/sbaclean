
import '../models/app_state_user.dart';
import '../models/user.dart';
import 'package:sbaclean/actions/actions_user.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:geolocator/geolocator.dart';


AppStateUser appStateReducers(AppStateUser state, dynamic action) {
  if (action is AddUserAction) {
    return addItem(state.users,action);
  }  
    return getUsers(state.users,action );
  
}

AppStateUser addItem(List<User> items, AddUserAction action) {
  return AppStateUser(users: List.from(items)..add(action.item));
}

AppStateUser getUsers(List<User> items, GetUsersAction action) {
  return AppStateUser(users: List.from(action.list));
}

