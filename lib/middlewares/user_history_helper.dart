import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:sbaclean/actions/user_history_actions.dart';
import 'package:sbaclean/backend/utils.dart';
import 'package:sbaclean/models/anomaly.dart';
import 'package:sbaclean/store/app_state.dart';

getUserAnomaliesHistoryHelper(Store<AppState> store, List<Response> response) async {

  List<Anomaly> list = await parseAnomalies(response);
  print(list);
  store.dispatch(new FinishGetUserAnomaliesHistoryAction(list: list));
}