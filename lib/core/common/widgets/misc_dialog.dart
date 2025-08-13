import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(height: 80, AppAssets.pokexplorerLogo, fit: BoxFit.scaleDown),
                Image.asset(height: 40, AppAssets.pokemonCustomPhrase, fit: BoxFit.scaleDown),
              ],
            ),
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
                      context.read<ThemeBloc>().add(ToggleThemeEvent(value));
                    },
                  );
                },
              ),
              const Icon(Iconsax.moon),
            ],
          ),
          GestureDetector(
            onTap: () => openGitHub(context),
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  Text('Developed by:', style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      SvgPicture.asset(AppAssets.githubLogoSvg, height: 20, width: 20, color: context.theme.colorScheme.onSurface),
                      Text('arg0nath', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
              children: [
                TextSpan(text: 'Made using Flutter\n'),
                TextSpan(text: 'with ❤️ for the community\n'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => openGitHub(context, isDisclaimer: true),
            child: Column(
              children: [
                Text('Disclaimer Info', style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
