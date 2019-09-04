import 'package:flutter/material.dart';
import '../../screens/event/event_screen.dart';

class EventsTab extends StatelessWidget {
    EventsTab({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return new Center(
            child: new EventScreen(),
        );
    }

}