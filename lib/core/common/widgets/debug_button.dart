import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/routes/route_names.dart';

class DebugButton extends StatelessWidget {
  const DebugButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return IconButton(
          onPressed: () {
            context.pushNamed(RouteName.debugPageName);
          },
          icon: Icon(Icons.bug_report_rounded));
    } else {
      return SizedBox.shrink();
    }
  }
}
