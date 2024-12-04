import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pokexplorer/localization/app_localizations.dart';
import 'package:pokexplorer/router/app_router.dart' as app_router;
import 'package:pokexplorer/screens/favorites/favorites.dart';

import 'package:pokexplorer/screens/type_selection/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/screens/type_selection/view/type_selection_screen.dart';
import 'package:pokexplorer/services/db_service.dart';
import 'package:pokexplorer/src/models/app_models.dart' as app_models;
import 'package:pokexplorer/src/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/src/variables/app_constants.dart' as app_const;
import 'package:pokexplorer/src/widgets/app_widgets.dart' as app_widgets;
import '../../../src/variables/app_variables.dart' as app_vars;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> screenList = [TypeSelectionScreen(), FavoritesScreen()];
  late LocalizationManager appLocale = LocalizationManager.getInstance();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: app_vars.selectedBottomBarIndex,
        children: screenList,
      ),
      bottomNavigationBar: _typeSelectionBottomBar(context),
    );
  }

  Widget _typeSelectionBottomBar(BuildContext context) {
    return BottomNavigationBar(
        onTap: (index) {
          app_vars.selectedBottomBarIndex = index;
          setState(() {});
        },
        currentIndex: app_vars.selectedBottomBarIndex,
        items: [
          BottomNavigationBarItem(label: appLocale.bottomBarHomeScreenTitle, icon: Icon(Icons.catching_pokemon_rounded)),
          BottomNavigationBarItem(label: appLocale.bottomBarFavoritesScreenTitle, icon: Icon(Icons.favorite_outline_outlined)),
        ]);
  }
}
