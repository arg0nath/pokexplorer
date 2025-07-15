import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/widgets/message_toast.dart';
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
  @override
  void initState() {
    super.initState();

    context.read<TypeDetailsBloc>().add(TypeDetailsEvent.fetchTypeDetails(widget.typeName));
    typeDetailsBloc = context.read<TypeDetailsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results for ${widget.typeName}'),
      ),
      body: BlocConsumer<TypeDetailsBloc, TypeDetailsState>(
        listener: (BuildContext context, TypeDetailsState state) {
          state.maybeMap(
            readyToProceedToPokemonDetails: (value) {
              if (value.status == ProceedingStatus.completed) {
                context.pushNamed(RouteName.pokemonDetailsPageName, pathParameters: <String, String>{'pokemonName': typeDetailsBloc.selectedPokemonName});
              }
            },
            error: (value) {
              showPokeToast(context, value.message);
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
            readyToProceedToPokemonDetails: (ProceedingStatus status) {
              // Optional: show some loading or overlay
              return const Center(child: Text('Proceeding...'));
            },
            error: (String message) => Center(child: Text('Error: $message')),
            loaded: (TypeDetails typeDetails) {
              return Container(
                constraints: BoxConstraints.expand(),
                child: ListView.builder(
                  itemCount: typeDetails.pokemons.length,
                  itemBuilder: (BuildContext context, int index) {
                    final PokemonPreview pokemon = typeDetails.pokemons[index];
                    return ListTile(
                      leading: Image.network(pokemon.thumbnail),
                      title: Text(pokemon.name),
                      onTap: () {
                        context.read<TypeDetailsBloc>().add(TypeDetailsEvent.proceedToPokemonDetails(pokemon.name));
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
