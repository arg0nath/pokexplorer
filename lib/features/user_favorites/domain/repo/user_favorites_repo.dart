import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';

abstract interface class UserFavoritesRepo {
  const UserFavoritesRepo();

  ResultFuture<List<PokemonPreview>> getUserFavorites();
  ResultFutureVoid addToFavorites({required PokemonPreview pokePreview});
  ResultFutureVoid removeFromFavorites({required int pokemonId});
}
