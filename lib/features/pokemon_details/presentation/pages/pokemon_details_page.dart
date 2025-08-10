import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/extensions/string_ext.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';
import 'package:pokexplorer/core/common/widgets/favorite_button.dart';
import 'package:pokexplorer/core/common/widgets/message_toast.dart';
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

    context.read<PokemonDetailsBloc>().add(FetchPokemonDetailsEvent(widget.name));
  }

  @override
  Widget build(BuildContext context) {
    pokemonDetailsBloc = context.read<PokemonDetailsBloc>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
            builder: (context, state) {
              return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () => SizedBox.shrink(),
                  error: (String message) => SizedBox.shrink(),
                  loaded: (PokemonDetails pokemonDetails) {
                    return FavoriteButton(
                      id: pokemonDetails.id,
                      name: pokemonDetails.name,
                    );
                  });
            },
          )
        ],
        title: Text('${widget.name.toUpperFirst()}'),
      ),
      body: BlocConsumer<PokemonDetailsBloc, PokemonDetailsState>(
        listener: (BuildContext context, PokemonDetailsState state) {
          state.maybeWhen(
            error: (String message) {
              showPokeToast(context, message);
              context.pop();
            },
            orElse: () {},
          );
        },
        builder: (BuildContext context, PokemonDetailsState state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (String message) => Center(child: Text('Error: $message')),
            loaded: (PokemonDetails pokemonDetails) {
              return Container(
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: <Widget>[
                    if (pokemonDetails.gifUrl != null) Image.network(pokemonDetails.gifUrl!),
                    Image.network(pokemonDetails.baseImageUrl),
                    Image.network(pokemonDetails.hdImageUrl),
                    Text('ID: ${pokemonDetails.id}'),
                    Text('Height: ${pokemonDetails.height}'),
                    Text('Weight: ${pokemonDetails.weight}'),
                    Text('HP: ${pokemonDetails.hp}'),
                    Text('Attack: ${pokemonDetails.attack}'),
                    Text('Defense: ${pokemonDetails.defense}'),
                    Text('Types: ${pokemonDetails.types.map((PokemonType type) => type.name).join(', ')}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
