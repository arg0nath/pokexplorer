// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/config/logger/my_log.dart';
import 'package:pokexplorer/config/theme/app_theme.dart';
import 'package:pokexplorer/config/theme/domain/entity/theme_entity.dart';
import 'package:pokexplorer/config/theme/presentation/bloc/theme_bloc.dart';
import 'package:pokexplorer/core/routes/go_router.dart';
import 'package:pokexplorer/core/services/di_imports.dart';
import 'package:pokexplorer/features/type_selection/presentation/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/features/user_favorites/presentation/bloc/user_favorites_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeBloc? _themeBloc;
  bool _isThemeLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeTheme(); // Eagerly initialize the theme before UI builds
  }

  Future<void> _initializeTheme() async {
    _themeBloc = sl<ThemeBloc>(); // Manually get ThemeBloc from DI (get_it)

    // Dispatch the event to load the stored theme from cache (or default)
    _themeBloc!.add(const GetThemeEvent());

    // Wait until the theme is loaded (success or failure) before proceeding
    // This prevents the app from rendering with the wrong theme initially
    await _themeBloc!.stream.firstWhere(
      (state) => state.status == ThemeStatus.success || state.status == ThemeStatus.failure,
    );

    // Trigger UI rebuild once theme is ready
    if (mounted) {
      setState(() {
        _isThemeLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    // Manually close the ThemeBloc since we created it ourselves
    _themeBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // While the theme is still loading, show a loading screen
    // This ensures the app doesn't flash the wrong theme
    if (!_isThemeLoaded || _themeBloc == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MultiBlocProvider(
      providers: [
        // Since we manually created ThemeBloc and triggered GetThemeEvent,
        // we must use `.value` to inject the existing instance (not create a new one)
        BlocProvider<ThemeBloc>.value(value: _themeBloc!),

        // These blocs can be created lazily as usual
        BlocProvider<TypeSelectionBloc>(
          create: (BuildContext context) => sl<TypeSelectionBloc>(),
        ),
        BlocProvider<UserFavoritesBloc>(
          lazy: false,
          create: (BuildContext context) => sl<UserFavoritesBloc>()..add(LoadUserFavoritesEvent()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
          myLog('Current theme: ${state.themeEntity?.themeType}');
          myLog('Theme status: ${state.status}');

          // Determine the current theme based on the bloc's state
          final isDark = state.themeEntity?.themeType == ThemeType.dark;

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            // Apply the correct theme mode based on ThemeBloc state
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
