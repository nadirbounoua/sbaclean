
import 'package:redux/redux.dart';

import 'package:sbaclean/actions/user_actions.dart';
import 'package:sbaclean/store/user_state.dart';
import '../models/user.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:geolocator/geolocator.dart';


Reducer<UserState> userStateReducers = combineReducers([
  new TypedReducer<UserState, GetUserAction>(getUser),

]);



/*
UserState addItem(List<User> items, AddUserAction action) {
  return UserState(users: List.from(items)..add(action.item));
}

UserState getUsers(List<User> items, GetUsersAction action) {
  return UserState(users: List.from(action.list));
}
*/
UserState getUser(UserState state, GetUserAction action) {
  return state.copyWith(user: action.user);
}

