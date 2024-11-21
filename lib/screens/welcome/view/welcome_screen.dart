import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/src/variables/app_constants.dart' as app_const;
import 'package:pokexplorer/screens/welcome/bloc/welcome_bloc.dart';
import 'package:pokexplorer/src/widgets/app_widgets.dart' as app_widgets;
import '../../../src/variables/app_variables.dart' as app_vars;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late final WelcomeBloc _welcomeBloc = context.read<WelcomeBloc>();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

    _welcomeBloc.add(const LoadWelcomePageEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app_const.TOTAL_WHITE,
      extendBody: true,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: app_const.TOTAL_WHITE, backgroundColor: app_const.BRIGHT_RED, side: const BorderSide(width: 1, color: app_const.LIGHT_RED)),
              onPressed: () {
                _welcomeBloc.frontEndUtils.localDataUtils.saveIsInitBootToPrefs(false);
                Navigator.popUntil(context, (Route route) => route.isFirst);
                Navigator.pushReplacementNamed(context, app_const.TYPE_SELECTION_SCREEN_PAGE_ROUTE_NAME);
              },
              child: const app_widgets.MyText("Let's start!", style: TextStyle(color: app_const.TOTAL_WHITE, fontSize: 19)),
            ).animate(delay: 2300.ms).fade(duration: 1000.ms, curve: Curves.easeOutQuad)
          ],
        ),
      ),
      body: BlocBuilder<WelcomeBloc, WelcomeState>(
        builder: (context, state) {
          return Stack(
            children: [
              const Positioned(left: -20, bottom: -50, child: app_widgets.PokeballBackground()),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
                  width: app_vars.logicalWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                            width: app_vars.logicalWidth,
                            // color: const Color.fromARGB(108, 76, 105, 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(app_const.POKEXPLORER_LOGO_PNG),
                                Flexible(child: Image.asset(app_const.POKEMON_CUSTOM_PHRASE)),
                              ],
                            )
                                .animate()
                                .fade()
                                .moveY(begin: app_vars.logicalHeight * 0.2, curve: Curves.easeOutQuad, duration: 1500.ms, end: 0)
                                .then() // .animate().fade(duration: 1000.ms, curve: Curves.easeOutQuad),
                            ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const app_widgets.MyText('Welcome, explorer! A new Poké-search journey is about to begin... Hooray!', style: TextStyle(fontSize: 18), textAlign: TextAlign.center)
                                .animate(delay: 1800.ms)
                                .fade(duration: 1700.ms, curve: Curves.easeOutQuad),
                            const SizedBox(height: 40),
                            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                              Padding(padding: const EdgeInsets.symmetric(horizontal: 30), child: Image.asset(app_const.POKEBALL_OUTLINED_PNG, width: 20)),
                              const Flexible(child: app_widgets.MyText('Pick a type to explore', style: TextStyle(fontSize: 18)))
                            ]).animate(delay: 1900.ms).fade(duration: 1000.ms, curve: Curves.easeOutQuad),
                            const SizedBox(height: 40),
                            const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 30), child: Icon(Icons.search_outlined)),
                              Flexible(
                                child: app_widgets.MyText('Search through Pokémon', style: TextStyle(fontSize: 18)),
                              )
                            ]).animate(delay: 2000.ms).fade(duration: 1000.ms, curve: Curves.easeOutQuad),
                            const SizedBox(height: 40),
                            const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 30), child: Icon(Icons.info_outline_rounded)),
                              Flexible(
                                child: app_widgets.MyText('View stats of any Pokémon', style: TextStyle(fontSize: 18)),
                              )
                            ]).animate(delay: 2100.ms).fade(duration: 1000.ms, curve: Curves.easeOutQuad),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          );
        },
      ),
    );
  }
}
