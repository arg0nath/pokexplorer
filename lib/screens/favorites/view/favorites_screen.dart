import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/localization/app_localizations.dart';
import 'package:pokexplorer/router/app_router.dart' as app_router;
import 'package:pokexplorer/screens/favorites/bloc/favorites_bloc.dart';
import 'package:pokexplorer/screens/type_details/bloc/type_details_bloc.dart';
import 'package:pokexplorer/src/models/app_models.dart' as app_models;
import 'package:pokexplorer/src/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/src/variables/app_constants.dart' as app_const;
import 'package:pokexplorer/src/variables/app_variables.dart' as app_vars;
import 'package:pokexplorer/src/widgets/app_widgets.dart' as app_widgets;

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final UserFavoritesBloc _favoritesBloc = context.read<UserFavoritesBloc>();
  late LocalizationManager appLocale = LocalizationManager.getInstance();

  @override
  void initState() {
    _favoritesBloc.add(const LoadFavoritesEvent());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return Future<bool>.value(false);
  }

  AppBar _userFavoritesAppbar(BuildContext context) {
    return AppBar(
      title: Text(appLocale.favoritesScreenTitle),
      backgroundColor: Colors.transparent,
    );
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
        appBar: _userFavoritesAppbar(context),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: _favoritesBody(),
        floatingActionButton: FloatingActionButton(child: const Icon(Icons.delete_forever_rounded), onPressed: () => _favoritesBloc.add(const DeleteAllFavoritesEvent())),
      ),
    );
  }

  Widget _favoritesBody() {
    return BlocConsumer<UserFavoritesBloc, UserFavoritesState>(listener: (context, state) async {
      if (state.userFavoritesStatus == UserFavoritesStatus.navigatingToPokemonDetails) {
        await app_utils.showLoadingDialog(context);
      } else if (state.userFavoritesStatus == UserFavoritesStatus.readyToNavigateToPokemonDetails) {
        Navigator.popAndPushNamed(context, app_const.POKEMON_DETAILS_SCREEN_ROUTE_NAME,
            arguments: app_router.PokemonDetailsScreenArguments(selectedTypeName: _favoritesBloc.selectedPokemon.types.first.name, pokemon: _favoritesBloc.selectedPokemon));
      } else if (state.userFavoritesStatus == UserFavoritesStatus.showDialogToRemovePokemon) {
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  actions: [
                    OutlinedButton(
                      onPressed: () {
                        _favoritesBloc.add(RemovePokemonPreviewFromFavoritesEvent(pokemonPreview: _favoritesBloc.selectedPokemonPreviewForDeletion));
                        Navigator.pop(context);
                      },
                      child: Text(appLocale.deleteFavoritesDialogActionButtonTitle),
                    ),
                  ],
                  title: Text(appLocale.deleteFavoritesDialogTitle, textAlign: TextAlign.center),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        appLocale.deleteFavoritesDialogDescription.replaceFirstMapped('{pokeName}', (_) => _favoritesBloc.selectedPokemonPreviewForDeletion.name),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ));
      }
    }, builder: (context, typeDetailsState) {
      final displayList = app_vars.userFavorites;

      if (displayList.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(app_const.EMPTY_POKEBALL_PNG, width: app_vars.logicalHeight * 0.1, height: app_vars.logicalHeight * 0.1), // Replace with your image path
              const SizedBox(height: 10),
              Text(LocalizationManager.getInstance().noPokemonFound, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        );
      }
      return Scrollbar(
        thumbVisibility: false,
        child: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: displayList.length,
              itemBuilder: (context, index) => app_widgets.PokemonListCard(
                onLongPress: () => _favoritesBloc.add(ShowDialogToRemovePokemonPreviewFromFavoritesEvent(pokemonPreview: displayList[index])),
                onFavoriteIconTap: null,
                onCardTap: () => _favoritesBloc.add(NavigateToDetailsFromFavoritesEvent(pokemonPreview: displayList[index])),
                pokemonPreview: displayList[index],
              ),
            ),
          ],
        ),
      );
    });
  }
}
