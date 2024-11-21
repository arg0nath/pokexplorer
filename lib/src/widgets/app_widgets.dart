import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.scaleDown, //usually scaleDown or fillHeight,
          ),
          borderRadius: BorderRadius.zero,
        ),
      ),
      placeholder: (BuildContext context, String url) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.transparent,
            width: app_const.NETWORK_IMAGE_PLACEHOLDER_WIDTH,
          ),
        ),
        child: const Center(
          child: CustomProgressIndicator(),
        ),
      ),
      errorWidget: (BuildContext context, String url, dynamic error) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        child: Center(
          child: Image.asset(
            app_const.EMPTY_POKEBALL_PNG,
            width: 60,
            height: 60,
          ),
        ),
      ),
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
          MyText(
            widget.typeName.toUpperFirst(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.black38),
          ),
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

class DialogProgressPokeball extends StatelessWidget {
  const DialogProgressPokeball({super.key, required this.hardBackEnabled});

  final bool hardBackEnabled;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: hardBackEnabled,
      child: Center(
        child: Container(
          width: app_vars.logicalWidth * 0.54,
          height: app_vars.logicalHeight * 0.3,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: app_const.DIALOG_BORDER_COLOR, width: app_const.DIALOG_BORDER_WIDTH),
              color: app_const.TOTAL_WHITE,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(app_const.DIALOG_PADDING),
              boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black26, blurRadius: 10.0, offset: Offset(0.0, 10.0))]),
          padding: const EdgeInsets.all(25),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Expanded(
                  flex: 1,
                  child: MyText(
                    'Collecting Pokémon...',
                  )),
              Expanded(flex: 2, child: Center(child: Lottie.asset(app_const.LOADING_POKEBALL_LOTTIE, height: 200, width: 200, repeat: true, reverse: true, fit: BoxFit.contain))),
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
    app_utils.myLog(app_const.LOG_INFO, 'typeee: $type');
    final tmpPercent = (value) / 256; //bigest value
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText('$name :', style: const TextStyle(fontSize: 18, color: app_const.SECONDARY_TEXT_COLOR)),
        LinearPercentIndicator(
            width: app_vars.logicalWidth * 0.6,
            animation: true,
            barRadius: const Radius.circular(20),
            lineHeight: 20.0,
            animationDuration: 1500,
            percent: tmpPercent,
            center: MyText('$value'),
            progressColor: app_utils.gradientFromType(type).first),
      ],
    );
  }
}

class MyText extends StatelessWidget {
  const MyText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  });
  final String data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  @override
  Widget build(BuildContext context) {
    return Text(data,
        style: TextStyle(
          fontStyle: style?.fontStyle,
          fontFamily: style?.fontFamily ?? app_const.MAIN_FONT_FAMILY,
          fontSize: style?.fontSize,
          color: style?.color ?? app_const.PRIMARY_TEXT_COLOR,
          fontWeight: style?.fontWeight ?? FontWeight.w800,
        ),
        strutStyle: strutStyle,
        textAlign: textAlign,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: TextScaler.noScaling,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior);
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
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: app_vars.logicalWidth * 0.7,
        // height: app_vars.logicalHeight * 0.85,
        decoration: BoxDecoration(
            border: Border.all(color: app_const.DIALOG_BORDER_COLOR, width: app_const.DIALOG_BORDER_WIDTH),
            color: app_const.TOTAL_WHITE,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(app_const.DIALOG_PADDING),
            boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black26, blurRadius: 10.0, offset: Offset(0.0, 10.0))]),
        padding: const EdgeInsets.all(25),
        child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Flexible(
            flex: 8,
            child: Image.asset(height: 80, app_const.POKEXPLORER_LOGO_PNG, fit: BoxFit.scaleDown),
          ),
          const SizedBox(height: 5),
          const Flexible(
              flex: 6, child: MyText('Pokéxplorer', textAlign: TextAlign.center, style: TextStyle(color: app_const.PRIMARY_TEXT_COLOR, fontFamily: app_const.MAIN_FONT_FAMILY, fontSize: 18))),
          const SizedBox(height: 5),
          const MyText('v. 1.0.001', textAlign: TextAlign.left, style: TextStyle(color: app_const.SECONDARY_TEXT_COLOR, fontSize: 18)),
          const Flexible(flex: 1, child: SizedBox(height: 30)),
          const MyText('Developed by: ', textAlign: TextAlign.left, style: TextStyle(color: app_const.SECONDARY_TEXT_COLOR, fontSize: 18)),
          const SizedBox(height: 5),
          const SizedBox(height: 40, child: MyText('Vasileios Makris', style: TextStyle(color: app_const.SECONDARY_TEXT_COLOR, fontSize: 18))),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () async => app_utils.sendContactEmail(),
            style: OutlinedButton.styleFrom(
                foregroundColor: app_const.TOTAL_WHITE, backgroundColor: app_const.MORE_VIBRANT_TURQUOISE, side: const BorderSide(width: 1, color: app_const.MORE_VIBRANT_TURQUOISE)),
            child: const MyText('Contact me', style: TextStyle(color: app_const.TOTAL_WHITE, fontSize: 18)),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
