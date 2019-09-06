import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/event_actions.dart';
import 'package:sbaclean/screens/event/widgets/event_loading.dart';
import 'package:sbaclean/screens/feed/widgets/post_loading.dart';
import '../../store/app_state.dart';
import 'widgets/event_list.dart';

class EventScreen extends StatelessWidget{
  Widget build(BuildContext context){
    return StoreConnector<AppState,Store<AppState>>(
        converter: (store) =>  store,
        onInit: (store)  {
           store.dispatch(GetEventsAction(events:[]));
        },
        builder: (context,store) {
          print(store.state.eventState.isEventsLoading);
          return Container(
            
            child:store.state.eventState.isEventsLoading ? 
            ListView(children: <Widget>[EventLoading(), EventLoading(),EventLoading(),EventLoading(),],physics: NeverScrollableScrollPhysics(),)
            : EventList(events: store.state.eventState.events),
          );
        }
    );
  }
}