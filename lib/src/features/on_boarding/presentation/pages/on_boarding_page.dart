import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/services/routes/route_names.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Pokexplorer App!',
            ),
            FilledButton(
              onPressed: () => context.go(
                RoutePath.typeSelectionPage,
              ),
              child: const Text('Go to Type Selection'),
            )
          ],
        ),
      ),
    );
  }
}
