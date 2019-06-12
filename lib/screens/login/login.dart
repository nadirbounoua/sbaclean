import 'package:flutter/material.dart';

void main() => runApp(Login());

class Login extends StatelessWidget {
  static String _title = "Login";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: LoginWidget(),
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  LoginWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 30,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Numéro de téléphone",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                    contentPadding: EdgeInsets.only(top: 50)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                    contentPadding: EdgeInsets.only(top: 50)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Expanded(
              child: RaisedButton(
                color: Colors.redAccent,
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.email),
                    Text("Login with Gmail")
                  ],
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
          ],
        ),
      ],
    );
  }

}