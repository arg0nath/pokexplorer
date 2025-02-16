import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/constants/app_constants.dart';
import 'package:pokexplorer/core/common/utilities/app_utils.dart';
import 'package:pokexplorer/core/common/variables/app_variables.dart';
import 'package:pokexplorer/core/common/widgets/appbar_clipper.dart';

class AppbarGradientBackground extends StatelessWidget {
  const AppbarGradientBackground({super.key, required this.typeName});

  final String typeName;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomAppbarBackgroundWaveClipper(),
      child: Container(
        width: logicalWidth,
        height: POKEMON_DETAILS_APP_BAR_DELEGATE_MAX_EXTEND,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: AppUtils.gradientFromType(typeName)),
        ),
      ),
    );
  }
}
