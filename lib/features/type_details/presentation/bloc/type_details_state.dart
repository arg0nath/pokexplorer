part of 'type_details_bloc.dart';

@freezed
class TypeDetailsState with _$TypeDetailsState {
  const factory TypeDetailsState.initial() = _Initial;
  const factory TypeDetailsState.loading() = _Loading;
  const factory TypeDetailsState.loaded(TypeDetails typeDetails) = _Loaded;
  const factory TypeDetailsState.error(String message) = _Error;
  const factory TypeDetailsState.readyToProceedToPokemonDetails(ProceedingStatus status) = _ReadyToProceedToPokemonDetails;
}

enum ProceedingStatus {
  proceeding,
  completed,
}
