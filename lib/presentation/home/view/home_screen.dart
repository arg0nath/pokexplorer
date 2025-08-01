import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/constants/app_constants.dart' as app_const;
import 'package:pokexplorer/core/localization/app_localizations.dart';
import 'package:pokexplorer/presentation/favorites/favorites.dart';
import 'package:pokexplorer/presentation/type_selection/view/type_selection_screen.dart';

import '../../../core/common/variables/app_variables.dart' as app_vars;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> screenList = [const TypeSelectionScreen(), const FavoritesScreen()];
  late LocalizationManager appLocale = LocalizationManager.getInstance();

  @override
  void initState() {
    super.initState();
  }

  Map<String, GlobalKey<NavigatorState>> navigatorKeys = <String, GlobalKey<NavigatorState>>{
    app_const.BOTTOM_BAR_PAGE_TYPE_SELECTION_SCREEN: GlobalKey<NavigatorState>(),
    app_const.BOTTOM_BAR_PAGE_USER_FAVORITES_SCREEN: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[app_vars.selectedBottomBarIndex],
      bottomNavigationBar: _typeSelectionBottomBar(context),
    );
  }

  Widget _typeSelectionBottomBar(BuildContext context) {
    return BottomNavigationBar(
        // backgroundColor: Colors.transparent,
        selectedItemColor: Colors.redAccent[200],
        elevation: 0,
        onTap: (index) {
          app_vars.selectedBottomBarIndex = index;
          setState(() {});
        },
        currentIndex: app_vars.selectedBottomBarIndex,
        items: [
          BottomNavigationBarItem(
            key: navigatorKeys[app_const.BOTTOM_BAR_PAGE_TYPE_SELECTION_SCREEN],
            label: appLocale.bottomBarHomeScreenTitle,
            icon: const Icon(Icons.catching_pokemon_rounded),
          ),
          BottomNavigationBarItem(
            key: navigatorKeys[app_const.BOTTOM_BAR_PAGE_USER_FAVORITES_SCREEN],
            label: appLocale.bottomBarFavoritesScreenTitle,
            icon: Icon(app_vars.selectedBottomBarIndex == 1 ? Icons.favorite_rounded : Icons.favorite_outline_outlined),
          ),
        ]);
  }
}
