import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initFavoritesDatabase() async {
  final String databasesPath = await getDatabasesPath();
  final String path = join(databasesPath, 'favorites.db');

  return openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE favorites (
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL UNIQUE,
          url TEXT NOT NULL
        )
      ''');
    },
  );
}
