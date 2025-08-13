// ignore_for_file: always_specify_types

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/utils/bloc_observer.dart';
import 'package:pokexplorer/core/services/di_imports.dart';
import 'package:pokexplorer/features/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Bloc.observer = AppBlocObserver();
  await injectionInit();
  runApp(const MyApp());
}
