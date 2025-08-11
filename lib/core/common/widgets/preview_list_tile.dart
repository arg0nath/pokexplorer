import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/context_ext.dart';
import 'package:pokexplorer/core/common/extensions/string_ext.dart';
import 'package:pokexplorer/core/common/widgets/custom_network_image.dart';
import 'package:pokexplorer/core/common/widgets/favorite_button.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';

/* class PreviewListTile extends StatelessWidget {
  const PreviewListTile({super.key, required this.preview, required this.onTap});

  final PokemonPreview preview;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.all(12),
        minTileHeight: 80,
        minLeadingWidth: 70,
        leading: CachedNetworkImage(
          imageUrl: preview.thumbnail,
          placeholder: (_, __) => const SizedBox.shrink(),
          errorWidget: (_, __, ___) => const Icon(Icons.error),
        ),
        trailing: FavoriteButton(
          id: preview.id,
          name: preview.name,
        ),
        title: Text(preview.name.toUpperFirst()),
        onTap: onTap);
  }
} */

class PreviewListTile extends StatelessWidget {
  const PreviewListTile({
    super.key,
    required this.preview,
    required this.onCardTap,
    this.onLongPress,
  });

  final PokemonPreview preview;
  final VoidCallback onCardTap;

  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: onLongPress,
        onTap: onCardTap,
        child: Card(
            margin: EdgeInsets.symmetric(vertical: context.height * 0.01, horizontal: context.width * 0.06),
            child: Row(children: [
              //pokemon image
              Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.center, margin: const EdgeInsets.all(5), child: CustomNetworkImage(height: context.height * 0.1, width: context.height * 0.1, imageURL: preview.thumbnail))),
              //pokemon name
              Expanded(
                flex: 3,
                child: Text(preview.name.toUpperFirst(), maxLines: 3, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleLarge),
              ),
              //favorite icon

              FavoriteButton(
                id: preview.id,
                name: preview.name,
              ),
            ])));
  }
}
