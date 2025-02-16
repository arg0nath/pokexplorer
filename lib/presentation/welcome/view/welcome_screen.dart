import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/core/common/constants/app_constants.dart';
import 'package:pokexplorer/core/common/widgets/custom_action_button.dart';
import 'package:pokexplorer/core/common/widgets/selected_type_container.dart';
import 'package:pokexplorer/core/theme/colors/app_palette.dart';
import 'package:pokexplorer/domain/front_end_utils.dart';
import 'package:pokexplorer/localization/app_localizations.dart';
import 'package:pokexplorer/presentation/welcome/bloc/welcome_bloc.dart';
import 'package:pokexplorer/router/app_router.dart';

import '../../../core/common/variables/app_variables.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late final WelcomeBloc _welcomeBloc = context.read<WelcomeBloc>();
  LocalizationManager appLocale = LocalizationManager.getInstance();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

    _welcomeBloc.add(const LoadWelcomePageEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: WelcomeBottomBar(appLocale: appLocale, frontEndUtils: _welcomeBloc.frontEndUtils),
      body: _welcomeBody(),
    );
  }

  BlocBuilder<WelcomeBloc, WelcomeState> _welcomeBody() {
    return BlocBuilder<WelcomeBloc, WelcomeState>(
      builder: (context, state) {
        return Stack(
          children: [
            //background
            const Positioned(left: -20, bottom: -50, child: PokeballBackground()),
            //logo + text
            Container(
                padding: EdgeInsets.symmetric(vertical: logicalHeight * 0.1, horizontal: logicalWidth * 0.1),
                width: logicalWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      flex: 3,
                      child: WelcomLogoPlaceholder(primaryLogoImagePath: POKEXPLORER_LOGO_PNG, secondaryLogoImagePath: POKEMON_CUSTOM_PHRASE),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          WelcomTitle(title: appLocale.welcomeTitle),
                          WelcomMessage(iconData: Icons.catching_pokemon_outlined, message: appLocale.welcomeMessage1),
                          WelcomMessage(iconData: Icons.search_outlined, message: appLocale.welcomeMessage2),
                          WelcomMessage(iconData: Icons.info_outline_rounded, message: appLocale.welcomeMessage3),
                          WelcomMessage(iconData: Icons.favorite_outline_rounded, message: appLocale.welcomeMessage4),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}

class WelcomeBottomBar extends StatelessWidget {
  const WelcomeBottomBar({
    super.key,
    required this.frontEndUtils,
    required this.appLocale,
  });

  final FrontendUtils frontEndUtils;
  final LocalizationManager appLocale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: logicalHeight * 0.02, right: logicalWidth * 0.05),
      color: AppPalette.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomActionButton(
            text: appLocale.welcomeButtonText,
            onPressed: () {
              frontEndUtils.localDataUtils.saveIsInitBootToPrefs(false);
              Navigator.popUntil(context, (Route route) => route.isFirst);
              Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
            },
          ).animate(delay: 2300.ms).fade(duration: 1000.ms, curve: Curves.easeOutQuad)
        ],
      ),
    );
  }
}

class WelcomLogoPlaceholder extends StatelessWidget {
  const WelcomLogoPlaceholder({
    super.key,
    required this.primaryLogoImagePath,
    this.secondaryLogoImagePath,
  });

  final String primaryLogoImagePath;
  final String? secondaryLogoImagePath;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: logicalWidth,
        // color: const Color.fromARGB(108, 76, 105, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(primaryLogoImagePath),
            if (secondaryLogoImagePath != null) Flexible(child: Image.asset(secondaryLogoImagePath!)),
          ],
        ).animate().fade().moveY(begin: logicalHeight * 0.2, curve: Curves.easeOutQuad, duration: 1500.ms, end: 0).then() // .animate().fade(duration: 1000.ms, curve: Curves.easeOutQuad),
        );
  }
}

class WelcomTitle extends StatelessWidget {
  const WelcomTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center).animate(delay: 1800.ms).fade(duration: 1700.ms, curve: Curves.easeOutQuad);
  }
}

class WelcomMessage extends StatelessWidget {
  const WelcomMessage({
    super.key,
    required this.message,
    required this.iconData,
  });

  final String message;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: logicalHeight * 0.05),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(padding: EdgeInsets.only(left: logicalWidth * 0.1, right: logicalWidth * 0.05), child: Icon(iconData)),
        Flexible(
          child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
        )
      ]).animate(delay: 2100.ms).fade(duration: 1000.ms, curve: Curves.easeOutQuad),
    );
  }
}
