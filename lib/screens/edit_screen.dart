import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:sbaclean/containers/register_form.dart';
import 'package:sbaclean/styles/colors.dart';
import '../containers/edit_profile_form.dart';
import '../store/app_state.dart';
import '../actions/city_actions.dart';

class EditScreen extends StatelessWidget {
  EditScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(        
        converter: (store) => store.state,
        builder: (context, state) {
          List<String> cities = new List<String>();
          if (state.cityState.cities != null) {
            state.cityState.cities.forEach((f) {
              cities.add(f.name);
            });
          } else {
            cities.add("choose city");
          }
    return new Scaffold(
            appBar: AppBar(title: const Text('Edit Profile')),
            body: new Padding(
                padding: new EdgeInsets.fromLTRB(32.0, MediaQuery.of(context).padding.top + 32.0, 32.0, 32.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new EditProfileForm(cities: cities),
                  ],
                )
            )
        
    );});
  }

}