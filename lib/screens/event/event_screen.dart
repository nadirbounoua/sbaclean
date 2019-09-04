import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/event_actions.dart';
import '../../store/app_state.dart';
import 'widgets/event_list.dart';

class EventScreen extends StatelessWidget{
  Widget build(BuildContext context){
    return StoreConnector<AppState,Store<AppState>>(
        converter: (store) =>  store,
        onInit: (store) => store.dispatch(GetEventsAction(events:[]).getEvents()),
        builder: (context,store) {
          print(store.state.eventState.events);
          return Container(
            child: EventList(events: store.state.eventState.events),
          );
        }
    );
  }
}