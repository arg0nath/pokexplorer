import 'package:pokexplorer/features/type_results/data/models/pokemon_preview_dto.dart';

class PokemonPreview {
  PokemonPreview({required this.id, required this.typeId, required this.name, required this.imageUrl});

  final int id;
  final int typeId;
  final String imageUrl;
  final String name;

  /// Factory constructor to create a PokemonPreview from PokemonPreviewDto
  factory PokemonPreview.fromDto(PokemonPreviewDto dto) {
    return PokemonPreview(
      id: dto.id,
      typeId: dto.typeId,
      name: dto.name,
      imageUrl: dto.imageUrl,
    );
  }
}
