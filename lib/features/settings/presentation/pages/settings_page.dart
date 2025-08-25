import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          ListTile(title: Text('Dark Mode')),
          ListTile(title: Text('Legal Information & Copyright Notices')),
        ],
      )),
    );
  }
}
