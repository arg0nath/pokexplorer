import 'package:flutter/material.dart';
import 'package:pokexplorer/core/routes/route_names.dart';

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({
    super.key,
  });

  // final int selectedIndex; required this.selectedIndex

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, RoutePath.typeSelectionPage);
            // Navigate to TypeSelectionScreen
            break;
          case 1:
            Navigator.pushNamed(context, RoutePath.typeSelectionPage);
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
