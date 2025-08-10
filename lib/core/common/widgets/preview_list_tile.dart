import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokexplorer/core/common/extensions/string_ext.dart';
import 'package:pokexplorer/core/common/widgets/favorite_button.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';

class PreviewListTile extends StatelessWidget {
  const PreviewListTile({super.key, required this.preview, required this.onTap});

  final PokemonPreview preview;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CachedNetworkImage(
          imageUrl: preview.thumbnail,
          placeholder: (_, __) => const SizedBox.shrink(),
          errorWidget: (_, __, ___) => const Icon(Icons.error),
        ),
        trailing: FavoriteButton(
          relatedPreview: preview,
        ),
        title: Text(preview.name.toUpperFirst()),
        onTap: onTap);
  }
}
