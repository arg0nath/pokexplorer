import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/widgets/action_dialog.dart';
import 'package:pokexplorer/features/user_favorites/presentation/bloc/user_favorites_bloc.dart';

class FavoritesAppbarActionsButton extends StatelessWidget {
  const FavoritesAppbarActionsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      // Button icon in the app bar
      icon: const Icon(Icons.more_vert),

      onSelected: (int value) async {
        if (value == 0) {
          return showDialog(
            context: context,
            builder: (BuildContext context) => PokeActionDialog(
              title: 'Delete All Favorites',
              description: 'You are about to remove every Pokémon from your favorites.',
              actionButtonTitle: 'Delete All',
              onActionTap: () async {
                context.read<UserFavoritesBloc>().add(RemovePokemonFromFavoritesEvent(<String>[])); //empty list to delete all
                Navigator.pop(context);
              },
            ),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: <Widget>[
              Icon(
                Icons.delete_forever_rounded,
                color: context.colorScheme.error,
              ),
              const SizedBox(width: 8),
              const Text('Delete All'),
            ],
          ),
        ),
      ],
    );
  }
}
