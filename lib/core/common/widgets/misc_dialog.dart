import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pokexplorer/config/theme/domain/entity/theme_entity.dart';
import 'package:pokexplorer/config/theme/presentation/bloc/theme_bloc.dart';
import 'package:pokexplorer/core/common/constants/app_const.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';
import 'package:pokexplorer/core/common/utils/general/open_github.dart';

class MiscDialog extends StatefulWidget {
  const MiscDialog({super.key});

  @override
  State<MiscDialog> createState() => _MiscDialogState();
}

class _MiscDialogState extends State<MiscDialog> {
  @override
  Dialog build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppConst.mainRadius),
      elevation: 0.0,
      child: Container(
        width: context.width * 0.7,
        padding: const EdgeInsets.all(25),
        child: Column(mainAxisSize: MainAxisSize.min, spacing: context.height * 0.03, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Flexible(
            flex: 8,
            child: Image.asset(height: 80, AppAssets.pokexplorerLogo, fit: BoxFit.scaleDown),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Iconsax.sun_1),
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (BuildContext context, ThemeState state) {
                  final bool isDarkMode = state.themeEntity?.themeType == ThemeType.dark;
                  return Switch(
                    value: isDarkMode, // true = dark mode, false = light mode
                    onChanged: (bool value) {
                      // When switch is ON (true), we want dark mode
                      // When switch is OFF (false), we want light mode
                      context.read<ThemeBloc>().add(ToggleThemeEvent(value));
                    },
                  );
                },
              ),
              const Icon(Iconsax.moon),
            ],
          ),
          Text('Developed by:', style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
          TextButton.icon(
            icon: Icon(Iconsax.profile_circle_copy),
            onPressed: () => openGitHubProfile(context),
            label: Text('arg0nath', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          ),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
              children: [
                TextSpan(text: 'Made using Flutter\n'),
                TextSpan(text: 'with ❤️ for the community\n2025'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
