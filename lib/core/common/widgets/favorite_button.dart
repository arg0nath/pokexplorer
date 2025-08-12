import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/extensions/string_ext.dart';
import 'package:pokexplorer/core/common/widgets/action_dialog.dart';
import 'package:pokexplorer/core/common/widgets/animated_heart.dart';
import 'package:pokexplorer/features/user_favorites/presentation/bloc/user_favorites_bloc.dart';

/// A button that toggles the favorite status of a Pokémon.
///
/// Tightly coupled with the [UserFavoritesBloc] to handle adding and removing favorites.

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.name,
    required this.id,
    required this.avatarUrl,
  });

  final String name;
  final String avatarUrl;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserFavoritesBloc, UserFavoritesState, bool>(
      selector: (UserFavoritesState state) {
        if (state is UserFavoritesLoaded) {
          return state.favoriteNames.contains(name);
        }
        return false;
      },
      builder: (BuildContext context, bool isFavorite) {
        return GestureDetector(
          child: AnimatedPokeballCapture(
            isFavorite,
            pokemonAvatar: avatarUrl,
          ),
          onTap: isFavorite
              ? () => showDialog(
                    context: context,
                    builder: (BuildContext context) => PokeActionDialog(
                      title: 'Remove Favorite',
                      description: 'You are about to remove ${name.toUpperFirst()} from your favorites.',
                      actionButtonTitle: 'Remove',
                      onActionTap: () async {
                        context.read<UserFavoritesBloc>().add(RemoveFromFavoritesEvent(name));
                        Navigator.pop(context);
                      },
                    ),
                  )
              : () => context.read<UserFavoritesBloc>().add(AddToFavoritesEvent(id: id, name: name)),
        );
      },
    );
  }
}
