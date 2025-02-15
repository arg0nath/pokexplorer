import 'package:path/path.dart';
import 'package:pokexplorer/core/models/app_models.dart';
import 'package:pokexplorer/core/utilities/app_utils.dart';
import 'package:pokexplorer/core/variables/app_constants.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _tableName = 'favorites';
  final String _idColumnName = 'id';
  final String _nameColumnName = 'name';
  final String _imageUrlColumnName = 'image_url';
  final String _isFavoriteColumnName = 'is_favorite';

  DatabaseService._constructor(); //private constructor

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final dbDirPath = await getDatabasesPath();

    final dbPath = join(dbDirPath, "master_db.db");
    final database = await openDatabase(
      version: 1,
      dbPath,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE  $_tableName (
          $_idColumnName INTEGER PRIMARY KEY,
          $_nameColumnName TEXT NOT NULL,
          $_imageUrlColumnName TEXT NOT NULL,
          $_isFavoriteColumnName INTEGER NOT NULL    
        )
        ''');
      },
    );
    return database;
  }

  Future<List<PokemonPreview>> getDbPokemonPreviewList() async {
    final db = await database;
    final data = await db.query(_tableName);

    List<PokemonPreview> pokePreviewList = data.map((Map<String, Object?> pokePreview) {
      int isFavoriteValue = 0; // Default value
      int idValue = 0; // Default value
      final tmpIsFavorite = pokePreview[_isFavoriteColumnName];
      final tmpId = pokePreview[_idColumnName];

      if (tmpId is int) {
        idValue = tmpId;
      } else if (tmpId is String) {
        idValue = int.tryParse(tmpId) ?? 0;
      }

      if (tmpIsFavorite is int) {
        isFavoriteValue = tmpIsFavorite;
      } else if (tmpIsFavorite is String) {
        isFavoriteValue = int.tryParse(tmpIsFavorite) ?? 0;
      }
      return PokemonPreview(
        id: idValue,
        name: (pokePreview[_nameColumnName] as String),
        imageUrl: pokePreview[_imageUrlColumnName] as String,
        isFavorite: isFavoriteValue,
      );
    }).toList();

    return pokePreviewList;
  }

  Future<void> addFavPokePreviewToDb({
    required String name,
    required String imageUrl,
  }) async {
    final db = await database;
    await db.insert(_tableName, {
      _nameColumnName: name,
      _imageUrlColumnName: imageUrl,
      _isFavoriteColumnName: 1,
    });
    AppUtils.myLog(level: LOG_WARNING, msg: 'DB: add $name preview to db');
    return Future<void>.value();
  }

//not needed
  void updatePokemonPreviewRelation({
    required String name,
    required int isFavorite,
  }) async {
    final db = await database;
    await db.update(
      _tableName,
      {
        _isFavoriteColumnName: isFavorite,
      },
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<void> deleteFavPokePreviewFromDb({required String name}) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'name = ?',
      whereArgs: [name.toLowerCase()],
    );
    AppUtils.myLog(level: LOG_WARNING, msg: 'DB: delete preview $name from db ');
  }

  Future<void> deleteAllFavPokePreviewFromDb() async {
    final db = await database;
    await db.delete(
      _tableName,
    );
    AppUtils.myLog(level: LOG_WARNING, msg: 'DB: delete all db ');
  }
}
