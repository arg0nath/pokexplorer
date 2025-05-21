import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/routes/route_names.dart';

class MainAppScreen extends StatefulWidget {
  final Widget child;
  const MainAppScreen({super.key, required this.child});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  static const List<String> _routes = [
    RoutePath.typeSelectionPage,
    RoutePath.userFavoritesPage,
  ];

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Types',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
