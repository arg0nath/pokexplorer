import 'package:flutter/material.dart';
import 'package:pokexplorer/routes/route_names.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, RouteNames.typeSelectionPage);
            // Navigate to TypeSelectionScreen
            break;
          case 1:
            Navigator.pushNamed(context, RouteNames.typeSelectionPage);
            break;
        }
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Type Selection',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'User Favorites',
        ),
      ],
    );
  }
}
