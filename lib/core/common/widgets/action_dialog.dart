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
        style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
      //description
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(description, textAlign: TextAlign.center),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      //button
      actions: <Widget>[
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
            onPressed: onActionTap,
            child: Text(actionButtonTitle),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(context.theme.colorScheme.primary),
              foregroundColor: WidgetStateProperty.all(context.theme.colorScheme.onPrimary),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              textStyle: WidgetStateProperty.all(
                context.textTheme.titleSmall?.copyWith(color: context.colorScheme.onPrimary, fontWeight: FontWeight.bold),
              ),
            )),
      ],
    );
  }
}
