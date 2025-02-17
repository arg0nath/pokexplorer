import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/constants/app_constants.dart';
import 'package:pokexplorer/core/common/models/app_models.dart';
import 'package:pokexplorer/core/common/utilities/app_utils.dart';
import 'package:pokexplorer/core/common/widgets/custom_alter_dialog.dart';
import 'package:pokexplorer/core/common/widgets/no_pokemon_indicator.dart';
import 'package:pokexplorer/core/common/widgets/pokemon_list_card.dart';
import 'package:pokexplorer/core/localization/app_localizations.dart';
import 'package:pokexplorer/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:pokexplorer/router/app_router.dart';

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
        case USER_FAVORITES_POP_MENU_CLEAR_ALL_VALUE:
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CIRCULAR_RADIUS)),
                icon: const Icon(Icons.more_vert),
                onSelected: handleClick,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                      PopupMenuItem<int>(
                        value: USER_FAVORITES_POP_MENU_CLEAR_ALL_VALUE,
                        child: ListTile(
                          leading: Icon(Icons.delete_forever),
                          title: Text(appLocale.deleteAll),
                        ),
                      ),
                    ]);
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
      body: _favoritesBody(),
    );
  }

  Widget _favoritesBody() {
    return BlocConsumer<UserFavoritesBloc, UserFavoritesState>(listener: (context, state) async {
      if (state.userFavoritesStatus == UserFavoritesStatus.refreshingFavorites) {
        await context.showLoadingDialog();
      } else if (state.userFavoritesStatus == UserFavoritesStatus.userFavoritesRefreshed) {
        Navigator.pop(context);
      } else if (state.userFavoritesStatus == UserFavoritesStatus.loadingUserFavorites) {
        await context.showLoadingDialog();
      } else if (state.userFavoritesStatus == UserFavoritesStatus.userFavoritesLoaded) {
        Navigator.pop(context);
      } else if (state.userFavoritesStatus == UserFavoritesStatus.navigatingToPokemonDetails) {
        await context.showLoadingDialog();
      } else if (state.userFavoritesStatus == UserFavoritesStatus.readyToNavigateToPokemonDetails) {
        Navigator.popAndPushNamed(context, RouteNames.pokeDetailsScreen,
            arguments: PokemonDetailsScreenArguments(selectedTypeName: _favoritesBloc.selectedPokemon.types.first.name, pokemon: _favoritesBloc.selectedPokemon));
      } else if (state.userFavoritesStatus == UserFavoritesStatus.noInternetFailedFavorites) {
        AppUtils.myToast(context, LocalizationManager.getInstance().connectionFailure);
      } else if (state.userFavoritesStatus == UserFavoritesStatus.navigateToDetailsFromFavoritesFailed) {
        AppUtils.myToast(context, LocalizationManager.getInstance().generalErrorMessage);
        Navigator.pop(context);
      }
      //removing pokemon dialog
      else if (state.userFavoritesStatus == UserFavoritesStatus.showDialogToRemovePokemon) {
        await showDialog(
            context: context,
            builder: (_) => CustomAlertDialog(
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
            builder: (_) => CustomAlertDialog(
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
      final List<PokemonPreview> displayList = _favoritesBloc.userFavorites;

      return RefreshIndicator(
        onRefresh: () async {
          _favoritesBloc.add(const RefreshFavoritesEvent());
        },
        child: Scrollbar(
          thumbVisibility: false,
          child: (displayList.isEmpty)
              ? const Center(child: NoPokemonIndicator())
              : CustomScrollView(
                  slivers: [
                    SliverList.builder(
                      itemCount: displayList.length,
                      itemBuilder: (context, index) => PokemonListCard(
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
