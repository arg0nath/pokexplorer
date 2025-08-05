import 'package:flutter/material.dart';

class UserFavoritesPage extends StatelessWidget {
  const UserFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('User Favorites')),
        body: Container(
          constraints: const BoxConstraints.expand(),
        ));
  }
}
