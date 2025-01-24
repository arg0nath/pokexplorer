import 'dart:math' as math;

import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokexplorer/localization/app_localizations.dart';
import 'package:pokexplorer/core/enums/app_enums.dart';
import 'package:pokexplorer/core/models/app_models.dart' as app_models;
import 'package:pokexplorer/theme/bloc/theme_bloc.dart';
import 'package:pokexplorer/screens/type_selection/bloc/type_selection_bloc.dart';
import 'package:pokexplorer/core/utilities/app_utils.dart' as app_utils;
import 'package:pokexplorer/core/variables/app_constants.dart' as app_const;
import 'package:pokexplorer/core/variables/app_variables.dart' as app_vars;

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
  const CustomNetworkImage({
    super.key,
    required this.imageURL,
    this.width,
    this.height,
  });

  final String imageURL;
  final double? width;
  final double? height;

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  @override
  Widget build(BuildContext context) {
    if (widget.imageURL.contains('.svg')) {
      return CachedNetworkSVGImage(
        widget.imageURL,
        placeholder: _networkImageCustomPlaceHolder(),
        errorWidget: _networkImageErrorWidget(),
        width: widget.width,
        height: widget.height,
        fadeDuration: const Duration(milliseconds: 200),
      );
    } else {
      return Image.network(
        widget.imageURL,
        scale: 0.3,
        width: widget.width,
        height: widget.height,
        errorBuilder: (context, error, stackTrace) => _networkImageErrorWidget(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _networkImageCustomPlaceHolder();
        },
      );
    }
  }

  Widget _networkImageErrorWidget() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(border: Border.all(color: Colors.transparent, width: 0)),
      child: Center(
        child: Image.asset(app_const.EMPTY_POKEBALL_PNG, width: app_vars.logicalHeight * 0.05, height: app_vars.logicalHeight * 0.05),
      ),
    );
  }

  Widget _networkImageCustomPlaceHolder() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.transparent, width: app_const.NETWORK_IMAGE_PLACEHOLDER_WIDTH),
      ),
      child: const Center(child: CustomProgressIndicator()),
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

class CustomAppbarBackButton extends StatelessWidget {
  const CustomAppbarBackButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(hoverColor: Colors.transparent, highlightColor: Colors.transparent, onPressed: onPressed, icon: const Icon(Icons.arrow_back_outlined, color: app_const.PRIMARY_TEXT_COLOR));
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
                    appLocale.loadingDialogMessage,
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
              const Icon(Icons.light_mode_outlined, color: app_const.PRIMARY_TEXT_COLOR),
              BlocBuilder<TypeSelectionBloc, TypeSelectionState>(
                builder: (context, state) {
                  return CupertinoSwitch(
                    value: context.read<TypeSelectionBloc>().frontEndUtils.localDataUtils.loadIsDarkModeFromPrefs(), // The value of the switch
                    onChanged: (value) => {context.read<ThemeBloc>().add(const ToggleThemeEvent())},
                  );
                },
              ),
              const Icon(Icons.dark_mode_outlined, color: app_const.PRIMARY_TEXT_COLOR),
            ],
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}

class AppbarGradientBackground extends StatelessWidget {
  const AppbarGradientBackground({super.key, required this.typeName});

  final String typeName;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomAppbarBackgroundWaveClipper(),
      child: Container(
        width: app_vars.logicalWidth,
        height: app_const.POKEMON_DETAILS_APP_BAR_DELEGATE_MAX_EXTEND,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: app_utils.gradientFromType(typeName)),
        ),
      ),
    );
  }
}

class CustomAppbarBackgroundWaveClipper extends CustomClipper<Path> {
// sweet maths
  @override
  Path getClip(Size size) {
    var path = Path();
    const minSize = app_const.TYPE_DETAILS_APP_BAR_DELEGATE_MIN_EXTEND;
    final p1Diff = ((minSize - size.height) * 0.3).truncate().abs();
    path.lineTo(0.0, size.height - p1Diff);

    final controlPoint = Offset(size.width * 0.6, size.height);
    final endPoint = Offset(size.width, minSize);

    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomAppbarBackgroundWaveClipper oldClipper) => oldClipper != this;
}

