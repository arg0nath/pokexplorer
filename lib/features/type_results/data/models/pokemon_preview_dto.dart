class PokemonPreviewDto {
  const PokemonPreviewDto({
    required this.id,
    required this.typeId,
    required this.name,
    required this.imageUrl,
  });

  final int id;
  final int typeId;
  final String name;
  final String imageUrl;
}
