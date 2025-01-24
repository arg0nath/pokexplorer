import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/localization/app_localizations.dart';
import 'package:pokexplorer/router/app_router.dart' as app_router;
import 'package:pokexplorer/screens/favorites/bloc/favorites_bloc.dart';
import 'package:pokexplorer/core/models/app_models.dart' as app_models;
import 'package:pokexplorer/core/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/core/variables/app_constants.dart' as app_const;
import 'package:pokexplorer/core/widgets/app_widgets.dart' as app_widgets;

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

  List<Widget> _showActions(BuildContext context) {
    void handleClick(dynamic value) {
      switch (value as int) {
        case app_const.USER_FAVORITES_POP_MENU_CLEAR_ALL_VALUE:
          _favoritesBloc.add(const ShowDialogToDeleteAllEvent());
          return;
      }
    }

    final List<Widget> actions = <Widget>[];

    actions.add(
      BlocBuilder<UserFavoritesBloc, UserFavoritesState>(
        builder: (BuildContext context, UserFavoritesState state) {
          if (_favoritesBloc.userFavorites.isEmpty) {
            return const SizedBox.shrink();
          } else {
            return PopupMenuButton<dynamic>(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              icon: const Icon(Icons.more_vert),
              onSelected: handleClick,
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                app_widgets.buildPopupMenuItem(context: context, iconData: Icons.delete_forever, menuItemTitle: appLocale.deleteAll, value: app_const.USER_FAVORITES_POP_MENU_CLEAR_ALL_VALUE),
              ],
            );
          }
        },
      ),
    );
    return actions;
  }

  AppBar _userFavoritesAppbar(BuildContext context) {
    return AppBar(
      title: Text(appLocale.favoritesScreenTitle),
      backgroundColor: Colors.transparent,
      actions: _showActions(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _userFavoritesAppbar(context),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _favoritesBody(),
    );
  }

  Widget _favoritesBody() {
    return BlocConsumer<UserFavoritesBloc, UserFavoritesState>(listener: (context, state) async {
      if (state.userFavoritesStatus == UserFavoritesStatus.refreshingFavorites) {
        await app_utils.showLoadingDialog(context);
      } else if (state.userFavoritesStatus == UserFavoritesStatus.userFavoritesRefreshed) {
        Navigator.pop(context);
      } else if (state.userFavoritesStatus == UserFavoritesStatus.loadingUserFavorites) {
        await app_utils.showLoadingDialog(context);
      } else if (state.userFavoritesStatus == UserFavoritesStatus.userFavoritesLoaded) {
        Navigator.pop(context);
      } else if (state.userFavoritesStatus == UserFavoritesStatus.navigatingToPokemonDetails) {
        await app_utils.showLoadingDialog(context);
      } else if (state.userFavoritesStatus == UserFavoritesStatus.readyToNavigateToPokemonDetails) {
        Navigator.popAndPushNamed(context, app_const.POKEMON_DETAILS_SCREEN_ROUTE_NAME,
            arguments: app_router.PokemonDetailsScreenArguments(selectedTypeName: _favoritesBloc.selectedPokemon.types.first.name, pokemon: _favoritesBloc.selectedPokemon));
      } else if (state.userFavoritesStatus == UserFavoritesStatus.noInternetFailedFavorites) {
        app_utils.myToast(context, LocalizationManager.getInstance().connectionFailure);
      } else if (state.userFavoritesStatus == UserFavoritesStatus.navigateToDetailsFromFavoritesFailed) {
        app_utils.myToast(context, LocalizationManager.getInstance().generalErrorMessage);
        Navigator.pop(context);
      }
      //removing pokemon dialog
      else if (state.userFavoritesStatus == UserFavoritesStatus.showDialogToRemovePokemon) {
        await showDialog(
            context: context,
            builder: (_) => app_widgets.CustomAlertDialog(
                  title: appLocale.deleteFavoritesDialogTitle,
                  description: appLocale.deleteFavoritesDialogDescription.replaceFirstMapped('{pokeName}', (_) => _favoritesBloc.selectedPokemonPreviewForDeletion.name.toUpperFirst()),
                  actionButtonTitle: appLocale.deleteFavoritesDialogActionButton,
                  onActionTap: () {
                    _favoritesBloc.add(RemovePokemonPreviewFromFavoritesEvent(pokemonPreview: _favoritesBloc.selectedPokemonPreviewForDeletion));
                    Navigator.pop(context);
                  },
                ));
      }

      //delete all dialog
      else if (state.userFavoritesStatus == UserFavoritesStatus.showDialogToDeleteAll) {
        await showDialog(
            context: context,
            builder: (_) => app_widgets.CustomAlertDialog(
                  title: appLocale.deleteAllFavoritesDialogTitle,
                  description: appLocale.deleteAllFavoritesDialogDescription,
                  actionButtonTitle: appLocale.deleteAllFavoritesDialogActionButton,
                  onActionTap: () {
                    _favoritesBloc.add(const DeleteAllFavoritesEvent());
                  },
                ));
      } else if (state.userFavoritesStatus == UserFavoritesStatus.allPokemonDeleted) {
        Navigator.pop(context);
      }
    }, builder: (context, typeDetailsState) {
      final List<app_models.PokemonPreview> displayList = _favoritesBloc.userFavorites;

      return RefreshIndicator(
        onRefresh: () async {
          _favoritesBloc.add(const RefreshFavoritesEvent());
        },
        child: Scrollbar(
          thumbVisibility: false,
          child: (displayList.isEmpty)
              ? const Center(child: app_widgets.NoPokemonIndicator())
              : CustomScrollView(
                  slivers: [
                    SliverList.builder(
                      itemCount: displayList.length,
                      itemBuilder: (context, index) => app_widgets.PokemonListCard(
                        onLongPress: () => _favoritesBloc.add(ShowDialogToRemoveFavoriteEvent(pokemonPreview: displayList[index])),
                        onFavoriteIconTap: null,
                        onCardTap: () => _favoritesBloc.add(NavigateToDetailsFromFavoritesEvent(pokemonPreview: displayList[index])),
                        pokemonPreview: displayList[index],
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
