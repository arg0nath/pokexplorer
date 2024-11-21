import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokexplorer/screens/pokemon_details/bloc/pokemon_details_bloc.dart';
import 'package:pokexplorer/src/variables/app_variables.dart' as app_vars;

import '../../../src/models/app_models.dart' as app_models;
import '../../../src/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/src/widgets/app_widgets.dart' as app_widgets;
import '../../../src/variables/app_constants.dart' as app_const;

class PokemonDetailsScreen extends StatefulWidget {
  const PokemonDetailsScreen({super.key, required this.pokemon});

  final app_models.Pokemon pokemon;

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  late final PokemonDetailsBloc _pokemonDetailsBloc = context.read<PokemonDetailsBloc>();
  final CarouselSliderController _pokeDetailsCarouselController = CarouselSliderController();

  @override
  void initState() {
    _pokemonDetailsBloc.add(LoadPokemonDetailsEvent(name: widget.pokemon.name));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onDetailsWillPop() async {
    Navigator.pop(context);

    return Future<bool>.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final tmpImageList = [
      widget.pokemon.hqImageUrl,
      widget.pokemon.lqImageUrl,
    ];
    if (widget.pokemon.gifUrl != null) tmpImageList.add(widget.pokemon.gifUrl!);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        await _onDetailsWillPop();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_outlined, color: app_const.PRIMARY_TEXT_COLOR)),
            backgroundColor: Colors.transparent,
          ),
          extendBody: true,
          backgroundColor: const Color(0xFFF7F7F7),
          extendBodyBehindAppBar: true,
          body: BlocConsumer<PokemonDetailsBloc, PokemonDetailsState>(listener: (context, state) {
            if (state.pokemonDetailsStatus == PokemonDetailsStatus.loadingPokemonDetailsError) {
              app_utils.myToast(context, app_const.GENERIC_ERROR_TOAST_MESSAGE);
              Navigator.pop(context);
            }
          }, builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    color: const Color(0xFFF7F7F7),
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: PokemonDetailsBackgroundWaveClipper(),
                          child: Container(
                            width: app_vars.logicalWidth,
                            height: app_const.POKEMON_DETAILS_APP_BAR_DELEGATE_MAX_EXTEND,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: app_utils.gradientFromType(widget.pokemon.types.first.name)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: app_vars.logicalHeight * 0.1,
                          // left: (app_vars.logicalWidth - 240) / 2,
                          child: SizedBox(
                            width: app_vars.logicalWidth,
                            height: app_vars.logicalHeight * 0.4,
                            child: CarouselSlider.builder(
                              carouselController: _pokeDetailsCarouselController,
                              itemCount: tmpImageList.length,
                              itemBuilder: (BuildContext context, int visiblePageIdx, int realIndex) {
                                return app_widgets.CustomNetworkImage(imageURL: tmpImageList[visiblePageIdx]);
                              },
                              options: CarouselOptions(
                                viewportFraction: 0.5,
                                autoPlay: false,
                                aspectRatio: 16 / 9,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: false,
                                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                                initialPage: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(color: Color(0xFFB4B4B4), blurRadius: 30, spreadRadius: 2, offset: Offset(0, -4))],
                      color: app_const.TOTAL_WHITE,
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
                            color: app_const.TOTAL_WHITE,
                            width: app_vars.logicalWidth * 0.2,
                            child: const Icon(
                              Icons.info_outline_rounded,
                              size: 30,
                            )),
                        Expanded(flex: 3, child: app_widgets.MyText(widget.pokemon.name.toUpperFirst(), style: const TextStyle(fontSize: 23))),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: app_vars.logicalWidth,
                  color: app_const.TOTAL_WHITE,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: widget.pokemon.types.length,
                    itemBuilder: (context, index) {
                      return Container(margin: EdgeInsets.only(left: app_vars.logicalWidth * 0.05), child: app_widgets.SelectedTypeContainer(typeName: widget.pokemon.types[index].name));
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: app_const.TOTAL_WHITE,
                    width: app_vars.logicalWidth,
                    child: Row(
                      children: [
                        Expanded(
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                          const Icon(Icons.fitness_center_rounded, color: app_const.SECONDARY_TEXT_COLOR),
                          app_widgets.MyText('Weight:  ${widget.pokemon.weight}', style: const TextStyle(color: app_const.SECONDARY_TEXT_COLOR)),
                        ])),
                        Expanded(
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                          const Icon(Icons.height_rounded, color: app_const.SECONDARY_TEXT_COLOR),
                          app_widgets.MyText('Height:  ${widget.pokemon.height}', style: const TextStyle(color: app_const.SECONDARY_TEXT_COLOR)),
                        ])),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Container(
                      color: app_const.TOTAL_WHITE,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: app_vars.logicalWidth * 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          app_widgets.CustomPercentIndicator(type: widget.pokemon.types.first.name, name: 'HP', value: widget.pokemon.hp),
                          app_widgets.CustomPercentIndicator(type: widget.pokemon.types.first.name, name: 'ATT', value: widget.pokemon.attack),
                          app_widgets.CustomPercentIndicator(type: widget.pokemon.types.first.name, name: 'DEF', value: widget.pokemon.defense),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          })),
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
