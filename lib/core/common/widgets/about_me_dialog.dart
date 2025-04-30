import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pokexplorer/core/common/constants/app_constants.dart';
import 'package:pokexplorer/core/common/utilities/app_utils.dart';
import 'package:pokexplorer/core/common/variables/app_variables.dart';
import 'package:pokexplorer/core/localization/app_localizations.dart';
import 'package:pokexplorer/core/theme/bloc/theme_bloc.dart';
import 'package:pokexplorer/presentation/type_selection/bloc/type_selection_bloc.dart';

class AboutMeDialog extends StatelessWidget {
  const AboutMeDialog({super.key});

  @override
  Dialog build(BuildContext context) {
    LocalizationManager appLocale = LocalizationManager.getInstance();
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CIRCULAR_RADIUS)),
      elevation: 0.0,
      child: Container(
        width: logicalWidth * 0.7,
        padding: const EdgeInsets.all(25),
        child: Column(mainAxisSize: MainAxisSize.min, spacing: logicalHeight * 0.03, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Flexible(
            flex: 8,
            child: Image.asset(height: 80, POKEXPLORER_LOGO_PNG, fit: BoxFit.scaleDown),
          ),
          Row( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.sun_1),
              BlocBuilder<TypeSelectionBloc, TypeSelectionState>(
                builder: (context, state) {
                  return CupertinoSwitch(
                    value: context.read<TypeSelectionBloc>().frontEndUtils.localDataUtils.loadIsDarkModeFromPrefs(), // The value of the switch
                    onChanged: (value) => {context.read<ThemeBloc>().add(const ToggleThemeEvent())},
                  );
                },
              ),
              const Icon(Iconsax.moon),
            ],
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: theme.textTheme.titleMedium,
              text: 'Made using Flutter by:\n',
              children: [
                TextSpan(text: 'Vasileios Makris', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: () async => AppUtils.sendContactEmail(),
            label: Text(appLocale.contactMe),
            icon: const Icon(Iconsax.user),
          ),
        ]),
      ),
    );
  }
}
