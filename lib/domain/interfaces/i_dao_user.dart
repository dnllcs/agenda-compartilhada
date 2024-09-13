import 'package:agenda_compartilhada/domain/dto/dto_user.dart';

abstract class IDaoUser {
  Future<DTOUser> salvar(DTOUser dto);
  Future<DTOUser> alterar(DTOUser dto);
  Future<bool> alterarStatus(int id);
  Future<DTOUser> consultarPorId(int id);
  Future<List<DTOUser>> consultar();
}
