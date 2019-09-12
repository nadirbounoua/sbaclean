import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/store/auth_state.dart';
import '../models/event.dart';
import 'package:redux/redux.dart';

import '../models/user.dart';
import '../store/app_state.dart';
import '../backend/api.dart';
import '../backend/utils.dart';
import '../models/profile.dart';
import 'event_actions.dart';
import 'package:path_provider/path_provider.dart';
import 'city_actions.dart';

Api api = Api();


class UserLoginRequest {}

class UserLoginSuccess {
    final User user;

    UserLoginSuccess(this.user);
}

class UserLoginFailure {
    final String error;

    UserLoginFailure(this.error);
}

class UserLogout {}

final Function login = (BuildContext context, String username, String password) {
    Api api = Api();
    return (Store<AppState> store) async{
        store.dispatch(new UserLoginRequest());
        final response = await api.getToken(username, password);
        final condition = response.contains("token");
        final token = response.substring(10,response.length - 2);
        final profile = await api.getProfile(username, token);
        if (condition) {
            User pro = parseProfile(profile);

            final directory = await getApplicationDocumentsDirectory();
            File persist = File(directory.path +'/loginFile.json');
            File(directory.path +'/loginFile.json').existsSync() ? File(directory.path +'/loginFile.json').deleteSync() : File(directory.path +'/loginFile.json').createSync();

            User finalUser =User(password:password,authToken: token,id: pro.id,
                username: pro.username,first_name: pro.first_name,
                last_name: pro.last_name,address: pro.address,city: pro.city,
            email: pro.email,phone_number: pro.phone_number);
            persist.writeAsStringSync(json.encode(finalUser.toJSON()));
            store.dispatch(new UserLoginSuccess(finalUser));
            store.dispatch(getCities(context));
            Navigator.of(context).pushNamedAndRemoveUntil('/main', (_) => false);
        } else {
            store.dispatch(new UserLoginFailure('Username or password were incorrect.'));
        }
    };
};



final Function register = (BuildContext context, String username,String first_name,String last_name,String phone_number, String city,String address, String email, String password) async {
    Api api = Api();
    await api.addUser(username,first_name,last_name,phone_number, city,address, email, password);
};

final Function modifyPersonal = (BuildContext context,String id,String token,String first_name,String last_name, String phone_number, String address, String city) {
    Api api = Api();
    api.modifyPersonal(id,token,first_name,last_name,phone_number, address, city);
};

final Function modifyLogin = (BuildContext context,String id,String token,String username,String email, String password) {
    Api api = Api();
    api.modifyLogin(id,token,username,email,password);
};


final Function logout = (BuildContext context) {
    return (Store<AppState> store) async {
        final directory = await getApplicationDocumentsDirectory();
        File persist;
        persist = File(directory.path +'/loginFile.json');
        persist.deleteSync();
        store.dispatch(new UserLogout());
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
    };
};


class GetUserRankingAction {
    final List<User> ranks;

    GetUserRankingAction(this.ranks);
    
    ThunkAction<AppState> getRanking() {
    return (Store<AppState> store) async {
      print('kk');
      final response3 = await api.copyWith(store.state.auth.user.authToken)
                                .getRanking(store.state.auth.user.city);
      print(response3);
      List<User> ranks = parseUsers(response3);
          store.dispatch(new GetUserRankingAction(ranks)); 
    };
  }
        
}

class GetUserByEmailAction {
    final User user;
    final String email;
    GetUserByEmailAction({this.user, this.email});
    
    ThunkAction<AppState> getUser() {
    return (Store<AppState> store) async {
      print('kk');
      final response3 = await api.getUserByEmail(email);
      print("response" +response3);
      List<User> user= parseUsers(response3);
          store.dispatch(new GetUserByEmailAction(user: user[0])); 
    };
  }
        
}

class GetUserPositionAction {
    final Position position;
    GetUserPositionAction({this.position});
    
    ThunkAction<AppState> getUserPosition() {
    return (Store<AppState> store) async {
      final myPosition =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      store.dispatch(new GetUserPositionAction(position: myPosition)); 
    };
  }
        
}

class SetUserOneSignalIdAction {
  String id;
  SetUserOneSignalIdAction({this.id});
}
