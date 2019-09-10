import 'package:meta/meta.dart';
import 'package:sbaclean/models/participation.dart';


@immutable
class ParticipationState{

  final List<Participation> participations;


  ParticipationState({this.participations});

  ParticipationState copyWith({
    List<Participation> participations,
  }) {
    return ParticipationState(
        participations: participations ?? this.participations
    );
  }

  factory ParticipationState.fromJSON(Map<String, dynamic> json) => new ParticipationState(
    participations: json['participations'],
  );

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'participations': this.participations
  };
}