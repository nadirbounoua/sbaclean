import 'package:flutter/material.dart';

import '../../../containers/login_form.dart';
import '../../../styles/colors.dart';
import 'add_event.dart';

class AddEventScreen extends StatelessWidget {
    AddEventScreen({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            appBar: AppBar(title: const Text('Add event')),
            body: new Container(
                child: new Padding(
                    padding: new EdgeInsets.fromLTRB(32.0, MediaQuery.of(context).padding.top + 32.0, 32.0, 32.0),
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                            new AddEventForm(),
                        ],
                    )
                )
            )
        );
    }

}