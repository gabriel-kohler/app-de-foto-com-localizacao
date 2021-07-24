import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DatabaseUtil {
  static Future<sql.Database> database() async {
    final databasePath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(databasePath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DatabaseUtil.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }


  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DatabaseUtil.database();
    return db.query(table);
  }

  static Future<void> remove(String idItem) async {
    final db = await DatabaseUtil.database();
    return db.delete('places', where: 'id=$idItem');
  }

}
