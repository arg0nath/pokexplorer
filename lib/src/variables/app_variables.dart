import 'package:flutter/material.dart';

import '../../../router/app_router.dart';

/// RouteObserver for monitoring the currently visible screen.
final MyRouteObserver routeObserver = MyRouteObserver();

double pixelRatio = WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

//Size in physical pixels
Size physicalScreenSize = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;

//Size in logical pixels ->
Size logicalScreenSize = physicalScreenSize / pixelRatio;
double logicalWidth = logicalScreenSize.width;
double logicalHeight = logicalScreenSize.height;
