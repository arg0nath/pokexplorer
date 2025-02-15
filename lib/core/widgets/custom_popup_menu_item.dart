import 'package:flutter/material.dart';

class BuildPopupMenuItem extends PopupMenuItem<dynamic> {
  const BuildPopupMenuItem({super.key, required this.iconData, required this.value, required this.menuItemTitle, required super.child});

  final IconData iconData;
  @override
  final int value;
  final String menuItemTitle;

  Widget build(BuildContext context) {
    return PopupMenuItem<dynamic>(
      value: value,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Icon(iconData),
          ),

          Flexible(
            child: Text(
              menuItemTitle,
              textAlign: TextAlign.center,
            ),
          ),
          // SizedBox(width: 5),
        ],
      ),
    );
  }
}
