import 'package:agenda_compartilhada/domain/interfaces/i_dao_message.dart';
import 'package:agenda_compartilhada/infrastructure/database/helper/connection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:agenda_compartilhada/domain/dto/dto_message.dart';
import 'package:firebase_database/firebase_database.dart';

class DAOMessage implements IDAOMessage {
  late Database _db;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child('messages');

  final sqlInserir = '''
    INSERT INTO message (type, body, read)
    VALUES (?,?,?)
  ''';

  final sqlAlterar = '''
    UPDATE message SET type=?, body=?, read=?
    WHERE id = ?
  ''';

  final sqlConsultarPorId = '''
    SELECT * FROM message WHERE id = ?;
  ''';

  final sqlConsultar = '''
    SELECT * FROM message;
  ''';

  @override
  Future<DTOMessage> salvar(DTOMessage dto) async {
    _db = await Connection.openDb();
    int id =
        await _db.rawInsert(sqlInserir, [dto.type, dto.body, dto.read ? 1 : 0]);
    dto.id = id;
    syncLocalToRemote();
    return dto;
  }

  @override
  Future<DTOMessage> alterar(DTOMessage dto) async {
    _db = await Connection.openDb();
    await _db
        .rawUpdate(sqlAlterar, [dto.type, dto.body, dto.read ? 1 : 0, dto.id]);
    syncLocalToRemote();
    return dto;
  }

  @override
  Future<DTOMessage> consultarPorId(int id) async {
    _db = await Connection.openDb();
    var resultado = (await _db.rawQuery(sqlConsultarPorId, [id])).first;
    DTOMessage message = DTOMessage(
        id: resultado['id'],
        type: resultado['type'].toString(),
        body: resultado['body'].toString(),
        read: resultado['read'] == 1);
    return message;
  }

  @override
  Future<List<DTOMessage>> consultar() async {
    _db = await Connection.openDb();
    var resultado = await _db.rawQuery(sqlConsultar);
    List<DTOMessage> messages = List.generate(resultado.length, (i) {
      var linha = resultado[i];
      return DTOMessage(
          id: linha['id'],
          type: linha['type'].toString(),
          body: linha['body'].toString(),
          read: linha['read'] == 1);
    });
    return messages;
  }
  
  @override
  Future<bool> alterarReadStatus(int id) {
    // TODO: implement alterarReadStatus
    throw UnimplementedError();
  }

  Future<void> syncLocalToRemote() async {
    _db = await Connection.openDb();
    List<DTOMessage> localMessages = await consultar();

    for (var message in localMessages) {
      await databaseRef.child(message.id.toString()).set({
        'type': message.type,
        'body': message.body,
        'read': message.read,
      });
    }
  }
}
