import 'package:flutter/material.dart';
import 'event_preview.dart';
import '../../../models/event.dart';
class EventList extends StatelessWidget {
  final List<Event> events;

  EventList({Key key, this.events}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {

        return EventPreview(
          event : events[index]
          ,
        );
      },
    );
  }
}

