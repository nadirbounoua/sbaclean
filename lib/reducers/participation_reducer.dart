import 'package:redux/redux.dart';

import '../models/participation.dart';
import '../store/participation_state.dart';
import '../actions/participation_actions.dart';

Reducer<ParticipationState> participationReducer = combineReducers([
  new TypedReducer<ParticipationState, GetParticipationsAction>(getParticipations),
  new TypedReducer<ParticipationState, AddParticipationAction>(addParticipation),
  new TypedReducer<ParticipationState, RemoveParticipationAction>(removeParticipationReducer)


]);

ParticipationState getParticipations(ParticipationState state, GetParticipationsAction action) {
  return state.copyWith(participations: action.participations);
}

ParticipationState addParticipation(ParticipationState state, AddParticipationAction action) {
  return state.copyWith(participations: List.from(state.participations)..add(action.participation));
}

ParticipationState removeParticipationReducer(ParticipationState participationState, RemoveParticipationAction action) {
  return new ParticipationState();
}

