import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
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
      title: Text(title, textAlign: TextAlign.center),
      //description
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(description, textAlign: TextAlign.center),
        ],
      ),
      //button
      actions: [
        OutlinedButton(onPressed: onActionTap, child: Text(actionButtonTitle)),
      ],
    );
  }
}
