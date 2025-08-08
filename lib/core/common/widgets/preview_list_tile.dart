import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';

class PreviewListTile extends StatefulWidget {
  const PreviewListTile({super.key, required this.pokemon, required this.onTap, required this.onHearthTap});

  final PokemonPreview pokemon;
  final VoidCallback onTap;
  final VoidCallback onHearthTap;

  @override
  State<PreviewListTile> createState() => _PreviewListTileState();
}

class _PreviewListTileState extends State<PreviewListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CachedNetworkImage(
          imageUrl: widget.pokemon.url,
          placeholder: (BuildContext context, String url) => const SizedBox.shrink(),
          errorWidget: (BuildContext context, String url, dynamic error) => const Icon(Icons.error),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: widget.onHearthTap,
        ),
        title: Text(widget.pokemon.name),
        onTap: widget.onTap);
  }
}
