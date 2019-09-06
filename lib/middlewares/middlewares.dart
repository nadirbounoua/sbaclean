import 'package:redux_thunk/redux_thunk.dart';
import 'package:sbaclean/middlewares/event_middleware.dart';
import 'package:sbaclean/middlewares/user_history_middleware.dart';
import 'package:sbaclean/store/app_state.dart';
import 'package:redux/redux.dart';

import 'anomaly_details_middleware.dart';
import 'feed_middleware.dart';
import 'post_feed_middleware.dart';

List<Middleware<AppState>> middlewares= List<Middleware<AppState>>.from(feedMiddleware())
            ..addAll(postFeedMiddleware())
            ..addAll(userHistoryMiddleware())
            ..addAll(anomalyDetailsMiddleware())
            ..addAll(eventMiddleware())
            ..add(thunkMiddleware)
            ;


