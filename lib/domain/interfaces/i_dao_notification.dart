import 'package:agenda_compartilhada/domain/dto/dto_notification.dart';

abstract class IDAONotification {
  Future<DTONotification> salvar(DTONotification dto);
  Future<DTONotification> alterar(DTONotification dto);
  Future<DTONotification> consultarPorId(int id);
  Future<List<DTONotification>> consultar();
}
