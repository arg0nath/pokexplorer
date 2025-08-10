import 'package:equatable/equatable.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';

class PokemonPreviewWithFavoriteModel extends Equatable {
  final PokemonPreview pokemon;
  final bool isFavorite;

  const PokemonPreviewWithFavoriteModel({
    required this.pokemon,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [pokemon, isFavorite];

  PokemonPreviewWithFavoriteModel copyWith({
    PokemonPreview? pokemon,
    bool? isFavorite,
  }) {
    return PokemonPreviewWithFavoriteModel(
      pokemon: pokemon ?? this.pokemon,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
