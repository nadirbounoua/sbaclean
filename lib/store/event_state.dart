import 'package:sbaclean/models/event.dart';
import 'package:meta/meta.dart';


@immutable
class EventState {

  final List<Event> events;


  EventState({this.events = const []});

  EventState copyWith({
    List<Event> events,
  }) {
    return EventState(
        events: events ?? this.events
    );
  }

  factory EventState.fromJSON(Map<String, dynamic> json) => new EventState(
    events: json['events'],
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'events': this.events
  };
}