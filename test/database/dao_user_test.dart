import 'package:agenda_compartilhada/domain/dto/dto_user.dart';
import 'package:agenda_compartilhada/domain/interfaces/i_dao_user.dart';
import 'package:agenda_compartilhada/infrastructure/database/dao/dao_user.dart';
import 'package:agenda_compartilhada/infrastructure/database/helper/connection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

main() {
  late Database db;
  late IDAOUser dao;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    dao = DAOUser();
  });

  setUp(() async {
    db = await Connection.openDb();
  });

  tearDown(() async {
    deleteDatabase(db.path);
    db = await Connection.openDb();
  });

  tearDownAll(() async {
    db.close();
  });

  test('user dao - save test', () async {
    var dto = DTOUser(
        name: 'DanielsTeste',
        email: 'DanielsTeste@gmail.com',
        status: 'A',
        password: 'DanielsTestePassword');
    dto = await dao.salvar(dto);

    expect(dto.id, isPositive);
  });

  test('user dao - alter test', () async {
    var dto = DTOUser(
        name: 'DanielsTeste',
        email: 'DanielsTeste@gmail.com',
        status: 'A',
        password: 'DanielsTestePassword');
    dto = await dao.salvar(dto);

    var dtoAlterado = DTOUser(
        id: dto.id,
        name: 'DanielsTesteAlterado',
        email: 'DanielsTeste@gmail.com',
        status: 'A',
        password: 'DanielsTestePassword');
    dtoAlterado = await dao.alterar(dtoAlterado);
    expect(dtoAlterado.name, "DanielsTesteAlterado");
  });

  test('user dao - consult by id test', () async {
    var dto = DTOUser(
        name: 'DanielsTeste',
        email: 'DanielsTeste@gmail.com',
        status: 'A',
        password: 'DanielsTestePassword');
    dto = await dao.salvar(dto);

    var consultedDto = await dao.consultarPorId(dto.id);
    expect(consultedDto.id, dto.id);
    expect(consultedDto.name, dto.name);
  });

  test('user dao - consult all users test', () async {
    var dto1 = DTOUser(
        name: 'User1',
        email: 'user1@gmail.com',
        status: 'A',
        password: 'Password1');
    var dto2 = DTOUser(
        name: 'User2',
        email: 'user2@gmail.com',
        status: 'A',
        password: 'Password2');

    await dao.salvar(dto1);
    await dao.salvar(dto2);

    var users = await dao.consultar();
    expect(users.length, 2);
    expect(users.any((user) => user.name == dto1.name), true);
    expect(users.any((user) => user.name == dto2.name), true);
  });

  test('user dao - alter status test', () async {
    var dto = DTOUser(
        name: 'DanielsTeste',
        email: 'DanielsTeste@gmail.com',
        status: 'A',
        password: 'DanielsTestePassword');
    dto = await dao.salvar(dto);

    await dao.alterarStatus(dto.id);
    var consultedDto = await dao.consultarPorId(dto.id);
    expect(consultedDto.status, 'I');
  });

  test('user dao - invalid id test', () async {
    expect(
        () async => await dao.consultarPorId(999), throwsA(isA<StateError>()));
  });
}
