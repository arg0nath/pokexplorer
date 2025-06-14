import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokexplorer/core/common/widgets/loading_dialog.dart';
import 'package:pokexplorer/core/services/routes/route_names.dart';
import 'package:pokexplorer/src/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    context.read<OnBoardingCubit>().checkIfUserFirstTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (BuildContext context, OnBoardingState state) {
          if (state is OnBoardingStatus && !state.isFirstTimer) {
            context.goNamed(RouteName.typeResultsPageName);
          } else if (state is UserCached) {
            context.goNamed(RouteName.typeResultsPageName);
          }
        },
        builder: (BuildContext context, OnBoardingState state) {
          if (state is CheckingIfUserFirstTimer || state is CachingFirstTimer) {
            return const DialogProgressPokeball(
              hardBackEnabled: false,
            );
          }
          return Column(
            children: <Widget>[
              const Text('HEllo1!!!'),
              FilledButton(
                onPressed: () => context.read<OnBoardingCubit>().cacheFirstTimer(),
                child: const Text('Continue'),
              ),
            ],
          );
        },
      ),
    );
  }
}
