import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../store/app_state.dart';
import '../screens/register_screen.dart';
import '../screens/login_screen.dart';
import '../actions/auth_actions.dart';
import '../styles/colors.dart';
import '../actions/city_actions.dart';
import '../models/city.dart';

class RegisterLoginForm extends StatefulWidget {
  List<String> cities;
  String username;
  String phone_number;
  String email;
  String password;
  RegisterLoginForm(
      {this.username, this.phone_number, this.email, this.password,this.cities});
  @override
  _RegisterLoginFormState createState() => new _RegisterLoginFormState(
      cities: cities,
      username: username,
      email: email,
      password: password,
      phone_number: phone_number
  );
}

class _RegisterLoginFormState extends State<RegisterLoginForm> {
  final formKey = new GlobalKey<FormState>();
  String _first_name;
  String _last_name;
  String _address;
  String _city;
  String phone_number;
  String username;
  String password;
  String email;
  List<String> cities;

  _RegisterLoginFormState(
      {this.username, this.phone_number, this.email, this.password,this.cities});

  @override
  void initState() {
    _city = cities[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new SingleChildScrollView(
            child: new Padding(
                padding: new EdgeInsets.fromLTRB(32.0,
                    MediaQuery.of(context).padding.top + 32.0, 32.0, 32.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      child: new Center(
                        child: new FlutterLogo(
                          colors: colorStyles['primary'],
                          size: 100.0,
                        ),
                      ),
                    ),

                    new Form(
                      key: formKey,
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          new TextFormField(
                            decoration: new InputDecoration(
                                labelText: "FirstName"),
                            keyboardType: TextInputType.text,
                            validator: (val) => val.isEmpty
                                ? 'Please enter your firstname.'
                                : null,
                            onSaved: (val) => _first_name = val,
                          ),
                          new TextFormField(
                            decoration: new InputDecoration(
                                labelText: "LastName"),
                            keyboardType: TextInputType.text,
                            validator: (val) => val.isEmpty
                                ? 'Please enter your firstname.'
                                : null,
                            onSaved: (val) => _last_name = val,
                          ),
                          new TextFormField(
                            decoration:
                            new InputDecoration(labelText: "Address"),
                            keyboardType: TextInputType.text,
                            validator: (val) => val.isEmpty
                                ? 'Please enter your address.'
                                : null,
                            onSaved: (val) => _address = val,
                          ),
                          DropdownButton<String>(
                            value: _city,
                            items: cities
                                .map((label) => DropdownMenuItem(
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
                              onPressed: () {
                                final form = formKey.currentState;

                                if (form.validate()) {
                                  form.save();
                                  register(
                                      context,
                                      username,
                                      _first_name,
                                      _last_name,
                                      phone_number,
                                      (cities.indexOf(_city) + 1)
                                          .toString(),
                                      _address,
                                      email,
                                      password);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginScreen()),
                                  );
                                }
                              },
                              child: new Text('Register'),
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.only(top: 5.0),
                            child: new FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterScreen()),
                                );
                              },
                              child: new Text('back'),
                            ),
                          )
                        ],
                      ),
                    )

                  ],
                ))));
  }
}