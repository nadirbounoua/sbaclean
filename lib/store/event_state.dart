import 'package:sbaclean/models/event.dart';
import 'package:meta/meta.dart';


@immutable
class EventState {

  final List<Event> events;
  final bool isEventsLoading;

  EventState({this.events = const [],
            this.isEventsLoading =false
  });

  EventState copyWith({
    List<Event> events,
    bool isEventsLoading,
  }) {
    return EventState(
        events: events ?? this.events,
        isEventsLoading: isEventsLoading ?? this.isEventsLoading
    );
  }

  factory EventState.fromJSON(Map<String, dynamic> json) => new EventState(
    events: json['events'],
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'events': this.events
  };
}