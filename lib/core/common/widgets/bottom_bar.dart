import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainAppBottomBar extends StatefulWidget {
  const MainAppBottomBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<MainAppBottomBar> createState() => _MainAppBottomBarState();
}

class _MainAppBottomBarState extends State<MainAppBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        if (index == widget.navigationShell.currentIndex) {
          widget.navigationShell.goBranch(index, initialLocation: true);
        } else {
          widget.navigationShell.goBranch(index);
        }
      },
      currentIndex: widget.navigationShell.currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.catching_pokemon_rounded), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
      ],
    );
  }
}
