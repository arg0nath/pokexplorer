import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokexplorer/localization/app_localizations.dart';
import 'package:pokexplorer/theme/bloc/theme_bloc.dart';
import 'package:pokexplorer/screens/type_selection/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/src/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/src/variables/app_constants.dart' as app_const;
import 'package:pokexplorer/src/variables/app_variables.dart' as app_vars;

class CustomProgressIndicator extends StatefulWidget {
  const CustomProgressIndicator({super.key, this.value});

  final double? value;

  @override
  State<CustomProgressIndicator> createState() => _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(value: widget.value, valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFBDBDBD)));
  }
}

class CustomNetworkImage extends StatefulWidget {
  const CustomNetworkImage({super.key, required this.imageURL, this.width, this.height});

  final String imageURL;
  final double? width;
  final double? height;

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageURL,
      scale: 0.6,
      imageBuilder: (BuildContext context, ImageProvider imageProvider) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.scaleDown),
          borderRadius: BorderRadius.zero,
        ),
      ),
      placeholder: (BuildContext context, String url) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.transparent, width: app_const.NETWORK_IMAGE_PLACEHOLDER_WIDTH),
        ),
        child: const Center(child: CustomProgressIndicator()),
      ),
      errorWidget: (BuildContext context, String url, dynamic error) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(border: Border.all(color: Colors.transparent, width: 0)),
        child: Center(
          child: Image.asset(app_const.EMPTY_POKEBALL_PNG, width: app_vars.logicalHeight * 0.05, height: app_vars.logicalHeight * 0.05),
        ),
      ),
    );
  }
}

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: Theme.of(context).outlinedButtonTheme.style,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class SelectedTypeContainer extends StatefulWidget {
  const SelectedTypeContainer({super.key, required this.typeName});

  final String typeName;

  @override
  State<SelectedTypeContainer> createState() => _SelectedTypeContainerState();
}

class _SelectedTypeContainerState extends State<SelectedTypeContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // margin: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30, width: 30, child: Image.asset(app_utils.typeToAssetIcon(widget.typeName))),
          const SizedBox(width: 10),
          Text(widget.typeName.toUpperFirst(), textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class PokeballBackground extends StatelessWidget {
  const PokeballBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 20 * math.pi / 180,
      child: Opacity(
        opacity: 0.05,
        child: Image.asset(
          width: app_vars.logicalWidth * 0.6,
          app_const.POKEBALL_OUTLINED_PNG,
        ),
      ),
    );
  }
}

class DialogProgressPokeball extends StatefulWidget {
  const DialogProgressPokeball({
    super.key,
    required this.hardBackEnabled,
  });

  final bool hardBackEnabled;

  @override
  State<DialogProgressPokeball> createState() => _DialogProgressPokeballState();
}

class _DialogProgressPokeballState extends State<DialogProgressPokeball> {
  @override
  Widget build(BuildContext context) {
    LocalizationManager appLocale = LocalizationManager.getInstance();
    return PopScope(
      canPop: widget.hardBackEnabled,
      child: Center(
        child: Container(
          width: app_vars.logicalWidth * 0.54,
          height: app_vars.logicalHeight * 0.3,
          margin: EdgeInsets.symmetric(horizontal: app_vars.logicalWidth * 0.2, vertical: app_vars.logicalHeight * 0.1),
          decoration: BoxDecoration(
              border: Border.all(color: app_const.DIALOG_BORDER_COLOR, width: app_const.DIALOG_BORDER_WIDTH),
              color: app_const.WHITE_TOTAL,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(app_const.DIALOG_PADDING),
              boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black26, blurRadius: 10.0, offset: Offset(0.0, 10.0))]),
          padding: const EdgeInsets.all(25),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Text(
                    '${appLocale.loadingDialogMessage}',
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
              Expanded(
                  flex: 2,
                  child: Center(
                      child: Lottie.asset(app_const.LOADING_POKEBALL_LOTTIE,
                          height: app_vars.logicalHeight * 0.1, width: app_vars.logicalHeight * 0.1, repeat: true, reverse: true, fit: BoxFit.contain))),
            ],
          )),
        ),
      ),
    );
  }
}

class CustomPercentIndicator extends StatelessWidget {
  const CustomPercentIndicator({
    super.key,
    required this.value,
    required this.name,
    required this.type,
  });

  final String type;
  final String name;
  final int value;

  @override
  Widget build(BuildContext context) {
    app_utils.myLog(app_const.LOG_INFO, 'type: $type');
    final tmpPercent = (value) / 256; //bigest value
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$name :', style: Theme.of(context).textTheme.bodyMedium),
        LinearPercentIndicator(
          width: app_vars.logicalWidth * 0.6,
          animation: true,
          barRadius: const Radius.circular(20),
          lineHeight: 20.0,
          animationDuration: 1500,
          percent: tmpPercent,
          progressColor: app_utils.gradientFromType(type).first,
        ),
        Text('$value', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class AboutMeDialog extends StatefulWidget {
  const AboutMeDialog({
    super.key,
  });

  @override
  State<AboutMeDialog> createState() => _AboutMeDialogState();
}

class _AboutMeDialogState extends State<AboutMeDialog> {
  LocalizationManager appLocale = LocalizationManager.getInstance();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: app_vars.logicalWidth * 0.7,
        // height: app_vars.logicalHeight * 0.85,
        decoration: BoxDecoration(
            border: Border.all(color: app_const.DIALOG_BORDER_COLOR, width: app_const.DIALOG_BORDER_WIDTH),
            color: app_const.WHITE_TOTAL,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(app_const.DIALOG_PADDING),
            boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black26, blurRadius: 10.0, offset: Offset(0.0, 10.0))]),
        padding: const EdgeInsets.all(25),
        child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Flexible(
            flex: 8,
            child: Image.asset(height: 80, app_const.POKEXPLORER_LOGO_PNG, fit: BoxFit.scaleDown),
          ),
          SizedBox(height: app_vars.logicalHeight * 0.01),
          Text('Developed by: ', textAlign: TextAlign.left, style: theme.textTheme.bodySmall),
          SizedBox(height: app_vars.logicalHeight * 0.03, child: Text('Vasileios Makris', style: theme.textTheme.bodySmall)),
          SizedBox(height: app_vars.logicalHeight * 0.03),
          OutlinedButton(onPressed: () async => app_utils.sendContactEmail(), style: Theme.of(context).outlinedButtonTheme.style, child: Text(appLocale.contactMe)),
          SizedBox(height: app_vars.logicalHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.light_mode_outlined, color: app_const.PRIMARY_TEXT_COLOR),
              BlocBuilder<TypeSelectionBloc, TypeSelectionState>(
                builder: (context, state) {
                  return CupertinoSwitch(
                    value: context.read<TypeSelectionBloc>().frontEndUtils.localDataUtils.loadIsDarkModeFromPrefs(), // The value of the switch
                    onChanged: (value) => {context.read<ThemeBloc>().add(ToggleThemeEvent())},
                  );
                },
              ),
              Icon(Icons.dark_mode_outlined, color: app_const.PRIMARY_TEXT_COLOR),
            ],
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
