import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/features/settings/presentation/widgets/legal_bottom_sheet.dart';

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
          ListTile(
            title: Text('Content & Copyright Notice'),
            onTap: () => showModalBottomSheet<void>(
              context: context,
              backgroundColor: context.colorScheme.surface,
              isScrollControlled: true,
              useSafeArea: true,
              isDismissible: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              builder: (BuildContext context) {
                return const LegalBottomSheet();
              },
            ),
          )
        ],
      )),
    );
  }
}
