import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/auth_actions.dart';
import '../../store/app_state.dart';
import 'user_ranking_list.dart';
class UserRankingScreen extends StatelessWidget{
  Widget build(BuildContext context){
    return StoreConnector<AppState,Store<AppState>>(
        converter: (store) =>  store,
        onInit: (store) {
                    print('actions');

          store.dispatch(GetUserRankingAction([]).getRanking());
        },
        builder: (context,store) {
          return Scaffold(
            appBar: new AppBar(
              title: new Text("City Rankings"),
            ),
            body:RankList(rank:store.state.auth.ranks),
          );
        }
    );
  }
}