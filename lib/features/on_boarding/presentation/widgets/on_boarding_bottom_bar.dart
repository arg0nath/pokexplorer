import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokexplorer/config/theme/app_palette.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class WelcomeBottomBar extends StatelessWidget {
  const WelcomeBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: AppPalette.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton(
            child: Text("Start", style: context.textTheme.titleMedium?.copyWith(color: context.colorScheme.onPrimary, fontWeight: FontWeight.w600)),
            onPressed: () {
              context.read<OnBoardingCubit>().cacheFirstTimer();
            },
          ),
        ],
      ),
    );
  }
}
