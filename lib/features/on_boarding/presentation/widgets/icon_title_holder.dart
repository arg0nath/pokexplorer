import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';

class IconTitleHolder extends StatelessWidget {
  const IconTitleHolder({
    super.key,
    required this.message,
    required this.iconData,
  });

  final String message;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: context.height * 0.05),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(padding: EdgeInsets.only(left: context.width * 0.1, right: context.width * 0.05), child: Icon(iconData)),
          Flexible(child: Text(message, style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)))
        ]));
  }
}
