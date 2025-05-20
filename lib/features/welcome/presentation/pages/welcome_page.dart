import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
                '/type-selection',
              ),
              child: const Text('Go to Type Selection'),
            )
          ],
        ),
      ),
    );
  }
}
