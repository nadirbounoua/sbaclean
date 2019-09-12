import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../actions/participation_actions.dart';
import '../../../models/participation.dart';
import '../../../store/app_state.dart';
import 'event_preview.dart';
import '../../../models/event.dart';
class EventList extends StatelessWidget {
  final List<Event> events;
  final List<Participation> participations;

  EventList({Key key, this.events, this.participations}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
    converter: (store) => store.state,
    builder: (context, state) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        //make condition

        List<Participation> participations_event = getParticipationsEvent(participations,events[index].id.toString());
        bool test_max = participations_event.length == events[index].max_participants;
        bool test_user = checkEvent(participations_event,state.auth.user.id);

        return EventPreview(
          event : events[index]
          ,
        );
      },
    );});
  }
}

