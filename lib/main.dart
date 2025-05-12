import 'package:flutter/widgets.dart';
import 'package:pokexplorer/app.dart';
import 'package:pokexplorer/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(
    const MyApp(),
  );
}
