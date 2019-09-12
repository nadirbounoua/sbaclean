import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../actions/report_actions.dart';
import '../../../store/app_state.dart';
import 'post_preview.dart';
import '../../../models/anomaly.dart';
import 'package:sbaclean/screens/anomaly_details/anomaly_details.dart';
class PostList extends StatelessWidget {
  final List<Anomaly> posts;

  PostList({Key key, this.posts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        onInit: (store) {
          store.dispatch(
              getReport(context,store.state.auth.user.id.toString()));
        },
        converter: (store) => store.state,
        builder: (context, state) {
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> AnomalyDetails(anomaly:posts[index]))),
                  child: new PostPreview(anomaly: posts[index], reported: checkAnomaly(state.reportState.reports,posts[index].id)))
              ;
            },
          );});
  }
}
