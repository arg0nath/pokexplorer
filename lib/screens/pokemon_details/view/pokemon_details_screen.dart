import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/localization/app_localizations.dart';

import 'package:pokexplorer/screens/pokemon_details/bloc/pokemon_details_bloc.dart';
import 'package:pokexplorer/src/variables/app_variables.dart' as app_vars;

import '../../../src/models/app_models.dart' as app_models;
import '../../../src/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/src/widgets/app_widgets.dart' as app_widgets;
import '../../../src/variables/app_constants.dart' as app_const;

class PokemonDetailsScreen extends StatefulWidget {
  const PokemonDetailsScreen({super.key, required this.pokemon, required this.selectedTypeName});

  final app_models.Pokemon pokemon;
  final String selectedTypeName;

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  late final PokemonDetailsBloc _pokemonDetailsBloc = context.read<PokemonDetailsBloc>();

  @override
  void initState() {
    _pokemonDetailsBloc.add(LoadPokemonDetailsEvent(pokemon: widget.pokemon));
    super.initState();
  }

  Future<bool> _onDetailsWillPop() async {
    Navigator.pop(context);

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
          appBar: _pokeDetailsScreenAppbar(context), extendBody: true, backgroundColor: Theme.of(context).scaffoldBackgroundColor, extendBodyBehindAppBar: true, body: _pokeDetailsScreenBody()),
    );
  }

  BlocConsumer<PokemonDetailsBloc, PokemonDetailsState> _pokeDetailsScreenBody() {
    return BlocConsumer<PokemonDetailsBloc, PokemonDetailsState>(listener: (context, state) async {
      if (state.pokemonDetailsStatus == PokemonDetailsStatus.loadingPokemonDetails) {
        await app_utils.showLoadingDialog(context);
      } else if (state.pokemonDetailsStatus == PokemonDetailsStatus.pokemonDetailsLoaded) {
        Navigator.pop(context); //close loading dialog
      }
    }, builder: (context, state) {
      return PokemonDetailsPage(pokemonDetailsBloc: _pokemonDetailsBloc, selectedTypeName: widget.selectedTypeName);
    });
  }

  AppBar _pokeDetailsScreenAppbar(BuildContext context) {
    return AppBar(
      leading: app_widgets.CustomAppbarBackButton(
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}

class PokemonDetailsBackgroundWaveClipper extends CustomClipper<Path> {
// sweet maths
  @override
  Path getClip(Size size) {
    var path = Path();
    const minSize = app_const.POKEMON_DETAILS_APP_BAR_DELEGATE_MIN_EXTEND;
    final p1Diff = ((minSize - size.height) * 0.8).truncate().abs();
    path.lineTo(0.0, size.height - p1Diff);

    final controlPoint = Offset(size.width / 2, size.height + p1Diff); // symmetric
    final endPoint = Offset(size.width, size.height - p1Diff); // bottom right  -  bottom left

    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(PokemonDetailsBackgroundWaveClipper oldClipper) => oldClipper != this;
}

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage({super.key, required this.pokemonDetailsBloc, required this.selectedTypeName});

  final String selectedTypeName;

  final PokemonDetailsBloc pokemonDetailsBloc;

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  final CarouselSliderController _pokeDetailsCarouselController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor, //color between pokemon and card
            child: Stack(
              children: [
                app_widgets.AppbarGradientBackground(typeName: widget.selectedTypeName),
                Positioned(
                  top: app_vars.logicalHeight * 0.1,
                  child: SizedBox(
                    width: app_vars.logicalWidth,
                    height: app_vars.logicalHeight * 0.4,
                    child: CarouselSlider.builder(
                      carouselController: _pokeDetailsCarouselController,
                      options: _detailsCarouselOptions(),
                      itemCount: widget.pokemonDetailsBloc.pokemonImageList.length,
                      itemBuilder: (BuildContext context, int visiblePageIdx, int realIndex) {
                        return app_widgets.CustomNetworkImage(imageURL: widget.pokemonDetailsBloc.pokemonImageList[visiblePageIdx]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //name
        Expanded(
          flex: 1,
          child: _pokeDetailsName(context),
        ),
        //pokemon types
        Container(
          height: app_vars.logicalHeight * 0.05,
          width: app_vars.logicalWidth,
          color: Theme.of(context).cardColor,
          child: _pokeDetailsTypesList(),
        ),
        Expanded(
          flex: 1,
          child: _pokeDetailsWeightHeight(),
        ),
        Expanded(
          flex: 3,
          child: Center(
            child: Container(
              color: Theme.of(context).cardColor,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: app_vars.logicalWidth * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  app_widgets.CustomPercentIndicator(type: widget.pokemonDetailsBloc.selectedPokemon.types.first.name, name: 'HP', value: widget.pokemonDetailsBloc.selectedPokemon.hp),
                  app_widgets.CustomPercentIndicator(type: widget.pokemonDetailsBloc.selectedPokemon.types.first.name, name: 'ATT', value: widget.pokemonDetailsBloc.selectedPokemon.attack),
                  app_widgets.CustomPercentIndicator(type: widget.pokemonDetailsBloc.selectedPokemon.types.first.name, name: 'DEF', value: widget.pokemonDetailsBloc.selectedPokemon.defense),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _pokeDetailsWeightHeight() {
    return Container(
      color: Theme.of(context).cardColor,
      width: app_vars.logicalWidth,
      child: Row(
        children: [
          Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const Icon(Icons.fitness_center_rounded),
            Text('${LocalizationManager.getInstance().weight}:  ${widget.pokemonDetailsBloc.selectedPokemon.weight}', style: Theme.of(context).textTheme.bodyMedium),
          ])),
          Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const Icon(Icons.height_rounded),
            Text('${LocalizationManager.getInstance().height}: ${widget.pokemonDetailsBloc.selectedPokemon.height}', style: Theme.of(context).textTheme.bodyMedium),
          ])),
        ],
      ),
    );
  }

  ListView _pokeDetailsTypesList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: widget.pokemonDetailsBloc.selectedPokemon.types.length,
      itemBuilder: (context, index) {
        return Container(
            color: Theme.of(context).cardColor,
            margin: EdgeInsets.only(left: app_vars.logicalWidth * 0.05),
            child: app_widgets.SelectedTypeContainer(typeName: widget.pokemonDetailsBloc.selectedPokemon.types[index].name));
      },
    );
  }

  Container _pokeDetailsName(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 30, spreadRadius: 2, offset: Offset(0, -4))],
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      width: app_vars.logicalWidth,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              color: Theme.of(context).cardColor,
              width: app_vars.logicalWidth * 0.2,
              child: const Icon(
                Icons.info_outline_rounded,
                size: 30,
              )),
          Expanded(flex: 3, child: Text(widget.pokemonDetailsBloc.selectedPokemon.name.toUpperFirst(), style: const TextStyle(fontSize: 23))),
        ],
      ),
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
