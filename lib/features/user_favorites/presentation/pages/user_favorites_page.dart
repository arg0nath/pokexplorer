import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/widgets/action_dialog.dart';
import 'package:pokexplorer/core/common/widgets/debug_button.dart';
import 'package:pokexplorer/core/common/widgets/preview_list_tile.dart';
import 'package:pokexplorer/core/routes/route_names.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/user_favorites/presentation/bloc/user_favorites_bloc.dart';
import 'package:pokexplorer/features/user_favorites/presentation/widgets/fav_appbar_actions_button.dart';

class UserFavoritesPage extends StatefulWidget {
  const UserFavoritesPage({super.key});

  @override
  State<UserFavoritesPage> createState() => _UserFavoritesPageState();
}

class _UserFavoritesPageState extends State<UserFavoritesPage> {
  final Set<String> _selectedFavorites = <String>{};
  bool get _isMultiSelectMode => _selectedFavorites.isNotEmpty;

  @override
  void initState() {
    super.initState();
    context.read<UserFavoritesBloc>().add(LoadUserFavoritesEvent());
  }

  void _toggleSelection(String name) {
    setState(() {
      if (_selectedFavorites.contains(name)) {
        _selectedFavorites.remove(name);
      } else {
        _selectedFavorites.add(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('My Favorites'),
        actions: const <Widget>[
          DebugButton(),
          FavoritesAppbarActionsButton(),
        ],
      ),
      bottomSheet: _isMultiSelectMode
          ? BottomAppBar(
              color: context.colorScheme.secondaryContainer,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Selected: ${_selectedFavorites.length}',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      )),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      return showDialog(
                        context: context,
                        builder: (BuildContext context) => PokeActionDialog(
                          title: 'Remove Favorites',
                          description: 'Are you sure you want to remove the selected Pokémon from your favorites?',
                          actionButtonTitle: 'Remove',
                          onActionTap: () {
                            context.read<UserFavoritesBloc>().add(RemovePokemonFromFavoritesEvent(_selectedFavorites.toList()));
                            setState(() {
                              _selectedFavorites.clear();
                            });
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : null,
      body: BlocBuilder<UserFavoritesBloc, UserFavoritesState>(
        builder: (BuildContext context, UserFavoritesState state) {
          if (state is LoadingUserFavorites) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserFavoritesError) {
            return Center(child: Text(state.errorMessage));
          }

          final List<PokemonPreview> favorites = switch (state) {
            UserFavoritesLoaded() => state.favorites,
            UpdatingFavoriteStatus() => state.favorites,
            _ => <PokemonPreview>[],
          };

          if (favorites.isEmpty) {
            return const Center(child: Text('No favorites added yet.'));
          }

          return GestureDetector(
            onTap: () {
              if (_isMultiSelectMode) {
                setState(() {
                  _selectedFavorites.clear();
                });
              }
            },
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                final PokemonPreview favorite = favorites[index];
                final bool isSelected = _selectedFavorites.contains(favorite.name);

                return PreviewListTile.selectable(
                  isSelected: isSelected,
                  preview: favorite,
                  onLongPress: () => _toggleSelection(favorite.name),
                  onCardTap: () {
                    if (_isMultiSelectMode) {
                      _toggleSelection(favorite.name);
                    } else {
                      context.pushNamed(
                        RouteName.pokemonDetailsPageName,
                        pathParameters: <String, String>{'pokemonName': favorite.name},
                      );
                    }
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
