import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/models/dtos/pokemon_type_dto.dart';
import 'package:pokexplorer/core/common/models/entities/pokemon_type.dart';
import 'package:pokexplorer/core/common/widgets/message_toast.dart';
import 'package:pokexplorer/core/common/widgets/preview_list_tile.dart';
import 'package:pokexplorer/core/routes/route_names.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/type_details/domain/entities/type_details.dart';
import 'package:pokexplorer/features/type_details/presentation/bloc/type_details_bloc.dart';
import 'package:pokexplorer/features/type_details/presentation/widgets/type_details_sliver_appbar.dart';

class TypeDetailsPage extends StatefulWidget {
  const TypeDetailsPage({super.key, required this.typeName});

  final String typeName;

  @override
  State<TypeDetailsPage> createState() => _TypeDetailsPageState();
}

class _TypeDetailsPageState extends State<TypeDetailsPage> {
  late PokemonType selectedType;
  late TypeDetailsBloc typeDetailsBloc;
  late TextEditingController _searchingController;
  late ScrollController _typeDetailsScrollController;

  @override
  void initState() {
    super.initState();
    selectedType = PokemonTypeDto.fromTypeName(widget.typeName).toEntity();
    context.read<TypeDetailsBloc>().add(
          FetchTypeDetailsEvent(selectedType.name),
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
    return PageTransitionSwitcher(
      layoutBuilder: (List<Widget> entries) {
        return Stack(
          alignment: Alignment.topCenter,
          children: entries,
        );
      },
      transitionBuilder: (Widget child, Animation<double> animation, Animation<double> secondaryAnimation) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      duration: const Duration(milliseconds: 300),
      child: Scaffold(
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
                searched: (List<PokemonPreview> searchResults) => _TypeDetailsPokeList(
                      pokemons: searchResults,
                      selectedType: selectedType,
                      scrollController: _typeDetailsScrollController,
                      searchController: _searchingController,
                    ),
                loaded: (TypeDetails typeDetails) => _TypeDetailsPokeList(
                      pokemons: typeDetails.pokemons,
                      selectedType: selectedType,
                      scrollController: _typeDetailsScrollController,
                      searchController: _searchingController,
                    ));
          },
        ),
      ),
    );
  }
}

class _TypeDetailsPokeList extends StatelessWidget {
  const _TypeDetailsPokeList({
    required this.pokemons,
    required this.selectedType,
    required this.scrollController,
    required this.searchController,
  });

  final List<PokemonPreview> pokemons;
  final PokemonType selectedType;
  final ScrollController scrollController;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final TypeDetailsBloc typeDetailsBloc = context.read<TypeDetailsBloc>();

    return RefreshIndicator(
      color: selectedType.color,
      onRefresh: () async {
        typeDetailsBloc.add(FetchTypeDetailsEvent(selectedType.name));
      },
      child: Scrollbar(
        controller: scrollController,
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverSearchAppBar(
                selectedType: selectedType,
                textEditingController: searchController,
              ),
            ),
            SliverList.builder(
              itemCount: pokemons.length,
              itemBuilder: (BuildContext context, int index) {
                final PokemonPreview pokemon = pokemons[index];
                return PreviewListTile(
                  preview: pokemon,
                  onCardTap: () {
                    typeDetailsBloc.add(
                      ProceedToPokemonDetailsEvent(pokemon.name),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
