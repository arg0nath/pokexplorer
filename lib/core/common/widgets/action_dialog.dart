import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';

class PokeActionDialog extends StatelessWidget {
  const PokeActionDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onActionTap,
    required this.actionButtonTitle,
  });

  final String title;
  final String description;
  final VoidCallback onActionTap;
  final String actionButtonTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: context.theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
      //description
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(description, textAlign: TextAlign.center),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      //button
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: onActionTap,
          child: Text(actionButtonTitle),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(context.theme.colorScheme.primary),
            foregroundColor: WidgetStatePropertyAll(context.theme.colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }
}
