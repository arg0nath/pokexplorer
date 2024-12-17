import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokexplorer/localization/app_localizations.dart';
import 'package:pokexplorer/services/db_service.dart';
import 'package:pokexplorer/core/variables/app_variables.dart' as app_vars;
import 'app.dart';
import 'core/utilities/app_utils.dart' as app_utils;
import 'core/classes/app_classes.dart' as app_classes;

Future<bool> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  LocalizationManager.getInstance().setLocale(const Locale('en', 'US'));
  app_vars.databaseService = DatabaseService.instance;
  await app_classes.PreferenceUtils.init();

  app_utils.myLog(msg: 'App Initialized..');

  Bloc.observer = SimpleBlocObserver();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]).then((_) {
    runApp(PokexplorerApp());
  });
  return Future<bool>.value(true);
}
