import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../screens/register_screen.dart';

import '../store/app_state.dart';
import '../actions/auth_actions.dart';

class LoginForm extends StatefulWidget {
    @override
    _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
    final formKey = new GlobalKey<FormState>();

    String _username;
    String _password;
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();

    void _submit() {
        final form = formKey.currentState;

        if (form.validate()) {
            form.save();
        }
    }
        @override
    void dispose() {
        _usernameController.dispose();
        _passwordController.dispose();

        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return new StoreConnector<AppState, Store<AppState>>(
            converter: (Store<AppState> store) => store,
            builder: (BuildContext context, store) {
                return new Form(
                    key: formKey,
                    child: new Column(
                        children: [
                            new TextFormField(
                                controller: _usernameController,
                                autocorrect: false,
                                decoration: new InputDecoration(labelText: 'Username'),
                                validator: (val) =>
                                    val.isEmpty ? 'Please enter your username.' : null,
                                onSaved: (val) => _username = val,
                            ),
                            new TextFormField(
                                controller: _passwordController, 
                                decoration: new InputDecoration(labelText: 'Password'),
                                validator: (val) =>
                                    val.isEmpty ? 'Please enter your password.' : null,
                                onSaved: (val) => _password = val,
                                obscureText: true,
                            ),
                                                       Container(
                              child: new StoreConnector<AppState,AppState>( converter:(store) => store.state,
                                  builder: (context,state) {
                                      if( state.auth.error == null){
                                          return Container();
                                      } else return
                                          Container(
                                              padding: EdgeInsets.only(top: 26.0, bottom: 4.0),
                                              child: Center(
                                                  child: Text(
                                                      "Username or password were incorrect.",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                      ),
                                                  ),
                                              ),
                                          );
                                  }
                              
                              ),
                            ),
                            new Padding(
                                padding: new EdgeInsets.only(top: 20.0),
                                child: new FlatButton(
                                    onPressed:() {
                                        _submit();
                                        store.dispatch(login(context, _username, _password));
                                    },
                                    child: store.state.auth.isAuthenticating ? CircularProgressIndicator() : new Text('Log In'),
                                ),
                            ),
                            new Padding(
                              padding: new EdgeInsets.only(top: 20.0),
                              child: new FlatButton(
                                onPressed:() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterScreen()),
                                  );
                                },
                                  child: new Text('Need an account? Register'),
                              ),
                            )
                        ],
                    ),
                );
            }
        );
    }

}