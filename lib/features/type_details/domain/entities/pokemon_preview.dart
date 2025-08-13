class PokemonPreview {
  const PokemonPreview({
    required this.id,
    required this.name,
    required this.thumbnail,
  });
  final int id;
  final String name;

  final String thumbnail;

  @override
  String toString() {
    return 'PokemonPreview(id: $id, name: $name, thumbnail: $thumbnail)';
  }
}
