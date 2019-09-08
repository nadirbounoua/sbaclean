import 'package:sbaclean/models/event.dart';
import 'package:meta/meta.dart';


@immutable
class EventState {

  final List<Event> events;
  final bool isEventsLoading;
  final bool isPostingEvent;

  EventState({this.events = const [],
            this.isEventsLoading =false,
            this.isPostingEvent = false
  });

  EventState copyWith({
    List<Event> events,
    bool isEventsLoading,
    bool isPostingEvent
  }) {
    return EventState(
        events: events ?? this.events,
        isEventsLoading: isEventsLoading ?? this.isEventsLoading,
        isPostingEvent: isPostingEvent ?? this.isPostingEvent
    );
  }

  factory EventState.fromJSON(Map<String, dynamic> json) => new EventState(
    events: json['events'] == null ? [] : json['events'] as List<Event>,
    isEventsLoading: json['isEventsLoading'] == null ? false : json['isEventsLoading'] as bool,

  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'events': this.events,
    'isEventsLoading' : this.isEventsLoading

  };
}