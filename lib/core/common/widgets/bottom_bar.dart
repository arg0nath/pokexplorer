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
      currentIndex: widget.navigationShell.currentIndex,
      onTap: (int index) {
        if (index == widget.navigationShell.currentIndex) {
          // if current tab again — pop to root
          widget.navigationShell.goBranch(
            index,
            initialLocation: true,
          );
        } else {
          // switch to another tab
          widget.navigationShell.goBranch(index);
        }
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
      ],
    );
  }
}
