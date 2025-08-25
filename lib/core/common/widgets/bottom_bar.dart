import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
        BottomNavigationBarItem(activeIcon: Icon(Icons.catching_pokemon_rounded), icon: Icon(Icons.catching_pokemon_rounded), label: 'Explore'),
        BottomNavigationBarItem(activeIcon: Icon(FluentIcons.heart_24_filled), icon: Icon(FluentIcons.heart_20_regular), label: 'Favorites'),
        BottomNavigationBarItem(activeIcon: Icon(FluentIcons.layout_row_two_settings_32_filled), icon: Icon(FluentIcons.layout_row_two_settings_20_regular), label: 'Settings'),
      ],
    );
  }
}
