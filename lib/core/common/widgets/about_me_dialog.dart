import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/theme/bloc/theme_bloc.dart';
import 'package:pokexplorer/core/theme/colors/app_palette.dart';
import 'package:pokexplorer/core/utilities/app_utils.dart';
import 'package:pokexplorer/core/variables/app_constants.dart';
import 'package:pokexplorer/core/variables/app_variables.dart';
import 'package:pokexplorer/localization/app_localizations.dart';
import 'package:pokexplorer/presentation/type_selection/bloc/type_selection_bloc.dart';

class AboutMeDialog extends StatelessWidget {
  const AboutMeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    LocalizationManager appLocale = LocalizationManager.getInstance();
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0.0,
      child: Container(
        width: logicalWidth * 0.7,
        decoration: BoxDecoration(
            border: Border.all(width: DIALOG_BORDER_WIDTH),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(DIALOG_PADDING),
            boxShadow: const <BoxShadow>[BoxShadow(color: AppPalette.shadowDark, blurRadius: 10.0, offset: Offset(0.0, 10.0))]),
        padding: const EdgeInsets.all(25),
        child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Flexible(
            flex: 8,
            child: Image.asset(height: 80, POKEXPLORER_LOGO_PNG, fit: BoxFit.scaleDown),
          ),
          SizedBox(height: logicalHeight * 0.01),
          Text('Developed by: ', textAlign: TextAlign.left, style: theme.textTheme.bodySmall),
          SizedBox(height: logicalHeight * 0.03, child: Text('Vasileios Makris', style: theme.textTheme.bodySmall)),
          SizedBox(height: logicalHeight * 0.03),
          OutlinedButton(onPressed: () async => AppUtils.sendContactEmail(), child: Text(appLocale.contactMe)),
          SizedBox(height: logicalHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.light_mode_outlined),
              BlocBuilder<TypeSelectionBloc, TypeSelectionState>(
                builder: (context, state) {
                  return CupertinoSwitch(
                    value: context.read<TypeSelectionBloc>().frontEndUtils.localDataUtils.loadIsDarkModeFromPrefs(), // The value of the switch
                    onChanged: (value) => {context.read<ThemeBloc>().add(const ToggleThemeEvent())},
                  );
                },
              ),
              const Icon(Icons.dark_mode_outlined),
            ],
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
