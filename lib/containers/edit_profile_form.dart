import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../store/app_state.dart';
import '../actions/auth_actions.dart';
import '../presentation/platform_adaptive.dart';
import '../actions/city_actions.dart';
import '../screens/profile_screen.dart';

class EditProfileForm extends StatefulWidget {
  List<String> cities;
  EditProfileForm({this.cities});
  @override
  _EditProfileFormState createState() => new _EditProfileFormState(cities: cities);
}

class _EditProfileFormState extends State<EditProfileForm> {
  final formKey = new GlobalKey<FormState>();
  String _username;
  String _email;
  String _first_name;
  String _last_name;
  String _phone_number;
  String _address;
  String _city;
  List<String> cities;

  _EditProfileFormState({this.cities});
  @override
  void initState() {
    _city = cities[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, dynamic>(
        converter: (Store<AppState> store) {
          return (BuildContext context,String username, String email,
              String first_name,String last_name, String phone_number, String address, String city)
          =>
              store.dispatch(modifyPersonal(context,store.state.auth.user.id.toString(),
                  store.state.auth.user.authToken,store.state.auth.user.password
                  ,username,email, first_name,last_name,phone_number,address,
                  city,store.state.auth.user.profile_picture));

        },
        builder: (BuildContext context, updateAction) {
          return StoreConnector<AppState,AppState> (
              converter: (store) =>  store.state,
              builder: (context,state) {
                return new Form(
                  key: formKey,
                  child: new Column(
                    children: [
                      new TextFormField(
                        decoration:
                        new InputDecoration(labelText: 'Username'),
                        initialValue: state.auth.user.username,
                        validator: (val) => val.isEmpty
                            ? 'Please enter your username.'
                            : null,
                        onSaved: (val) => _username = val,
                      ),
                      new TextFormField(
                        decoration:
                        new InputDecoration(labelText: 'Email'),
                        initialValue: state.auth.user.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val){
                          if (val.isEmpty) {
                            return 'Please entre the email';
                          }
                          if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)) {
                            return 'Please entre a valid emailAddress';
                          }

                          return null;
                        },
                        onSaved: (val) => _email = val,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'FirstName'),
                        initialValue: state.auth.user.first_name,
                        validator: (val) =>
                        val.isEmpty ? 'Please enter your firstname.' : null,
                        onSaved: (val) => _first_name = val,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'LastName'),
                        initialValue: state.auth.user.last_name,
                        validator: (val) =>
                        val.isEmpty ? 'Please enter your username.' : null,
                        onSaved: (val) => _last_name = val,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'Phone'),
                        keyboardType: TextInputType.phone,
                        initialValue: state.auth.user.phone_number.toString(),
                        validator: (val) =>
                        val.isEmpty ? 'Please enter your phone number.' : null,
                        onSaved: (val) => _phone_number = val,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'Address'),
                        initialValue: state.auth.user.address,
                        validator: (val) =>
                        val.isEmpty ? 'Please enter your address.' : null,
                        onSaved: (val) => _address = val,
                      ),
                      DropdownButton<String>(
                        value: _city,
                        items: cities.map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                            .toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            _city = newValue;
                          });
                        },
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(top: 20.0),
                        child: new FlatButton(
                          onPressed:() {
                            final form = formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              updateAction(context,_username,_email, _first_name,_last_name,_phone_number,
                                  _address,(cities.indexOf(_city) + 1).toString());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(first_name: _first_name,
                                        last_name: _last_name,phone: int.parse(_phone_number),email: _email,
                                        address: _address,city: _city,profile_picture: state.auth.user.profile_picture),
                                  ));
                            }
                          },
                          child: new Text('Save'),
                        ),
                      ),
                    ],
                  ),
                );
              });});
  }

}