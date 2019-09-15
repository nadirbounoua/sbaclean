import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../store/app_state.dart';
import '../screens/profile_screen.dart';
import '../models/user.dart';
import '../actions/auth_actions.dart';
import '../models/user.dart';

class ProfilePage extends StatelessWidget{


  Widget build(BuildContext context) {
    return StoreConnector<AppState,User> (
        converter: (store) =>  store.state.auth.user,
        builder: (context,profile) {
          print(profile.username);
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile Page'),
            ),
            body: ProfileScreen(first_name : profile.first_name, last_name: profile.last_name, address: profile.address, city: profile.city, email: profile.email, phone: profile.phone_number, profile_picture: profile.profile_picture),
          );
        }
    );
  }
}


//body: ProfileScreen(first_name : pro.first_name, last_name: pro.last_name, address: pro.address, city: pro.city, email: pro.email, phone: pro.phone),

/*
 Profile pro = new Profile();
          GetUser getuser =new GetUser();
          final profile = getuser.getUser(context,user.id,user.token);
          profile.then((value){
            pro = value;
          });
 */