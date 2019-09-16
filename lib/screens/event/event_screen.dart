import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/event_actions.dart';
import 'package:sbaclean/screens/event/widgets/add_event_screen.dart';
import 'package:sbaclean/screens/event/widgets/event_loading.dart';
import 'package:sbaclean/screens/feed/widgets/post_loading.dart';
import 'package:sbaclean/screens/main/main.dart';
import 'package:unicorndial/unicorndial.dart';
import '../../actions/participation_actions.dart';
import '../../store/app_state.dart';
import 'widgets/event_list.dart';

class EventScreen extends StatelessWidget{
  Widget build(BuildContext context){
    return StoreConnector<AppState,Store<AppState>>(
        converter: (store) =>  store,
        onInit: (store)  {
           store.dispatch(GetEventsAction(events:[]));
           store.dispatch(
               getParticipations(context));
        },
        builder: (context,store) {
          print(store.state.eventState.isEventsLoading);
          return Scaffold(
            body: Container(
            
            child:store.state.eventState.isEventsLoading ? 
            ListView(children: <Widget>[EventLoading(), EventLoading(),EventLoading(),EventLoading(),],physics: NeverScrollableScrollPhysics(),)
            : EventList(events: store.state.eventState.events,participations: store.state.participationState.participations),
          ),
            floatingActionButton: UnicornDialer(
          parentButton: Icon(Icons.add),
          childButtons: <UnicornButton>[
            UnicornButton(
              hasLabel: true,
              labelText: "Ajouter une anomalie",
              labelHasShadow: true,
              labelBackgroundColor: Colors.orange[400],
              labelColor: Colors.white,
              currentButton: FloatingActionButton(
                heroTag: 'btn1',
                mini: true,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreenWidget())),
                backgroundColor: Colors.orange[400],
                child: Icon(Icons.warning),
              ),
            ),
            UnicornButton(
              hasLabel: true,
              labelText: "Ajouter un événement",
              labelHasShadow: true,
              labelBackgroundColor: Colors.red[400],
              labelColor: Colors.white,
              currentButton: FloatingActionButton(
                heroTag: 'btn2',
                mini: true,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddEventScreen())),
                backgroundColor: Colors.red[400],
                child: Icon(Icons.event),
              ),
            )

          ],
        ),
          ) ;
        }
    );
  }
}