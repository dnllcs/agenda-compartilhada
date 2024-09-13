import 'package:agenda_compartilhada/domain/dto/dto_event.dart';

abstract class IDAOEvent {
  Future<DTOEvent> salvar(DTOEvent dto);
  Future<DTOEvent> alterar(DTOEvent dto);
  Future<bool> alterarStatus(int id);
  Future<DTOEvent> consultarPorId(int id);
  Future<List<DTOEvent>> consultar();
}
