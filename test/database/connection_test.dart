import 'package:agenda_compartilhada/infrastructure/database/helper/connection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

main() {
  late Database db;
  setUpAll(() async {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
    db = await Connection.openDb();
  });
  test('test create connection', () async {
    var list = await db.rawQuery('SELECT * FROM User');
    expect(list.length, 0);
  });
}