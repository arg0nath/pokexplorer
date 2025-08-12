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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => sl<ThemeBloc>()..add(const GetThemeEvent()),
        ),
        BlocProvider<TypeSelectionBloc>(create: (BuildContext context) => sl<TypeSelectionBloc>()),
        BlocProvider<UserFavoritesBloc>(lazy: false, create: (BuildContext context) => sl<UserFavoritesBloc>()..add(LoadUserFavoritesEvent())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
          // Default to light theme if state is initial or themeEntity is null
          final isDark = state.themeEntity?.themeType == ThemeType.dark;
          myLog('Current theme: ${state.themeEntity?.themeType}');
          myLog('Theme status: ${state.status}');
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
