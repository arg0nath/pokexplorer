import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/localization/app_localizations.dart';

import 'package:pokexplorer/screens/pokemon_details/bloc/pokemon_details_bloc.dart';
import 'package:pokexplorer/core/enums/app_enums.dart';
import 'package:pokexplorer/core/variables/app_variables.dart' as app_vars;

import '../../../core/models/app_models.dart' as app_models;
import '../../../core/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/core/widgets/app_widgets.dart' as app_widgets;

class PokemonDetailsScreen extends StatefulWidget {
  const PokemonDetailsScreen({super.key, required this.pokemon, required this.selectedTypeName});

  final app_models.Pokemon pokemon;
  final String selectedTypeName;

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  late final PokemonDetailsBloc _pokemonDetailsBloc = context.read<PokemonDetailsBloc>();
  final CarouselSliderController _pokeDetailsCarouselController = CarouselSliderController();

  @override
  void initState() {
    _pokemonDetailsBloc.add(LoadPokemonDetailsEvent(pokemon: widget.pokemon));
    super.initState();
  }

  Future<bool> _onDetailsWillPop() async {
    _pokemonDetailsBloc.add(const ExitPokemonDetailsEvent());
    return Future<bool>.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        await _onDetailsWillPop();
      },
      child: Scaffold(
        appBar: _pokeDetailsScreenAppbar(context),
        extendBody: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        extendBodyBehindAppBar: true,
        body: _pokeDetailsScreenBody(),
      ),
    );
  }

  Widget _pokeDetailsScreenBody() {
    return BlocConsumer<PokemonDetailsBloc, PokemonDetailsState>(listener: (context, state) async {
      if (state.pokemonDetailsStatus == PokemonDetailsStatus.loadingPokemonDetails) {
        await app_utils.showLoadingDialog(context);
      } else if (state.pokemonDetailsStatus == PokemonDetailsStatus.pokemonDetailsLoaded) {
        Navigator.pop(context); //close loading dialog
      } else if (state.pokemonDetailsStatus == PokemonDetailsStatus.readyToExitPokemonDetails) {
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      return Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor, //color between pokemon and card
              child: Stack(
                children: [
                  //gradient effect of appbar
                  app_widgets.AppbarGradientBackground(typeName: widget.selectedTypeName),
                  //pokemon image list
                  Positioned(
                    top: app_vars.logicalHeight * 0.1,
                    child: _imagesCarousel(),
                  ),
                ],
              ),
            ),
          ),
          //name +favorite button bar
          Expanded(flex: 1, child: detailsCardTitle(context)),
          //pokemon types
          Container(
            height: app_vars.logicalHeight * 0.05,
            width: app_vars.logicalWidth,
            color: Theme.of(context).canvasColor,
            child: _pokeDetailsTypesList(context),
          ),
          Expanded(
            flex: 1,
            child: _pokeDetailsWeightHeight(context),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: _pokeDetailsPercentIndicators(context),
            ),
          ),
        ],
      );
    });
  }

  Container detailsCardTitle(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        boxShadow: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 10, spreadRadius: 0, offset: const Offset(0, -2))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      width: app_vars.logicalWidth,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(app_vars.logicalWidth * 0.05),
            child: const Icon(Icons.info_outline_rounded, size: 30),
          ),
          if (_pokemonDetailsBloc.selectedPokemon.name.isNotEmpty)
            Expanded(flex: 3, child: Text(_pokemonDetailsBloc.selectedPokemon.name.toUpperFirst(), style: Theme.of(context).textTheme.titleMedium)),
          app_widgets.CustomFavoriteButton(
            isFavorite: _pokemonDetailsBloc.selectedPokemon.isFavorite == RelationValue.favorite.value,
            onPressed: () => _pokemonDetailsBloc.add(const UpdatePokemonRelationEvent()),
          )
        ],
      ),
    );
  }

  SizedBox _imagesCarousel() {
    return SizedBox(
      width: app_vars.logicalWidth,
      height: app_vars.logicalHeight * 0.4,
      child: CarouselSlider.builder(
        carouselController: _pokeDetailsCarouselController,
        options: _detailsCarouselOptions(),
        itemCount: _pokemonDetailsBloc.pokemonImageList.length,
        itemBuilder: (BuildContext context, int visiblePageIdx, int realIndex) {
          final visibleImageUrl = _pokemonDetailsBloc.pokemonImageList[visiblePageIdx];

          return app_widgets.CustomNetworkImage(imageURL: visibleImageUrl);
        },
      ),
    );
  }

  AppBar _pokeDetailsScreenAppbar(BuildContext context) {
    return AppBar(
      leading: app_widgets.CustomAppbarBackButton(onPressed: () => _pokemonDetailsBloc.add(const ExitPokemonDetailsEvent())),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _pokeDetailsPercentIndicators(BuildContext context) {
    if (_pokemonDetailsBloc.selectedPokemon.types.isEmpty) return const SizedBox.shrink();
    return Container(
      color: Theme.of(context).canvasColor,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: app_vars.logicalWidth * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          app_widgets.CustomPercentIndicator(type: _pokemonDetailsBloc.selectedPokemon.types.first.name, name: 'HP', value: _pokemonDetailsBloc.selectedPokemon.hp),
          app_widgets.CustomPercentIndicator(type: _pokemonDetailsBloc.selectedPokemon.types.first.name, name: 'ATT', value: _pokemonDetailsBloc.selectedPokemon.attack),
          app_widgets.CustomPercentIndicator(type: _pokemonDetailsBloc.selectedPokemon.types.first.name, name: 'DEF', value: _pokemonDetailsBloc.selectedPokemon.defense),
        ],
      ),
    );
  }

  Widget _pokeDetailsWeightHeight(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      width: app_vars.logicalWidth,
      child: Row(
        children: [
          Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const Icon(Icons.fitness_center_rounded),
            Text('${LocalizationManager.getInstance().weight}:  ${_pokemonDetailsBloc.selectedPokemon.weight}', style: Theme.of(context).textTheme.bodyMedium),
          ])),
          Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const Icon(Icons.height_rounded),
            Text('${LocalizationManager.getInstance().height}: ${_pokemonDetailsBloc.selectedPokemon.height}', style: Theme.of(context).textTheme.bodyMedium),
          ])),
        ],
      ),
    );
  }

  Widget _pokeDetailsTypesList(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: _pokemonDetailsBloc.selectedPokemon.types.length,
      itemBuilder: (context, index) {
        return Container(
            color: Theme.of(context).cardColor,
            margin: EdgeInsets.only(left: app_vars.logicalWidth * 0.05),
            child: app_widgets.SelectedTypeContainer(typeName: _pokemonDetailsBloc.selectedPokemon.types[index].name));
      },
    );
  }

  CarouselOptions _detailsCarouselOptions() {
    return CarouselOptions(
      viewportFraction: 0.5,
      autoPlay: false,
      aspectRatio: 16 / 9,
      enlargeCenterPage: true,
      enableInfiniteScroll: false,
      enlargeStrategy: CenterPageEnlargeStrategy.scale,
      initialPage: 0,
    );
  }
}
