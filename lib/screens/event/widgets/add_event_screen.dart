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
                child:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                            new AddEventForm(),
                        ],
                    )
                )
            
        );
    }

}