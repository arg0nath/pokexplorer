// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/config/theme/app_theme.dart';
import 'package:pokexplorer/config/theme/domain/entity/theme_entity.dart';
import 'package:pokexplorer/config/theme/presentation/bloc/theme_bloc.dart';
import 'package:pokexplorer/core/routes/go_router.dart';
import 'package:pokexplorer/core/services/injection_container.dart';
import 'package:pokexplorer/features/type_selection/presentation/bloc/type_selection_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (BuildContext context) => sl<ThemeBloc>()),
        BlocProvider<TypeSelectionBloc>(create: (BuildContext context) => sl<TypeSelectionBloc>()),
        //TODO add user favorites
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
          return MaterialApp.router(
            routerConfig: router,
            title: 'Material App',
            theme: AppTheme.getTheme(state.themeEntity?.themeType == ThemeType.dark),
          );
        },
      ),
    );
  }
}
