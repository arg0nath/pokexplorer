import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pokemon_details_event.dart';
part 'pokemon_details_state.dart';

class PokemonDetailsBloc extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  PokemonDetailsBloc() : super(PokemonDetailsInitial()) {
    on<PokemonDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
