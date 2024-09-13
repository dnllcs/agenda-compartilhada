import 'package:agenda_compartilhada/domain/interfaces/i_dao_user.dart';
import 'package:agenda_compartilhada/infrastructure/database/helper/connection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:agenda_compartilhada/domain/dto/dto_user.dart';

class DAOUser implements IDaoUser {
  late Database _db;

  final sqlInserir = '''
    INSERT INTO user (name, email, password, status)
    VALUES (?,?,?,?)
  ''';

  final sqlAlterar = '''
    UPDATE user SET name=?, email=?, password=?, status=?
    WHERE id = ?
  ''';

  final sqlAlterarStatus = '''
    UPDATE user SET status='I'
    WHERE id = ?
  ''';

  final sqlConsultarPorId = '''
    SELECT * FROM user WHERE id = ?;
  ''';

  final sqlConsultar = '''
    SELECT * FROM user;
  ''';

  @override
  Future<DTOUser> salvar(DTOUser dto) async {
    _db = await Connection.openDb();
    int id = await _db
        .rawInsert(sqlInserir, [dto.name, dto.email, dto.password, dto.status]);
    dto.id = id;
    return dto;
  }

  @override
  Future<bool> alterarStatus(int id) async {
    _db = await Connection.openDb();
    await _db.rawUpdate(sqlAlterarStatus, [id]);
    return true;
  }

  @override
  Future<DTOUser> alterar(DTOUser dto) async {
    _db = await Connection.openDb();
    await _db.rawUpdate(
        sqlAlterar, [dto.name, dto.email, dto.password, dto.status, dto.id]);
    return dto;
  }

  @override
  Future<DTOUser> consultarPorId(int id) async {
    _db = await Connection.openDb();
    var resultado = (await _db.rawQuery(sqlConsultarPorId, [id])).first;
    DTOUser user = DTOUser(
        id: resultado['id'],
        name: resultado['name'].toString(),
        email: resultado['email'].toString(),
        password: resultado['password'].toString(),
        status: resultado['status'].toString());
    return user;
  }

  @override
  Future<List<DTOUser>> consultar() async {
    _db = await Connection.openDb();
    var resultado = await _db.rawQuery(sqlConsultar);
    List<DTOUser> users = List.generate(resultado.length, (i) {
      var linha = resultado[i];
      return DTOUser(
          id: linha['id'],
          name: linha['name'].toString(),
          email: linha['email'].toString(),
          password: linha['password'].toString(),
          status: linha['status'].toString());
    });
    return users;
  }
}
