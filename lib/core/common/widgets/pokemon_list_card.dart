import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/enums/app_enums.dart';
import 'package:pokexplorer/core/common/models/app_models.dart';
import 'package:pokexplorer/core/common/utilities/app_utils.dart';
import 'package:pokexplorer/core/common/variables/app_variables.dart';
import 'package:pokexplorer/core/common/widgets/custom_favorite_button.dart';
import 'package:pokexplorer/core/common/widgets/custom_network_image.dart';
import 'package:pokexplorer/core/theme/colors/app_palette.dart';

class PokemonListCard extends StatelessWidget {
  const PokemonListCard({
    super.key,
    required this.pokemonPreview,
    required this.onCardTap,
    this.onFavoriteIconTap,
    this.onLongPress,
  });

  final PokemonPreview pokemonPreview;
  final VoidCallback onCardTap;
  final VoidCallback? onFavoriteIconTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: onLongPress,
        onTap: onCardTap,
        child: Card(
            margin: EdgeInsets.symmetric(vertical: logicalHeight * 0.01, horizontal: logicalWidth * 0.06),
            child: Row(children: [
              //pokemon image
              Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(5),
                      child: CustomNetworkImage(height: logicalHeight * 0.1, width: logicalHeight * 0.1, imageURL: pokemonPreview.imageUrl))),
              //pokemon name
              Expanded(
                flex: 3,
                child: Text(pokemonPreview.name.toUpperFirst(), maxLines: 3, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleLarge),
              ),
              //favorite icon
              if (onFavoriteIconTap != null)
                Visibility(
                  visible: onLongPress == null,
                  child: CustomFavoriteButton(
                    isFavorite: pokemonPreview.isFavorite == RelationValue.favorite.value,
                    onPressed: onFavoriteIconTap!,
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
          begin: AppPalette.grey,
          end: isActive ? AppPalette.brightRed : AppPalette.grey,
        ),
        builder: (context, value, child) {
          final tmpIcon = isActive ? Icons.favorite_rounded : Icons.favorite_border_rounded;
          return Icon(
            tmpIcon,
            size: 50,
            color: value,
          );
        },
      ),
    );
  }
}
