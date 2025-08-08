import 'package:pokexplorer/core/common/errors/exceptions.dart';
import 'package:pokexplorer/features/type_details/data/dtos/pokemon_preview_dto.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class UserFavoritesLocalDataSource {
  Future<List<PokemonPreview>> getUserFavoritesFromDb();
  Future<void> addToFavoritesDb({required PokemonPreviewDto previewDto});
  Future<void> removeFromFavoritesDb({required int pokemonId});
}

class UserFavoritesLocalDataSourceImpl implements UserFavoritesLocalDataSource {
  const UserFavoritesLocalDataSourceImpl(this._db);

  final Database _db;

  static const String _tableName = 'favorites';
  static const String _idColumnName = 'id';

  @override
  Future<List<PokemonPreview>> getUserFavoritesFromDb() async {
    try {
      final List<Map<String, dynamic>> dtos = await _db.query(_tableName);

      return dtos.map((Map<String, dynamic> map) {
        final PokemonPreviewDto dto = PokemonPreviewDto.fromJson(map);
        // Use the id directly from the DB row if present
        final int? idFromDb = map[_idColumnName] as int?;
        return dto.toEntity();
      }).toList();
    } catch (e) {
      throw CacheException(message: 'Failed to get favorites from database: $e');
    }
  }

  @override
  Future<void> addToFavoritesDb({required PokemonPreviewDto previewDto}) async {
    try {
      await _db.insert(
        _tableName,
        previewDto.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw CacheException(message: 'Failed to add Pokémon to favorites: $e');
    }
  }

  @override
  Future<void> removeFromFavoritesDb({required int pokemonId}) async {
    try {
      await _db.delete(
        _tableName,
        where: '$_idColumnName = ?',
        whereArgs: <int>[pokemonId],
      );
    } catch (e) {
      throw CacheException(message: 'Failed to remove Pokémon from favorites: $e');
    }
  }
}
