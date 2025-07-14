part of 'type_details_bloc.dart';

@freezed
class TypeDetailsEvent with _$TypeDetailsEvent {
  const factory TypeDetailsEvent.started() = _Started;
  const factory TypeDetailsEvent.fetchTypeDetails(final String typeName) = _FetchTypeDetails;
  const factory TypeDetailsEvent.proceedToPokemonDetails(final String pokemonName) = _ProceedToPokemonDetails;
}
