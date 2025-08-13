import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/extensions/string_ext.dart';
import 'package:pokexplorer/core/common/widgets/custom_network_image.dart';
import 'package:pokexplorer/core/common/widgets/favorite_button.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';

///`PreviewListTile.selectable` unlocks:
/// 1) `isSeledted` will be used to highlight the tile
/// 2) `onLongPress` will be used to select the tile
/// 3) `FavoriteButton` will be shown
class PreviewListTile extends StatelessWidget {
  const PreviewListTile._({
    required this.preview,
    required this.onCardTap,
    this.onLongPress = null,
    this.isSelected = false,
    super.key,
  });

  factory PreviewListTile({
    required PokemonPreview preview,
    required VoidCallback onCardTap,
  }) {
    return PreviewListTile._(
      preview: preview,
      onCardTap: onCardTap,
    );
  }

  factory PreviewListTile.selectable({
    required PokemonPreview preview,
    required VoidCallback onCardTap,
    required VoidCallback onLongPress,
    required bool isSelected,
  }) {
    return PreviewListTile._(
      preview: preview,
      onCardTap: onCardTap,
      onLongPress: onLongPress,
      isSelected: isSelected,
    );
  }

  final PokemonPreview preview;
  final VoidCallback onCardTap;
  final VoidCallback? onLongPress;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: onLongPress,
        onTap: onCardTap,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.onSurface.withAlpha(10),
              border: isSelected ? Border.all(color: context.colorScheme.primary, width: 2) : null,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: context.theme.shadowColor.withAlpha(20),
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(children: [
              //pokemon image
              Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.center, margin: const EdgeInsets.all(5), child: CustomNetworkImage(height: context.height * 0.1, width: context.height * 0.1, imageURL: preview.thumbnail))),
              //pokemon name
              Expanded(
                flex: 3,
                child: Text(preview.name.toUpperFirst(), maxLines: 3, overflow: TextOverflow.ellipsis, style: context.textTheme.titleLarge),
              ),
              if (onLongPress == null)
                //favorite icon

                FavoriteButton(
                  id: preview.id,
                  avatarUrl: preview.thumbnail,
                  name: preview.name,
                ),
            ])));
  }
}
