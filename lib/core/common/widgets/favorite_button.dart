import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/user_favorites/presentation/bloc/user_favorites_bloc.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.relatedPreview});

  final PokemonPreview relatedPreview;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserFavoritesBloc, UserFavoritesState, bool>(
      selector: (UserFavoritesState state) {
        if (state is UserFavoritesLoaded) {
          return state.favoriteNames.contains(relatedPreview.name);
        }
        return false;
      },
      builder: (BuildContext context, bool isFavorite) {
        return IconButton(
            onPressed: isFavorite
                ? () => context.read<UserFavoritesBloc>().add(RemoveFromFavoritesEvent(relatedPreview.name))
                : () => context.read<UserFavoritesBloc>().add(AddToFavoritesEvent(relatedPreview)),
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
