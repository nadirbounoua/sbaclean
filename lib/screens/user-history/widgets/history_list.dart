import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/user_history_actions.dart';
import 'package:sbaclean/screens/event/widgets/event_loading.dart';
import 'package:sbaclean/screens/user-history/widgets/anomaly_preview.dart';
import 'package:sbaclean/screens/user-history/widgets/event_preview.dart';
import 'package:sbaclean/store/app_state.dart';

abstract class ListItem {}

class EventHistoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EventHistoryListState();
  }
  
}

class EventHistoryListState extends State<EventHistoryList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState,Store<AppState>>(
      onInit: (store) {

        store.dispatch(GetUserEventHistoryAction());
        store.dispatch(GetUserAnomaliesHistoryAction());

      },
      converter: (store) => store,
      builder: (context, store) {
        return 
        ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: store.state.userHistoryState.showEvent ? store.state.userHistoryState.userEvents.length : store.state.userHistoryState.userPosts.length,
          itemBuilder: (context, index) => store.state.userHistoryState.showEvent ? 
                      EventHistoryPreview(event: store.state.userHistoryState.userEvents[index],) 
                      : AnomalyHistoryPreview(anomaly: store.state.userHistoryState.userPosts[index],),
        );
      },
    );
  }
  
}