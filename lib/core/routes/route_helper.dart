import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A custom GoRoute builder that applies a fade transition to the page when navigating.
///
/// This function wraps a standard `GoRoute` with a custom page transition animation (fade) for
/// smooth transitions between routes. It takes the standard route parameters and automatically
/// applies the animation whenever the route is triggered.
///
/// Example usage:
/// ```dart
/// customGoRoute(
///   path: '/example',
///   name: 'exampleRoute',
///   builder: (context, state) => ExamplePage(),
/// );
/// ```
///
/// Parameters:
/// - `path`: The path of the route. This is the URL that will trigger the route.
/// - `name`: The name of the route. It is used to refer to the route when navigating programmatically.
/// - `builder`: A function that takes both `BuildContext` and `GoRouterState`. This is the page/widget
///   that will be displayed when the route is accessed. It can include additional logic that uses
///   the `GoRouterState`, such as extracting path parameters or query parameters.
/// - `routes`: An optional list of nested routes for this route (default is an empty list). These routes
///   will be displayed as part of the parent route when the user navigates to this route.
///
GoRoute customGoRoute({
  required String path,
  required String name,
  required Widget Function(BuildContext, GoRouterState) builder,
  List<GoRoute> routes = const <GoRoute>[],
}) {
  return GoRoute(
    path: path,
    name: name,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: Builder(
          builder: (BuildContext context) {
            return builder(context, state); // Pass GoRouterState to builder
          },
        ),
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          // Apply a fade transition to the page
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      );
    },
    routes: routes,
  );
}
