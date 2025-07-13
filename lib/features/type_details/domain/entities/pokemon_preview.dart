import 'package:equatable/equatable.dart';

abstract class PokemonPreview extends Equatable {
  const PokemonPreview({
    required this.id,
    required this.name,
    required this.thumbnail,
  });
  final int id;
  final String name;
  final String thumbnail;

  @override
  List<Object?> get props => [id, name];

  @override
  String toString() {
    return 'PokemonPreview(name: $name)';
  }
}
