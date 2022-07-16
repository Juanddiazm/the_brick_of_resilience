import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE questionnaires(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        questionnaire TEXT NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

// id: the id of a item
// questionnaire: the questionnaire object
// created_at: the time that the item was created. It will be automatically handled by SQLite
  Future<sql.Database> db() async {
    return sql.openDatabase(
      'kindacode.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }
}
