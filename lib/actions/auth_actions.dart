import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:redux/redux.dart';

import '../models/user.dart';
import '../store/app_state.dart';
import '../backend/api.dart';
import '../backend/utils.dart';
import '../models/profile.dart';
import 'event_actions.dart';



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
        User pro = parseProfile(profile);
        if (condition) {
            store.dispatch(new UserLoginSuccess(new User(authToken: token,id: pro.id,
                username: pro.username,first_name: pro.first_name,
                last_name: pro.last_name,address: pro.address,city: pro.city,
            email: pro.email,phone_number: pro.phone_number)));
            Navigator.of(context).pushNamedAndRemoveUntil('/main', (_) => false);
        } else {
            store.dispatch(new UserLoginFailure('Username or password were incorrect.'));
        }
    };
};



final Function register = (BuildContext context, String username, String phone_number, String address, String city, String password) {
    Api api = Api();
    api.addUser(username,phone_number, address, city, password);
};

final Function modify = (BuildContext context,String id,String token,String username, String phone_number, String address, String city) {
    Api api = Api();
    api.modifyProfile(id,token,username,phone_number, address, city);
};

final Function logout = (BuildContext context) {
    return (Store<AppState> store) {
        store.dispatch(new UserLogout());
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
    };
};



