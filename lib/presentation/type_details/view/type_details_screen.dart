import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/constants/app_constants.dart';
import 'package:pokexplorer/core/common/models/app_models.dart';
import 'package:pokexplorer/core/common/utilities/app_utils.dart';
import 'package:pokexplorer/core/common/variables/app_variables.dart';
import 'package:pokexplorer/core/common/widgets/appbar_gradient.dart';
import 'package:pokexplorer/core/common/widgets/custom_appbar_back_button.dart';
import 'package:pokexplorer/core/common/widgets/custom_progress_indicator.dart';
import 'package:pokexplorer/core/common/widgets/no_pokemon_indicator.dart';
import 'package:pokexplorer/core/common/widgets/pokemon_list_card.dart';
import 'package:pokexplorer/core/common/widgets/selected_type_container.dart';
import 'package:pokexplorer/core/localization/app_localizations.dart';
import 'package:pokexplorer/core/theme/colors/app_palette.dart';
import 'package:pokexplorer/presentation/type_details/bloc/type_details_bloc.dart';
import 'package:pokexplorer/router/app_router.dart';

class TypeDetailsScreen extends StatefulWidget {
  const TypeDetailsScreen({super.key, required this.typeDetails});

  final PokemonTypeDetails typeDetails;

  @override
  State<TypeDetailsScreen> createState() => _TypeDetailsScreenState();
}

class _TypeDetailsScreenState extends State<TypeDetailsScreen> {
  late final TypeDetailsBloc _typeDetailsBloc = context.read<TypeDetailsBloc>();
  late final TextEditingController _searchingController = TextEditingController();
  late ScrollController _typeDetailsScrollController;

