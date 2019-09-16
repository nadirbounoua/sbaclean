import 'package:meta/meta.dart';
import 'package:sbaclean/models/report.dart';


@immutable
class ReportState{

  final List<Report> reports;


  ReportState({this.reports = const []});

  ReportState copyWith({
    List<Report> reports,
  }) {
    return ReportState(
        reports: reports ?? this.reports
    );
  }

  factory ReportState.fromJSON(Map<String, dynamic> json) => new ReportState(
    reports: json['reports'],
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'reports': this.reports
  };
}