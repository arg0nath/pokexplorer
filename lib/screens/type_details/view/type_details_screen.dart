import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/localization/app_localizations.dart';
import 'package:pokexplorer/router/app_router.dart' as app_router;
import 'package:pokexplorer/screens/type_details/bloc/type_details_bloc.dart';
import 'package:pokexplorer/core/models/app_models.dart' as app_models;
import 'package:pokexplorer/core/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/core/variables/app_constants.dart' as app_const;
import 'package:pokexplorer/core/variables/app_variables.dart' as app_vars;
import 'package:pokexplorer/core/widgets/app_widgets.dart' as app_widgets;

class TypeDetailsScreen extends StatefulWidget {
  const TypeDetailsScreen({super.key, required this.typeDetails});

  final app_models.PokemonTypeDetails typeDetails;

  @override
  State<TypeDetailsScreen> createState() => _TypeDetailsScreenState();
}

class _TypeDetailsScreenState extends State<TypeDetailsScreen> {
  late final TypeDetailsBloc _typeDetailsBloc = context.read<TypeDetailsBloc>();
  late final TextEditingController _searchingController = TextEditingController();
  late final ScrollController _typeDetailsScrollController = ScrollController();

  @override
  void initState() {
    _typeDetailsBloc.add(LoadTypeDetailsPokemonsEvent(typeDetails: widget.typeDetails));

    _typeDetailsScrollController.addListener(() {
      if (_typeDetailsScrollController.position.pixels == _typeDetailsScrollController.position.maxScrollExtent) {
        app_utils.myLog(level: app_const.LOG_WARNING, msg: 'bottomReached');
        _typeDetailsBloc.add(const LoadMoreTypeDetailsPokemonsEvent());
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchingController.dispose();
    _typeDetailsScrollController.dispose();
  }

  Future<bool> _onWillPop() async {
    if (_typeDetailsBloc.state.typeDetailsStatus != TypeDetailsStatus.loadingPokemons) {
      _typeDetailsBloc.add(const ExitTypeDetailsEvent());
    }
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
        await _onWillPop();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: _typeDetailsBody(),
      ),
    );
  }

  Widget _typeDetailsBody() {
    return BlocConsumer<TypeDetailsBloc, TypeDetailsState>(
        listener: (context, state) async {
          if (state.typeDetailsStatus == TypeDetailsStatus.loadingPokemons) {
            await app_utils.showLoadingDialog(context);
          } else if (state.typeDetailsStatus == TypeDetailsStatus.pokemonsLoaded) {
            Navigator.pop(context); //close loading dialog
          } else if (state.typeDetailsStatus == TypeDetailsStatus.navigatingToPokemonDetails) {
            await app_utils.showLoadingDialog(context);
          } else if (state.typeDetailsStatus == TypeDetailsStatus.readyToNavigateToPokemonDetails) {
            Navigator.popAndPushNamed(context, app_const.POKEMON_DETAILS_SCREEN_ROUTE_NAME,
                arguments: app_router.PokemonDetailsScreenArguments(selectedTypeName: _typeDetailsBloc.selectedTypeName, pokemon: _typeDetailsBloc.selectedPokemon));
          } else if (state.typeDetailsStatus == TypeDetailsStatus.morePokemonsLoadedFailed) {
            app_utils.myToast(context, LocalizationManager.getInstance().generalErrorMessage);
          } else if (state.typeDetailsStatus == TypeDetailsStatus.readyToNotifyForNoInternet) {
            app_utils.myToast(context, LocalizationManager.getInstance().connectionFailure);
          } else if (state.typeDetailsStatus == TypeDetailsStatus.errorNavigateToPokemonDetailsFailed) {
            app_utils.myToast(context, LocalizationManager.getInstance().generalErrorMessage);
            Navigator.pop(context); //close dialog
          } else if (state.typeDetailsStatus == TypeDetailsStatus.typeDetailsExited) {
            Navigator.pop(context);
          }
        },
        buildWhen: (previous, current) => current.typeDetailsStatus != TypeDetailsStatus.navigatingToPokemonDetails && current.typeDetailsStatus != TypeDetailsStatus.readyToNavigateToPokemonDetails,
        builder: (context, typeDetailsState) {
          List<app_models.PokemonPreview> displayList =
              typeDetailsState.searchedPokemonPreviewList.isNotEmpty ? typeDetailsState.searchedPokemonPreviewList : _typeDetailsBloc.selectedTypePokemonPreviewList;

          return RefreshIndicator(
            onRefresh: () async {
              _typeDetailsBloc.add(LoadTypeDetailsPokemonsEvent(typeDetails: widget.typeDetails));
            },
            child: Scrollbar(
              controller: _typeDetailsScrollController,
              thumbVisibility: false,
              child: CustomScrollView(
                controller: _typeDetailsScrollController,
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverSearchAppBar(selectedTypeName: widget.typeDetails.name, textEditingController: _searchingController),
                  ),
                  //search results not found
                  if (typeDetailsState.searchedPokemonPreviewList.isEmpty && typeDetailsState.typeDetailsStatus == TypeDetailsStatus.pokemonSearched)
                    const SliverToBoxAdapter(
                      child: Center(child: app_widgets.NoPokemonIndicator()),
                    ),
                  // search results found
                  if (typeDetailsState.searchedPokemonPreviewList.isNotEmpty)
                    SliverList.builder(
                      itemCount: displayList.length,
                      itemBuilder: (context, index) => app_widgets.PokemonListCard(
                        onFavoriteIconTap: () => _typeDetailsBloc.add(UpdateRelationInTypeDetailsEvent(pokemonPreview: displayList[index])),
                        onCardTap: () => _typeDetailsBloc.add(NavigateToDetailsFromTypeDetailsEvent(pokemonPreview: displayList[index])),
                        pokemonPreview: displayList[index],
                      ),
                    ),
                  // default list w/ no search results
                  if (typeDetailsState.searchedPokemonPreviewList.isEmpty && typeDetailsState.typeDetailsStatus != TypeDetailsStatus.pokemonSearched)
                    SliverList.builder(
                      itemCount: _typeDetailsBloc.selectedTypePokemonPreviewList.length,
                      itemBuilder: (context, index) => app_widgets.PokemonListCard(
                        onFavoriteIconTap: () => _typeDetailsBloc.add(UpdateRelationInTypeDetailsEvent(pokemonPreview: displayList[index])),
                        onCardTap: () => _typeDetailsBloc.add(NavigateToDetailsFromTypeDetailsEvent(pokemonPreview: _typeDetailsBloc.selectedTypePokemonPreviewList[index])),
                        pokemonPreview: _typeDetailsBloc.selectedTypePokemonPreviewList[index],
                      ),
                    ),
                  // load more Pokemon
                  if (typeDetailsState.typeDetailsStatus == TypeDetailsStatus.loadingMorePokemons)
                    const SliverToBoxAdapter(child: SizedBox(width: double.infinity, height: 50, child: Center(child: app_widgets.CustomProgressIndicator()))),
                ],
              ),
            ),
          );
        });
  }
}

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  SliverSearchAppBar({
    required this.selectedTypeName,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;
  final String selectedTypeName;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final TypeDetailsBloc typeDetailsBloc = context.read<TypeDetailsBloc>();
    double adjustedShrinkOffset = shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.3; //was 0.4
    double topPadding = MediaQuery.of(context).padding.top + 10;
    return BlocBuilder<TypeDetailsBloc, TypeDetailsState>(
      builder: (context, state) {
        return SizedBox(
          height: app_const.TYPE_DETAILS_APP_BAR_DELEGATE_MAX_EXTEND,
          child: Stack(
            children: [
              //cool gradient background
              app_widgets.AppbarGradientBackground(
                typeName: selectedTypeName,
              ),

              //type icon + name
              Positioned(
                top: topPadding,
                child: SizedBox(
                  width: app_vars.logicalWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      app_widgets.CustomAppbarBackButton(onPressed: () => typeDetailsBloc.add(const ExitTypeDetailsEvent())),
                      app_widgets.SelectedTypeContainer(typeName: selectedTypeName),
                    ],
                  ),
                ),
              ),
              //search bar
              Positioned(
                  top: (topPadding + app_vars.logicalHeight * 0.055) + offset * 0.3,
                  left: 16,
                  right: 16,
                  child: SizedBox(
                    height: 50,
                    width: app_vars.logicalWidth - 32,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: _customTextFormField(typeDetailsBloc, context),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  TextFormField _customTextFormField(TypeDetailsBloc typeDetailsBloc, BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: app_const.PRIMARY_TEXT_COLOR, fontFamily: app_const.MAIN_FONT_FAMILY),
      controller: textEditingController,
      decoration: InputDecoration(
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          filled: Theme.of(context).inputDecorationTheme.filled,
          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          border: Theme.of(context).inputDecorationTheme.border,
          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
          hintText: LocalizationManager.getInstance().searchBarTitle,
          suffixIcon: _customSuffixIcon(typeDetailsBloc, context),
          prefixIcon: textEditingController.value.text.isEmpty ? null : _customPrefixButton(typeDetailsBloc)),
      onChanged: (value) {
        if (value.isEmpty) {
          typeDetailsBloc.add(const ReturnFromSearchEvent());
        }
      },
      onTapOutside: (val) => FocusScope.of(context).unfocus(),
      onFieldSubmitted: (String val) => val.isNotEmpty ? typeDetailsBloc.add(SearchPokemonEvent(value: val)) : null,
    );
  }

  IconButton _customSuffixIcon(TypeDetailsBloc typeDetailsBloc, BuildContext context) {
    return IconButton(
        icon: Icon(Icons.search, color: app_utils.gradientFromType(selectedTypeName).first),
        onPressed: () {
          if (textEditingController.value.text.isNotEmpty) {
            typeDetailsBloc.add(SearchPokemonEvent(value: textEditingController.value.text));
            FocusScope.of(context).unfocus();
          }
        });
  }

  GestureDetector _customPrefixButton(TypeDetailsBloc typeDetailsBloc) {
    return GestureDetector(
        onTap: () {
          typeDetailsBloc.add(const ReturnFromSearchEvent());
          textEditingController.clear();
        },
        child: const Icon(Icons.clear_rounded, color: app_const.SECONDARY_TEXT_COLOR));
  }

  @override
  double get maxExtent => app_const.TYPE_DETAILS_APP_BAR_DELEGATE_MAX_EXTEND;

  @override
  double get minExtent => app_const.TYPE_DETAILS_APP_BAR_DELEGATE_MIN_EXTEND;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