class PokemonListCard extends StatefulWidget {
  const PokemonListCard({
    super.key,
    required this.pokemonPreview,
    required this.onCardTap,
    this.onFavoriteIconTap,
    this.onLongPress,
  });

  final app_models.PokemonPreview pokemonPreview;
  final VoidCallback onCardTap;
  final VoidCallback? onFavoriteIconTap;
  final VoidCallback? onLongPress;

  @override
  State<PokemonListCard> createState() => _PokemonListCardState();
}

class _PokemonListCardState extends State<PokemonListCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: widget.onLongPress,
        onTap: widget.onCardTap,
        child: Container(
            width: app_vars.logicalWidth * 0.7,
            height: app_vars.logicalHeight * 0.12,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: const Color(0xFFEEEEEE))),
            margin: EdgeInsets.symmetric(vertical: app_vars.logicalHeight * 0.01, horizontal: app_vars.logicalWidth * 0.06),
            child: Row(children: [
              //pokemon image
              Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      child: CustomNetworkImage(height: app_vars.logicalHeight * 0.1, width: app_vars.logicalHeight * 0.1, imageURL: widget.pokemonPreview.imageUrl))),
              //pokemon name
              Expanded(
                flex: 3,
                child: Text(widget.pokemonPreview.name.toUpperFirst(), maxLines: 3, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyLarge),
              ),
              //favorite icon
              if (widget.onFavoriteIconTap != null)
                Visibility(
                  visible: widget.onLongPress == null,
                  child: CustomFavoriteButton(
                    isFavorite: widget.pokemonPreview.isFavorite == RelationValue.favorite.value,
                    onPressed: widget.onFavoriteIconTap!,
                  ),
                ),
            ])));
  }
}

class AnimatedHeart extends StatelessWidget {
  // Add from here...
  final bool isActive;
  final Duration _duration = const Duration(milliseconds: 500);
  final Curve _curve = Curves.elasticOut;
  const AnimatedHeart({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isActive ? 0.6 : 0.5,
      duration: _duration,
      curve: _curve,
      child: TweenAnimationBuilder(
        curve: _curve,
        duration: _duration,
        tween: ColorTween(
          begin: app_const.GREY,
          end: isActive ? Theme.of(context).primaryColor : app_const.GREY,
        ),
        builder: (context, value, child) {
          final tmpIcon = isActive ? Icons.favorite_rounded : Icons.favorite_border_rounded;
          return Icon(
            tmpIcon,
            size: 50,
            color: value, // Modify from here...
          );
        }, // To here.
      ),
    );
  }
}

class CustomFavoriteButton extends StatefulWidget {
  const CustomFavoriteButton({super.key, required this.isFavorite, required this.onPressed});

  final VoidCallback onPressed;
  final bool isFavorite;

  @override
  State<CustomFavoriteButton> createState() => _CustomFavoriteButtonState();
}

class _CustomFavoriteButtonState extends State<CustomFavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedHeart(isActive: widget.isFavorite),
    );
  }
}

PopupMenuItem<dynamic> buildPopupMenuItem({required BuildContext context, required IconData iconData, required int value, required String menuItemTitle}) {
  return PopupMenuItem<dynamic>(
    value: value,
    padding: EdgeInsets.zero,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Icon(iconData),
        ),

        Flexible(
          child: Text(
            menuItemTitle,
            textAlign: TextAlign.center,
          ),
        ),
        // SizedBox(width: 5),
      ],
    ),
  );
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onActionTap,
    required this.actionButtonTitle,
  });

  final String title;
  final String description;
  final VoidCallback onActionTap;
  final String actionButtonTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title
      title: Text(title, textAlign: TextAlign.center),
      //description
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(description, textAlign: TextAlign.center),
        ],
      ),
      //button
      actions: [
        OutlinedButton(onPressed: onActionTap, child: Text(actionButtonTitle)),
      ],
    );
  }
}

class NoPokemonIndicator extends StatelessWidget {
  const NoPokemonIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(app_const.EMPTY_POKEBALL_PNG, width: app_vars.logicalHeight * 0.1, height: app_vars.logicalHeight * 0.1), // Replace with your image path
        const SizedBox(height: 10),
        Text(LocalizationManager.getInstance().noPokemonFound, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
