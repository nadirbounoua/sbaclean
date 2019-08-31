import 'package:sbaclean/store/app_state.dart';
import 'package:redux/redux.dart';

import 'feed_middleware.dart';
import 'post_feed_middleware.dart';

List<Middleware<AppState>> middlewares() {
  return List<Middleware<AppState>>.from(feedMiddleware())
            ..addAll(postFeedMiddleware());
}

