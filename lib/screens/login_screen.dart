import 'package:flutter/material.dart';

import 'package:sbaclean/containers/login_form.dart';
import 'package:sbaclean/styles/colors.dart';

class LoginScreen extends StatelessWidget {
    LoginScreen({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            body: new SingleChildScrollView(
                child: new Padding(
                    padding: new EdgeInsets.fromLTRB(32.0, MediaQuery.of(context).padding.top + 32.0, 32.0, 32.0),
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                            new Container(
                                child: new Center(
                                    child: new FlutterLogo(
                                        colors: colorStyles['primary'],
                                        size: 150.0,
                                    ),
                                ),
                            ),
                            new LoginForm(),
                        ],
                    )
                )
            )
        );
    }

}