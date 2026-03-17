import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/res/app_assets.dart';
import 'package:pokexplorer/core/common/widgets/pokeball_background.dart';
import 'package:pokexplorer/core/routes/route_names.dart';
import 'package:pokexplorer/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:pokexplorer/features/on_boarding/presentation/widgets/icon_title_holder.dart';
import 'package:pokexplorer/features/on_boarding/presentation/widgets/intro_text_holder.dart';
import 'package:pokexplorer/features/on_boarding/presentation/widgets/logo_placeholder.dart';
import 'package:pokexplorer/features/on_boarding/presentation/widgets/on_boarding_bottom_bar.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnBoardingCubit, bool>(
      listener: (BuildContext context, bool isFirstTimer) {
        if (!isFirstTimer) {
          context.goNamed(RouteName.typeSelectionPageName);
        }
      },
      listenWhen: (previous, current) => previous != current,
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: <Widget>[
            //background
            const Positioned(left: -20, bottom: -50, child: PokeballBackground()),
            //logo + text
            Container(
              padding: EdgeInsets.symmetric(vertical: context.height * 0.1, horizontal: context.width * 0.1),
              width: context.width,
              child: Column(
                children: <Widget>[
                  const Expanded(
                    flex: 3,
                    child: LogoPlaceholder(primaryLogoImagePath: AppAssets.pokexplorerLogo, secondaryLogoImagePath: AppAssets.pokemonCustomPhrase),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IntroTextHolder(text: 'Welcome, explorer!').animate(delay: 500.ms).fade(duration: 1000.ms, curve: Curves.easeOutQuad),
                        IntroTextHolder(text: 'A new Poké-search journey is about to begin...').animate(delay: 600.ms).fade(duration: 1000.ms, curve: Curves.easeOutQuad),
                        IntroTextHolder(text: 'Hooray!').animate(delay: 700.ms).fade(duration: 1000.ms, curve: Curves.easeOutQuad),
                        IconTitleHolder(iconData: Icons.catching_pokemon_outlined, message: 'Pick a type to explore').animate(delay: 800.ms).fade(duration: 1000.ms, curve: Curves.easeOutQuad),
                        IconTitleHolder(iconData: Icons.search_outlined, message: 'Search through Pokémon').animate(delay: 900.ms).fade(duration: 1000.ms, curve: Curves.easeOutQuad),
                        IconTitleHolder(iconData: Icons.info_outline_rounded, message: 'View stats of any Pokémon').animate(delay: 1000.ms).fade(duration: 1000.ms, curve: Curves.easeOutQuad),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: WelcomeBottomBar().animate(delay: 1000.ms).fade(duration: 1700.ms, curve: Curves.easeOutQuad),
      ),
    );
  }
}
