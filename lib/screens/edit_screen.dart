import 'package:flutter/material.dart';

import 'package:sbaclean/containers/register_form.dart';
import 'package:sbaclean/styles/colors.dart';
import '../containers/edit_profile_form.dart';

class EditScreen extends StatelessWidget {
  EditScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
            appBar: AppBar(title: const Text('Edit Profile')),
            body: new Padding(
                padding: new EdgeInsets.fromLTRB(32.0, MediaQuery.of(context).padding.top + 32.0, 32.0, 32.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new EditProfileForm(),
                  ],
                )
            )
        
    );
  }

}