import 'package:agenda_compartilhada/infrastructure/database/helper/script.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Connection {
  static late Database _db;
  static bool isOpened = false;

  static Future<Database> openDb() async {
    if (!isOpened) {
      var path = join(await getDatabasesPath(), 'database.db');
      await deleteDatabase(path);
      _db = await openDatabase(path, version: 1, onCreate: (db, version) {
        createTables.forEach(db.execute);
        userInserts.forEach(db.execute);
        eventInserts.forEach(db.execute);
        messageInserts.forEach(db.execute);
        db.execute("PRAGMA foreign_keys=on");
      });
      isOpened = true;
    }
    return _db;
  }
}
