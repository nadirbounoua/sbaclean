import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/models/app_state_user.dart';
import 'package:sbaclean/backend/api.dart';
import 'package:sbaclean/backend/utils.dart';
import '../models/user.dart';

// useless
enum Actions {AddUserAction, GetUserAction}

Api api = Api();

class AddUserAction {
  final User item;

  AddUserAction(this.item);

    ThunkAction<AppStateUser> AddUser() {
    return (Store<AppStateUser> store) async {
      final responseUser = await api.createUser(item);
      store.dispatch(new AddUserAction(item));
    };
  }
}

class GetUsersAction {
  final List<User> list;
  GetUsersAction(this.list);

  ThunkAction<AppStateUser> getUsers() {
    return (Store<AppStateUser> store) async {
      final response = await api.getUsers();
      List<User> userList = parseUsers(response);
      store.dispatch(new GetUsersAction(userList));
    };
  }
}

class GetUser{

  Future<User> getUser(id) async {
      final response = await api.getUser(id);
       final item = parseOneUser(response);
      return item;
  }
 
}

    
