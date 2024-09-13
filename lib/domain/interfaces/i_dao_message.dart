import 'package:agenda_compartilhada/domain/dto/dto_message.dart';

abstract class IDAOMessage {
  Future<DTOMessage> salvar(DTOMessage dto);
  Future<DTOMessage> alterar(DTOMessage dto);
  Future<bool> alterarReadStatus(int id);
  Future<DTOMessage> consultarPorId(int id);
  Future<List<DTOMessage>> consultar();
}
