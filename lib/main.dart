import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokexplorer/core/variables/app_variables.dart';
import 'package:pokexplorer/localization/app_localizations.dart';
import 'package:pokexplorer/services/db_service.dart';

import 'app.dart';
import 'core/classes/app_classes.dart';
import 'core/utilities/app_utils.dart';

Future<bool> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  LocalizationManager.getInstance().setLocale(const Locale('en', 'US'));
  databaseService = DatabaseService.instance;
  await PreferenceUtils.init();

  AppUtils.myLog(msg: 'App Initialized..');

  Bloc.observer = SimpleBlocObserver();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]).then((_) {
    runApp(PokexplorerApp());
  });
  return Future<bool>.value(true);
}
