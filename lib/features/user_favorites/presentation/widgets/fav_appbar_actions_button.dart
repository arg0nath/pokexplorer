import 'package:flutter/material.dart';

class FavAppbarActionsButton extends StatelessWidget {
  const FavAppbarActionsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      // Button icon in the app bar
      icon: const Icon(Icons.more_vert),
      // Rounded menu shape
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onSelected: (value) {
        if (value == 0) {}
      },
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              Icon(
                Icons.delete_forever_rounded,
                color: Theme.of(context).colorScheme.error,
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
