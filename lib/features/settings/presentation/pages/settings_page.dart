import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/config/theme/domain/entity/theme_entity.dart';
import 'package:pokexplorer/config/theme/presentation/bloc/theme_bloc.dart';
import 'package:pokexplorer/features/settings/presentation/widgets/about_list_tile.dart';
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
          ListTile(
            leading: const Icon(Icons.dark_mode_rounded),
            title: Text('Dark Theme'),
            trailing: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (BuildContext context, ThemeState state) {
                final bool isDarkMode = state.themeEntity?.themeType == ThemeType.dark;
                return Switch(
                  value: isDarkMode, // true = dark mode, false = light mode
                  onChanged: (bool value) {
                    context.read<ThemeBloc>().add(ToggleThemeEvent(value));
                  },
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.balance_rounded),
            title: Text('Content & Copyright Notice'),
            onTap: () => showLegalBottomSheet(context),
          ),
          AboutTile(),
        ],
      )),
    );
  }
}
