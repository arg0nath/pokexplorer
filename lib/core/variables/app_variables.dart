import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pokexplorer/services/db_service.dart';

import '../../../router/app_router.dart';

/// RouteObserver for monitoring the currently visible screen.
final MyRouteObserver routeObserver = MyRouteObserver();
FlutterView tmpWindow = PlatformDispatcher.instance.implicitView!;
double deviceScreenWidth = 1.0;
double devicePixelRatio = tmpWindow.devicePixelRatio;

double pixelRatio = WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

//Size in physical pixels
Size physicalScreenSize = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;

//Size in logical pixels ->
Size logicalScreenSize = physicalScreenSize / pixelRatio;
double logicalWidth = logicalScreenSize.width;
double logicalHeight = logicalScreenSize.height;
bool isDarkMode = false;
int selectedBottomBarIndex = 0;

late DatabaseService databaseService;
