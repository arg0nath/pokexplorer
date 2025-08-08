import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:pokexplorer/features/user_favorites/presentation/bloc/user_favorites_bloc.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.relatedPreview});

  final PokemonPreview relatedPreview;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserFavoritesBloc, UserFavoritesState, bool>(
      key: ValueKey<int>(widget.relatedPreview.id),
      selector: (UserFavoritesState state) {
        if (state is FavoriteStatusUpdated) {
          // Check if this Pokémon is in the favorites list
          return state.favorites.any((PokemonPreview fav) => fav.id == widget.relatedPreview.id);
        }
        return false; // Not loaded or not a favorite
      },
      builder: (BuildContext context, bool state) {
        return IconButton(
            onPressed: state
                ? () => context.read<UserFavoritesBloc>().add(RemoveFromFavoritesEvent(widget.relatedPreview.id))
                : () => context.read<UserFavoritesBloc>().add(AddToFavoritesEvent(widget.relatedPreview)),
            icon: state
                ? Icon(
                    Icons.favorite,
                    color: context.theme.colorScheme.primary,
                  )
                : const Icon(Icons.favorite_border));
      },
    );
  }
}
