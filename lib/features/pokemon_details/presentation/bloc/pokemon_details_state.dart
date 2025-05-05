part of 'pokemon_details_bloc.dart';

sealed class PokemonDetailsState extends Equatable {
  const PokemonDetailsState();
  
  @override
  List<Object> get props => [];
}

final class PokemonDetailsInitial extends PokemonDetailsState {}
