import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:sbaclean/models/user.dart';
import 'package:redux/redux.dart';
import '../screens/login_screen.dart';


import '../presentation/platform_adaptive.dart';
import '../actions/auth_actions.dart';

class EditProfileForm extends StatefulWidget {
  @override
  _EditProfileFormState createState() => new _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final formKey = new GlobalKey<FormState>();

  String _username;
  String _password;
  String _phone_number;
  String _address;
  String _city;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,User> (
    converter: (store) =>  store.state.auth.user,
    builder: (context,user) {
      return new Form(
      key: formKey,
      child: new Column(
        children: [
          new TextFormField(
            initialValue: user.username,
            decoration: new InputDecoration(labelText: 'Username'),
            validator: (val) =>
            val.isEmpty ? 'Please enter your username.' : null,
            onSaved: (val) => _username = val,
          ),
          new TextFormField(
            initialValue: user.phone_number.toString(),
            decoration: new InputDecoration(labelText: 'Phone'),
            validator: (val) =>
            val.isEmpty ? 'Please enter your phone number.' : null,
            onSaved: (val) => _phone_number = val,
          ),
          new TextFormField(
            initialValue: user.address,
            decoration: new InputDecoration(labelText: 'Address'),
            validator: (val) =>
            val.isEmpty ? 'Please enter your address.' : null,
            onSaved: (val) => _address = val,
          ),
          new TextFormField(
            decoration: new InputDecoration(labelText: 'City'),
            validator: (val) =>
            val.isEmpty ? 'Please enter your city.' : null,
            onSaved: (val) => _city = val,
          ),
          new Padding(
            padding: new EdgeInsets.only(top: 20.0),
            child: new PlatformAdaptiveButton(
              onPressed:() {
                _submit();
                modify(context,user.id,user.authToken,_username,_phone_number,_address,_city);
              },
              icon: new Icon(Icons.done),
              child: new Text('Submit'),
            ),
          ),
        ],
      ),
    );
    });
  }

}