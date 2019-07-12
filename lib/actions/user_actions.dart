import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/store/user_state.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/backend/utils.dart';
import '../models/user.dart';

// useless
enum Actions {AddUserAction, GetUserAction}

Api api = Api();

class AddUserAction {
  final User item;

  AddUserAction(this.item);

    ThunkAction<UserState> AddUser() {
    return (Store<UserState> store) async {
      final responseUser = await api.createUser(item);
      store.dispatch(new AddUserAction(item));
    };
  }
}

class GetUsersAction {
  final List<User> list;
  GetUsersAction(this.list);

  ThunkAction<UserState> getUsers() {
    return (Store<UserState> store) async {
      final response = await api.getUsers();
      List<User> userList = parseUsers(response);
      store.dispatch(new GetUsersAction(userList));
    };
  }
}

class GetUserAction{

  User user;
  int id;
  GetUserAction({this.user,this.id});

  ThunkAction<UserState> getUser() {
    return (Store<UserState> store) async {
      final response = await api.getUser(id);
      User user = parseOneUser(response);
      store.dispatch(new GetUserAction(user: user));
    };
  }
 
}

    

