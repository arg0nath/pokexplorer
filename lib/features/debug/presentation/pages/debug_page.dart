import 'package:flutter/material.dart';

import '../widgets/theme_colors_reference_page.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Debug'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Theme Colors'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ThemeColorsReferencePage(),
          ],
        ),
      ),
    );
  }
}
