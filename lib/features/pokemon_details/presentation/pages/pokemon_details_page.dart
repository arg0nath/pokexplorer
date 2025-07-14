import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/features/pokemon_details/domain/entities/pokemon_details.dart';
import 'package:pokexplorer/features/pokemon_details/presentation/bloc/pokemon_details_bloc.dart';
//final String extraString = GoRouterState.of(context).extra! as String;

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage({super.key, required this.name});

  final String name;

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  late PokemonDetailsBloc pokemonDetailsBloc;
  @override
  void initState() {
    super.initState();

    context.read<PokemonDetailsBloc>().add(PokemonDetailsEvent.fetchPokemonDetails(widget.name));
  }

  @override
  Widget build(BuildContext context) {
    pokemonDetailsBloc = context.read<PokemonDetailsBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Results for ${widget.name}'),
      ),
      body: BlocConsumer<PokemonDetailsBloc, PokemonDetailsState>(
        listener: (BuildContext context, PokemonDetailsState state) {},
        builder: (BuildContext context, PokemonDetailsState state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (String message) => Center(child: Text('Error: $message')),
            loaded: (PokemonDetails pokemonDetails) {
              return Container(
                constraints: BoxConstraints.expand(),
                child: Text(pokemonDetails.name),
              );
            },
          );
        },
      ),
    );
  }
}
