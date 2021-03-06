import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../screens/main_screen.dart';
import '../store/app_state.dart';
import 'package:toast/toast.dart';
import '../actions/auth_actions.dart';
import '../actions/city_actions.dart';
import '../screens/profile_screen.dart';

class EditLoginInfo extends StatefulWidget {
@override
_EditLoginInfoState createState() => new _EditLoginInfoState();
}

class _EditLoginInfoState extends State<EditLoginInfo> {
  final formKey = new GlobalKey<FormState>();

  String _old_password;
  String _new_password;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        onInit: (store) {
          store.dispatch(getCities(context));
        },
        converter: (store) => store.state,
        builder: (context, state) {
          return new Scaffold(
              appBar: AppBar(title: const Text('Edit Login Infos')),
              body: new SingleChildScrollView(
                  child: new Padding(
                      padding: new EdgeInsets.fromLTRB(32.0,
                          MediaQuery.of(context).padding.top + 32.0, 32.0, 32.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Form(
                            key: formKey,
                            child: new Column(
                              children: [
                                new TextFormField(
                                  decoration: new InputDecoration(
                                      labelText: 'Old Password'),
                                  obscureText: true,
                                  validator: (val) => val.isEmpty
                                      ? 'Please enter your old password.'
                                      : null,
                                  onSaved: (val) => _old_password = val,
                                ),
                                new TextFormField(
                                  decoration: new InputDecoration(
                                      labelText: 'New Password'),
                                  obscureText: true,
                                  validator: (val) {
                                    if (val.length < 8) {
                                      return 'The Password must be at least 8 characters.';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) => _new_password = val,
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(top: 20.0),
                                  child: new FlatButton(
                                    onPressed: () {
                                      final form = formKey.currentState;
                                      if (form.validate()) {
                                        form.save();
                                        if (_old_password !=
                                            state.auth.user.password) {
                                          Toast.show(
                                              "Password is Incorrect", context,
                                              duration: Toast.LENGTH_SHORT,
                                              gravity: Toast.BOTTOM);
                                        } else {
                                          modifyPassword(
                                              context,
                                              state.auth.user.id,
                                              state.auth.user.authToken,
                                              _new_password);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => MainScreen(),
                                              ));
                                        }
                                      }
                                    },
                                    child: new Text('Save'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))));
        });
  }
}

