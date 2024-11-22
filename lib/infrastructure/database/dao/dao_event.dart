import 'package:agenda_compartilhada/domain/interfaces/i_dao_event.dart';
import 'package:agenda_compartilhada/infrastructure/database/helper/connection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:agenda_compartilhada/domain/dto/dto_event.dart';

class DAOEvent implements IDAOEvent {
  late Database _db;

  final sqlInserir = '''
    INSERT INTO event (location, description, date, createdAt, visibility)
    VALUES (?,?,?,?,?)
  ''';

  final sqlAlterar = '''
    UPDATE event SET location=?, description=?, date=?, createdAt=?, visibility=?
    WHERE id = ?
  ''';

  final sqlConsultarPorId = '''
    SELECT * FROM event WHERE id = ?;
  ''';

  final sqlConsultar = '''
    SELECT * FROM event;
  ''';

  @override
  Future<DTOEvent> salvar(DTOEvent dto) async {
    _db = await Connection.openDb();
    int id = await _db.rawInsert(sqlInserir, [
      dto.location,
      dto.description,
      dto.date.toIso8601String(),
      dto.createdAt.toIso8601String(),
      dto.visibility
    ]);
    dto.id = id;
    return dto;
  }

  @override
  Future<DTOEvent> alterar(DTOEvent dto) async {
    _db = await Connection.openDb();
    await _db.rawUpdate(sqlAlterar, [
      dto.location,
      dto.description,
      dto.date.toIso8601String(),
      dto.createdAt.toIso8601String(),
      dto.visibility,
      dto.id
    ]);
    return dto;
  }

  @override
  Future<DTOEvent> consultarPorId(int id) async {
    _db = await Connection.openDb();
    var resultado = (await _db.rawQuery(sqlConsultarPorId, [id])).first;
    DTOEvent event = DTOEvent(
      id: resultado['id'],
      location: resultado['location'].toString(),
      description: resultado['description']?.toString(),
      date: DateTime.parse(resultado['date'].toString()),
      createdAt: DateTime.parse(resultado['createdAt'].toString()),
      visibility: resultado['visibility'].toString(),
    );
    return event;
  }

  @override
  Future<List<DTOEvent>> consultar() async {
    _db = await Connection.openDb();
    var resultado = await _db.rawQuery(sqlConsultar);
    List<DTOEvent> events = List.generate(resultado.length, (i) {
      var linha = resultado[i];
      return DTOEvent(
        id: linha['id'],
        location: linha['location'].toString(),
        description: linha['description']?.toString(),
        date: DateTime.parse(linha['date'].toString()),
        createdAt: DateTime.parse(linha['createdAt'].toString()),
        visibility: linha['visibility'].toString(),
      );
    });
    return events;
  }

  @override
  Future<bool> alterarStatus(int id) {
    // TODO: implement alterarStatus
    throw UnimplementedError();
  }
}
