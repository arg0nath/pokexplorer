// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/config/theme/app_theme.dart';
import 'package:pokexplorer/config/theme/presentation/bloc/theme_cubit.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/routes/go_router.dart';
import 'package:pokexplorer/core/services/di_imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>())],
      child: BlocBuilder<ThemeCubit, String>(
        builder: (BuildContext context, String state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: state == AppConst.darkThemeKey ? ThemeMode.dark : ThemeMode.light,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
