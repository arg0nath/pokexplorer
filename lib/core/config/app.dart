import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/routes/go_router.dart';
import 'package:pokexplorer/core/theme/app_theme.dart';
import 'package:pokexplorer/core/theme/domain/entity/theme_entity.dart';
import 'package:pokexplorer/core/theme/presentation/bloc/theme_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        return MaterialApp.router(
          routerConfig: router,
          title: 'Material App',
          theme: AppTheme.getTheme(state.themeEntity?.themeType == ThemeType.dark),
        );
      },
    );
  }
}
