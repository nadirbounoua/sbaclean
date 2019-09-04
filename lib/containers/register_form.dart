import 'package:flutter/material.dart';
import '../screens/login_screen.dart';


import '../actions/auth_actions.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => new _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
          return new Form(
            key: formKey,
            child: new Column(
              children: [
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Username'),
                  validator: (val) =>
                  val.isEmpty ? 'Please enter your username.' : null,
                  onSaved: (val) => _username = val,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Phone'),
                  validator: (val) =>
                  val.isEmpty ? 'Please enter your phone number.' : null,
                  onSaved: (val) => _phone_number = val,
                ),
                new TextFormField(
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
                    onPressed:() {
                      _submit();
                      register(context,_username,_phone_number,_address,_city,_password);
                    },
                    child: new Text('Submit'),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new FlatButton(
                    onPressed:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()),
                      );

                    },
                    child: new Text('Have an account? Login'),
                  ),
                )
              ],
            ),
          );
  }

}