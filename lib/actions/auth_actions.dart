import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/actions/post_feed_actions.dart';
import 'package:sbaclean/containers/profile_page.dart';
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

class EditProfilePicRequest{}

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
            email: pro.email,phone_number: pro.phone_number, profile_picture: pro.profile_picture);
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


final Function modifyPersonal = (BuildContext context,String id,String token,String password,String username, String email, String first_name,String last_name, String phone_number, String address, String city, String profile_picture) {
    Api api = Api();
    return (Store<AppState> store) async{

        // modify api
        api.modifyPersonal(id,token,username,email,first_name,last_name,phone_number, address, city);

        // modify state
        store.dispatch(new UserUpdate(new User(authToken: token,id: int.parse(id),
            username: username,password: password ,first_name: first_name,
            last_name: last_name,address: address,city: city,
            email: email,phone_number: int.parse(phone_number),profile_picture:profile_picture)));
    };
};

class UserUpdate {
    final User user;

    UserUpdate(this.user);
}

final Function modifyPassword = (BuildContext context,String id,String token, String password) {
    Api api = Api();
    api.modifyPassword(id,token,password);
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
      final response3 = await api.copyWith(store.state.auth.user.authToken)
                                .getRanking(store.state.auth.user.city);
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
      final response3 = await api.getUserByEmail(email);
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

final Function modifyProfilePicture = (BuildContext context,String id,String token) {
    Api api = Api();
    return (Store<AppState> store) async{
        store.dispatch(new EditProfilePicRequest());
        // get image url
        var image_url = await api.upload(store.state.postFeedState.image);
        print(image_url);
        // modify api
        api.modifyProfilePicture(id,token,image_url);
        // modify state
        store.dispatch(new UserProfilePicture(image_url));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage()));
    };

};

class UserProfilePicture {
    final String profile_picture;
    UserProfilePicture(this.profile_picture);
}
