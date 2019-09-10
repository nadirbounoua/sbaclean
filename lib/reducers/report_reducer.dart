import 'package:redux/redux.dart';

import '../store/report_state.dart';
import '../actions/report_actions.dart';

Reducer<ReportState> reportReducer = combineReducers([
  new TypedReducer<ReportState, GetReportAction>(getReport),
  new TypedReducer<ReportState, AddReportAction>(addReport),


]);

ReportState getReport(ReportState state, GetReportAction action) {
  return state.copyWith(reports: action.reports);
}

ReportState addReport(ReportState state, AddReportAction action) {
  return state.copyWith(reports: List.from(state.reports)..add(action.report));
}


