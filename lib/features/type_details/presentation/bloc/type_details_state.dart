part of 'type_details_bloc.dart';

@freezed
class TypeDetailsState with _$TypeDetailsState {
  const factory TypeDetailsState.initial() = _Initial;
  const factory TypeDetailsState.loading() = _Loading;
  const factory TypeDetailsState.loaded(TypeDetails typeDetails) = _Loaded;
  const factory TypeDetailsState.error(String message) = _Error;
  const factory TypeDetailsState.readyToProceedToPokemonDetails(ProceedingStatus status) = _ReadyToProceedToPokemonDetails;
  const factory TypeDetailsState.searching() = _Searching;
  const factory TypeDetailsState.searched({required List<PokemonPreview> searchResults}) = _Searched;
}

//trying enums in state
enum ProceedingStatus {
  proceeding,
  completed,
}
