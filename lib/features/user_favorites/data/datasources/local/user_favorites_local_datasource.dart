import 'package:pokexplorer/config/typedefs/typedefs.dart';
import 'package:pokexplorer/core/common/errors/exceptions.dart';
import 'package:pokexplorer/core/common/utils/pokemon/generate_preview_url.dart';
import 'package:pokexplorer/core/common/utils/pokemon/get_poke_image_by_id.dart';
import 'package:pokexplorer/features/type_details/data/dtos/pokemon_preview_dto.dart';
import 'package:pokexplorer/features/type_details/domain/entities/pokemon_preview.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class UserFavoritesLocalDataSource {
  Future<List<PokemonPreview>> getUserFavoritesFromDb();
  Future<void> addToFavoritesDb({required String name, required int id});
  Future<void> removeFromFavoritesDb({required String name});
}

class UserFavoritesLocalDataSourceImpl implements UserFavoritesLocalDataSource {
  const UserFavoritesLocalDataSourceImpl(this._db);

  final Database _db;

  static const String _favsTable = 'favorites';
  static const String _nameColumnName = 'name';
  static const String _idColumnName = 'id';

  @override
  Future<List<PokemonPreview>> getUserFavoritesFromDb() async {
    try {
      final List<DataMap> dtos = await _db.query(_favsTable);

      return dtos.map((DataMap map) {
        final PokemonPreviewDto dto = PokemonPreviewDto(
          url: getPokemonPreviewUrl(map[_idColumnName] as int),
          name: map[_nameColumnName] as String,
          thumbnail: getPokemonBaseImageById(map[_idColumnName] as int),
        );
        return dto.toEntity();
      }).toList();
    } catch (e) {
      throw CacheException(message: 'Failed to get favorites from database: $e');
    }
  }

  @override
  Future<void> addToFavoritesDb({required int id, required String name}) async {
    try {
      await _db.insert(
        _favsTable,
        {
          _idColumnName: id,
          _nameColumnName: name,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw CacheException(message: 'Failed to add Pokémon to favorites: $e');
    }
  }

  @override
  Future<void> removeFromFavoritesDb({required String name}) async {
    try {
      await _db.delete(
        _favsTable,
        where: '$_nameColumnName = ?',
        whereArgs: <String>[name],
      );
    } catch (e) {
      throw CacheException(message: 'Failed to remove Pokémon from favorites: $e');
    }
  }
}
