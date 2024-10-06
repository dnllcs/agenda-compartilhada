import 'package:agenda_compartilhada/domain/interfaces/i_dao_notification.dart';
import 'package:agenda_compartilhada/infrastructure/database/helper/connection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:agenda_compartilhada/domain/dto/dto_notification.dart';
import 'package:firebase_database/firebase_database.dart';

class DAONotification implements IDAONotification {
  late Database _db;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child('notifications');

  final sqlInserir = '''
    INSERT INTO notification (type, title, content)
    VALUES (?,?,?)
  ''';

  final sqlAlterar = '''
    UPDATE notification SET type=?, title=?, content=?
    WHERE id = ?
  ''';

  final sqlConsultarPorId = '''
    SELECT * FROM notification WHERE id = ?;
  ''';

  final sqlConsultar = '''
    SELECT * FROM notification;
  ''';

  @override
  Future<DTONotification> salvar(DTONotification dto) async {
    _db = await Connection.openDb();
    int id =
        await _db.rawInsert(sqlInserir, [dto.type, dto.title, dto.content]);
    dto.id = id;
    syncLocalToRemote();
    return dto;
  }

  @override
  Future<DTONotification> alterar(DTONotification dto) async {
    _db = await Connection.openDb();
    await _db.rawUpdate(sqlAlterar, [dto.type, dto.title, dto.content, dto.id]);
    syncLocalToRemote();
    return dto;
  }

  @override
  Future<DTONotification> consultarPorId(int id) async {
    _db = await Connection.openDb();
    var resultado = (await _db.rawQuery(sqlConsultarPorId, [id])).first;
    DTONotification notification = DTONotification(
        id: resultado['id'],
        type: resultado['type'].toString(),
        title: resultado['title'].toString(),
        content: resultado['content'].toString());
    return notification;
  }

  @override
  Future<List<DTONotification>> consultar() async {
    _db = await Connection.openDb();
    var resultado = await _db.rawQuery(sqlConsultar);
    List<DTONotification> notifications = List.generate(resultado.length, (i) {
      var linha = resultado[i];
      return DTONotification(
          id: linha['id'],
          type: linha['type'].toString(),
          title: linha['title'].toString(),
          content: linha['content'].toString());
    });
    return notifications;
  }

  Future<void> syncLocalToRemote() async {
  _db = await Connection.openDb();
  List<DTONotification> localNotifications = await consultar();
  for (var notification in localNotifications) {
    await databaseRef.child(notification.id.toString()).set({
      'type': notification.type,
      'title': notification.title,
      'content': notification.content,
    });
  }
}
}