  @override
  void initState() {
    _typeDetailsScrollController = ScrollController();
    _typeDetailsBloc.add(LoadTypeDetailsPokemonsEvent(typeDetails: widget.typeDetails));

    _typeDetailsScrollController.addListener(() {
      if (_typeDetailsScrollController.position.pixels == _typeDetailsScrollController.position.maxScrollExtent) {
        AppUtils.myLog(level: LOG_WARNING, msg: 'bottomReached');
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
        body: _typeDetailsBody(),
      ),
    );
  }

  Widget _typeDetailsBody() {
    return BlocConsumer<TypeDetailsBloc, TypeDetailsState>(
        listener: (context, state) async {
          if (state.typeDetailsStatus == TypeDetailsStatus.loadingPokemons) {
            await context.showLoadingDialog();
          } else if (state.typeDetailsStatus == TypeDetailsStatus.pokemonsLoaded) {
            Navigator.pop(context); //close loading dialog
          } else if (state.typeDetailsStatus == TypeDetailsStatus.navigatingToPokemonDetails) {
            await context.showLoadingDialog();
          } else if (state.typeDetailsStatus == TypeDetailsStatus.readyToNavigateToPokemonDetails) {
            Navigator.popAndPushNamed(context, RouteNames.pokeDetailsScreen,
                arguments: PokemonDetailsScreenArguments(selectedTypeName: _typeDetailsBloc.selectedTypeName, pokemon: _typeDetailsBloc.selectedPokemon));
          } else if (state.typeDetailsStatus == TypeDetailsStatus.morePokemonsLoadedFailed) {
            AppUtils.myToast(context, LocalizationManager.getInstance().generalErrorMessage);
          } else if (state.typeDetailsStatus == TypeDetailsStatus.readyToNotifyForNoInternet) {
            AppUtils.myToast(context, LocalizationManager.getInstance().connectionFailure);
          } else if (state.typeDetailsStatus == TypeDetailsStatus.errorNavigateToPokemonDetailsFailed) {
            AppUtils.myToast(context, LocalizationManager.getInstance().generalErrorMessage);
            Navigator.pop(context); //close dialog
          } else if (state.typeDetailsStatus == TypeDetailsStatus.typeDetailsExited) {
            Navigator.pop(context);
          }
        },
        buildWhen: (previous, current) => current.typeDetailsStatus != TypeDetailsStatus.navigatingToPokemonDetails && current.typeDetailsStatus != TypeDetailsStatus.readyToNavigateToPokemonDetails,
        builder: (context, typeDetailsState) {
          List<PokemonPreview> displayList = typeDetailsState.searchedPokemonPreviewList.isNotEmpty ? typeDetailsState.searchedPokemonPreviewList : _typeDetailsBloc.selectedTypePokemonPreviewList;

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
                    delegate: SliverSearchAppBar(typeName: widget.typeDetails.name, textEditingController: _searchingController),
                  ),
                  //search results not found
                  if (typeDetailsState.searchedPokemonPreviewList.isEmpty && typeDetailsState.typeDetailsStatus == TypeDetailsStatus.pokemonSearched)
                    const SliverToBoxAdapter(
                      child: Center(child: NoPokemonIndicator()),
                    ),
                  // search results found
                  if (typeDetailsState.searchedPokemonPreviewList.isNotEmpty)
                    SliverList.builder(
                      itemCount: displayList.length,
                      itemBuilder: (context, index) => PokemonListCard(
                        onFavoriteIconTap: () => _typeDetailsBloc.add(UpdateRelationInTypeDetailsEvent(pokemonPreview: displayList[index])),
                        onCardTap: () => _typeDetailsBloc.add(NavigateToDetailsFromTypeDetailsEvent(pokemonPreview: displayList[index])),
                        pokemonPreview: displayList[index],
                      ),
                    ),
                  // default list w/ no search results
                  if (typeDetailsState.searchedPokemonPreviewList.isEmpty && typeDetailsState.typeDetailsStatus != TypeDetailsStatus.pokemonSearched)
                    SliverList.builder(
                      itemCount: _typeDetailsBloc.selectedTypePokemonPreviewList.length,
                      itemBuilder: (context, index) => PokemonListCard(
                        onFavoriteIconTap: () => _typeDetailsBloc.add(UpdateRelationInTypeDetailsEvent(pokemonPreview: displayList[index])),
                        onCardTap: () => _typeDetailsBloc.add(NavigateToDetailsFromTypeDetailsEvent(pokemonPreview: _typeDetailsBloc.selectedTypePokemonPreviewList[index])),
                        pokemonPreview: _typeDetailsBloc.selectedTypePokemonPreviewList[index],
                      ),
                    ),
                  // load more Pokemon
                  if (typeDetailsState.typeDetailsStatus == TypeDetailsStatus.loadingMorePokemons)
                    const SliverToBoxAdapter(child: SizedBox(width: double.infinity, height: 50, child: Center(child: CustomProgressIndicator()))),
                ],
              ),
            ),
          );
        });
  }
}

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  SliverSearchAppBar({
    required this.typeName,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;
  final String typeName;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final TypeDetailsBloc typeDetailsBloc = context.read<TypeDetailsBloc>();
    double adjustedShrinkOffset = shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.3; //was 0.4
    double topPadding = MediaQuery.paddingOf(context).top + 10;
    return BlocBuilder<TypeDetailsBloc, TypeDetailsState>(
      builder: (context, state) {
        return SizedBox(
          height: TYPE_DETAILS_APP_BAR_DELEGATE_MAX_EXTEND,
          child: Stack(
            children: [
              //cool gradient background
              AppbarGradientBackground(
                color: AppUtils.getTypeColor(typeName),
              ),

              //type icon + name
              Positioned(
                top: topPadding,
                child: SizedBox(
                  width: logicalWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomAppbarBackButton(onPressed: () => typeDetailsBloc.add(const ExitTypeDetailsEvent())),
                      SelectedTypeContainer(typeName: typeName),
                    ],
                  ),
                ),
              ),
              //search bar
              Positioned(
                  top: (topPadding + logicalHeight * 0.055) + offset * 0.3,
                  left: 16,
                  right: 16,
                  child: SizedBox(
                    height: 50,
                    width: logicalWidth - 32,
                    child: InkWell(
                      splashColor: AppPalette.transparent,
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
      controller: textEditingController,
      decoration: const InputDecoration().copyWith(
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
        icon: const Icon(Icons.search),
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
        child: const Icon(
          Icons.clear_rounded,
        ));
  }

  @override
  double get maxExtent => TYPE_DETAILS_APP_BAR_DELEGATE_MAX_EXTEND;

  @override
  double get minExtent => TYPE_DETAILS_APP_BAR_DELEGATE_MIN_EXTEND;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
