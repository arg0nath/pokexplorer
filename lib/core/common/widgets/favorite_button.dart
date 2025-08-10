import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/features/user_favorites/presentation/bloc/user_favorites_bloc.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.name,
    required this.id,
  });

  final String name;
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
        return IconButton(
            onPressed: isFavorite
                ? () => context.read<UserFavoritesBloc>().add(RemoveFromFavoritesEvent(name))
                : () => context.read<UserFavoritesBloc>().add(
                      AddToFavoritesEvent(id: id, name: name),
                    ),
            icon: isFavorite
                ? Icon(
                    Icons.favorite,
                    color: context.theme.colorScheme.primary,
                  )
                : const Icon(Icons.favorite_border));
      },
    );
  }
}
