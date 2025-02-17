import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokexplorer/core/common/constants/app_constants.dart';
import 'package:pokexplorer/core/common/enums/app_enums.dart';
import 'package:pokexplorer/core/common/variables/app_variables.dart';
import 'package:pokexplorer/core/common/widgets/appbar_gradient.dart';
import 'package:pokexplorer/core/common/widgets/custom_appbar_back_button.dart';
import 'package:pokexplorer/core/common/widgets/custom_favorite_button.dart';
import 'package:pokexplorer/core/common/widgets/custom_network_image.dart';
import 'package:pokexplorer/core/common/widgets/selected_type_container.dart';
import 'package:pokexplorer/core/localization/app_localizations.dart';
import 'package:pokexplorer/core/theme/colors/app_palette.dart';
import 'package:pokexplorer/presentation/pokemon_details/bloc/pokemon_details_bloc.dart';

import '../../../core/common/models/app_models.dart';
import '../../../core/common/utilities/app_utils.dart';

class PokemonDetailsScreen extends StatefulWidget {
  const PokemonDetailsScreen({super.key, required this.pokemon, required this.selectedTypeName});

  final Pokemon pokemon;
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      layoutBuilder: (entries) {
        return Stack(
          alignment: Alignment.topCenter,
          children: entries,
        );
      },
      transitionBuilder: (child, animation, secondaryAnimation) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      duration: const Duration(milliseconds: 300),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        appBar: _pokeDetailsScreenAppbar(context),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: _pokeDetailsScreenBody(),
      ),
    );
  }

  Widget _pokeDetailsScreenBody() {
    return BlocConsumer<PokemonDetailsBloc, PokemonDetailsState>(listener: (context, state) async {
      if (state.pokemonDetailsStatus == PokemonDetailsStatus.loadingPokemonDetails) {
        await context.showLoadingDialog();
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
              child: Stack(
                children: [
                  //gradient effect of appbar
                  AppbarGradientBackground(color: AppUtils.getTypeColor(widget.selectedTypeName)),
                  //pokemon image list
                  Positioned(
                    top: logicalHeight * 0.1,
                    child: _imagesCarousel(),
                  ),
                ],
              ),
            ),
          ),
          //name +favorite button bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_pokemonDetailsBloc.selectedPokemon.name.isNotEmpty)
                  Expanded(flex: 3, child: Text(_pokemonDetailsBloc.selectedPokemon.name.toUpperFirst(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600))),
                CustomFavoriteButton(
                  isFavorite: _pokemonDetailsBloc.selectedPokemon.isFavorite == RelationValue.favorite.value,
                  onPressed: () => _pokemonDetailsBloc.add(const UpdatePokemonRelationEvent()),
                )
              ],
            ),
          ),
          //pokemon types
          SizedBox(
            height: logicalHeight * 0.05,
            width: logicalWidth,
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

  SizedBox _imagesCarousel() {
    return SizedBox(
      width: logicalWidth,
      height: logicalHeight * 0.4,
      child: CarouselSlider.builder(
        carouselController: _pokeDetailsCarouselController,
        options: _detailsCarouselOptions(),
        itemCount: _pokemonDetailsBloc.pokemonImageList.length,
        itemBuilder: (BuildContext context, int visiblePageIdx, int realIndex) {
          final visibleImageUrl = _pokemonDetailsBloc.pokemonImageList[visiblePageIdx];

          return CustomNetworkImage(imageURL: visibleImageUrl);
        },
      ),
    );
  }

  AppBar _pokeDetailsScreenAppbar(BuildContext context) {
    return AppBar(
      leading: CustomAppbarBackButton(onPressed: () => _pokemonDetailsBloc.add(const ExitPokemonDetailsEvent())),
      backgroundColor: AppPalette.transparent,
    );
  }

  Widget _pokeDetailsPercentIndicators(BuildContext context) {
    if (_pokemonDetailsBloc.selectedPokemon.types.isEmpty) return const SizedBox.shrink();
    return Container(
      alignment: Alignment.center,
      width: logicalWidth * 0.9,
      padding: EdgeInsets.symmetric(horizontal: logicalWidth * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomPercentIndicator(type: _pokemonDetailsBloc.selectedPokemon.types.first.name, name: 'HP', value: _pokemonDetailsBloc.selectedPokemon.hp),
          CustomPercentIndicator(type: _pokemonDetailsBloc.selectedPokemon.types.first.name, name: 'ATT', value: _pokemonDetailsBloc.selectedPokemon.attack),
          CustomPercentIndicator(type: _pokemonDetailsBloc.selectedPokemon.types.first.name, name: 'DEF', value: _pokemonDetailsBloc.selectedPokemon.defense),
        ],
      ),
    );
  }

  Widget _pokeDetailsWeightHeight(BuildContext context) {
    return SizedBox(
      width: logicalWidth,
      child: Row(
        children: [
          Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const Icon(Icons.scale_rounded),
            Text('${LocalizationManager.getInstance().weight}:  ${_pokemonDetailsBloc.selectedPokemon.weight}', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
          ])),
          Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const Icon(Icons.straighten),
            Text('${LocalizationManager.getInstance().height}: ${_pokemonDetailsBloc.selectedPokemon.height}', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
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
        return Container(margin: EdgeInsets.only(left: logicalWidth * 0.05), child: SelectedTypeContainer(typeName: _pokemonDetailsBloc.selectedPokemon.types[index].name));
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

class CustomPercentIndicator extends StatelessWidget {
  const CustomPercentIndicator({
    super.key,
    required this.value,
    required this.name,
    required this.type,
  });

  final String type;
  final String name;
  final int value;

  @override
  Widget build(BuildContext context) {
    final tmpPercent = (value) / 256; //bigest value
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$name :', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        LinearPercentIndicator(
          width: logicalWidth * 0.6,
          animation: true,
          barRadius: const Radius.circular(CIRCULAR_RADIUS),
          lineHeight: 20.0,
          animationDuration: 1500,
          percent: tmpPercent,
          progressColor: AppUtils.getTypeColor(type),
        ),
        Text('$value', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
