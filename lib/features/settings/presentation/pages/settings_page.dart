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
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.palette_outlined),
              title: Text('Appereance'),
              trailing: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (BuildContext context, ThemeState state) {
                  final bool isDarkMode = state.themeEntity?.themeType == ThemeType.dark;
                  return Switch.adaptive(
                    thumbIcon: WidgetStatePropertyAll(Icon(isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded)),
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
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => showLegalBottomSheet(context, isFirstTime: false),
            ),
            AboutTile(),
          ],
        ),
      ),
    );
  }
}
