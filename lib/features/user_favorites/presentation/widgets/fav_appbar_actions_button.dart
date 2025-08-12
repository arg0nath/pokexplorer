import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';

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
      onSelected: (int value) {
        if (value == 0) {}
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
