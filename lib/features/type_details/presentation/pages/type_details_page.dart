import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/extensions/string_ext.dart';
import 'package:pokexplorer/core/common/widgets/message_toast.dart';
import 'package:pokexplorer/core/common/widgets/preview_list_tile.dart';
import 'package:pokexplorer/core/routes/route_names.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/type_details/domain/entities/type_details.dart';
import 'package:pokexplorer/features/type_details/presentation/bloc/type_details_bloc.dart';

class TypeDetailsPage extends StatefulWidget {
  const TypeDetailsPage({super.key, required this.typeName});

  final String typeName;

  @override
  State<TypeDetailsPage> createState() => _TypeDetailsPageState();
}

class _TypeDetailsPageState extends State<TypeDetailsPage> {
  late TypeDetailsBloc typeDetailsBloc;
  late TextEditingController _searchingController;
  late ScrollController _typeDetailsScrollController;

  @override
  void initState() {
    super.initState();
    context.read<TypeDetailsBloc>().add(
          FetchTypeDetailsEvent(widget.typeName),
        );
    typeDetailsBloc = context.read<TypeDetailsBloc>();
    _searchingController = TextEditingController();
    _typeDetailsScrollController = ScrollController();
  }

  @override
  void dispose() {
    _searchingController.dispose();
    _typeDetailsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results for ${widget.typeName.toUpperFirst()}'),
      ),
      body: BlocConsumer<TypeDetailsBloc, TypeDetailsState>(
        listener: (BuildContext context, TypeDetailsState state) {
          state.maybeWhen(
            readyToProceedToPokemonDetails: (ProceedingStatus value) {
              if (value == ProceedingStatus.completed) {
                context.pushNamed(
                  RouteName.pokemonDetailsPageName,
                  pathParameters: <String, String>{
                    'pokemonName': typeDetailsBloc.selectedPokemonName,
                  },
                );
              }
            },
            error: (String message) {
              showPokeToast(context, message);
              context.pop();
            },
            orElse: () {},
          );
        },
        buildWhen: (TypeDetailsState previous, TypeDetailsState current) =>
            current != TypeDetailsState.readyToProceedToPokemonDetails(ProceedingStatus.completed) && current != TypeDetailsState.readyToProceedToPokemonDetails(ProceedingStatus.proceeding),
        builder: (BuildContext context, TypeDetailsState state) {
          return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              readyToProceedToPokemonDetails: (ProceedingStatus status) => const Center(child: Text('Proceeding...')),
              error: (String message) => Center(child: Text('Error: $message')),
              searching: () => const Center(child: CircularProgressIndicator()),
              searched: (List<PokemonPreview> searchResults) => buildPokemonList(searchResults),
              loaded: (TypeDetails typeDetails) => buildPokemonList(typeDetails.pokemons));
        },
      ),
    );
  }

  Widget buildPokemonList(List<PokemonPreview> pokemons) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchingController,
            decoration: const InputDecoration(
              labelText: 'Search Pokémon',
              border: OutlineInputBorder(),
            ),
            onChanged: (String query) {
              typeDetailsBloc.add(SearchPokemonsEvent(query));
            },
          ),
        ),
        Expanded(
          child: Scrollbar(
            controller: _typeDetailsScrollController,
            child: ListView.builder(
              controller: _typeDetailsScrollController,
              itemCount: pokemons.length,
              itemBuilder: (BuildContext context, int index) {
                final PokemonPreview pokemon = pokemons[index];
                return PreviewListTile(
                  preview: pokemon,
                  onTap: () {
                    typeDetailsBloc.add(ProceedToPokemonDetailsEvent(pokemon.name));
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
