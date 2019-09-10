import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../screens/login_screen.dart';
import '../store/app_state.dart';
import '../actions/city_actions.dart';
import 'register_login_form.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => new _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = new GlobalKey<FormState>();
  String _username;
  String _phone_number;
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        onInit: (store) {
          store.dispatch(getCities(context));
        },
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
          return new Form(
            key: formKey,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new TextFormField(
                  decoration: new InputDecoration(labelText: "Username"),
                  keyboardType: TextInputType.text,
                  validator: (val) =>
                      val.isEmpty ? 'Please enter your username.' : null,
                  onSaved: (val) => _username = val,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                  validator: (val) =>
                      val.isEmpty ? 'Please enter your phone number.' : null,
                  onSaved: (val) => _phone_number = val,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) =>
                      val.isEmpty ? 'Please enter your address.' : null,
                  onSaved: (val) => _email = val,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Password'),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter your password.' : null,
                  onSaved: (val) => _password = val,
                  obscureText: true,
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new FlatButton(
                    onPressed: () {
                      final form = formKey.currentState;

                      if (form.validate()) {
                        form.save();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterLoginForm(
                                  cities: cities,
                                  username: _username,
                                  email: _email,
                                  password: _password,
                                  phone_number: _phone_number),
                            ));
                      }
                    },
                    child: new Text('Next'),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 1.0),
                  child: new FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: new Text('Have an account? Login'),
                  ),
                )
              ],
            ),
          );
        });
  }
}
