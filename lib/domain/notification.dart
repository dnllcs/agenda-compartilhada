import 'package:agenda_compartilhada/domain/dto/dto_notification.dart';
import 'package:agenda_compartilhada/domain/dto/dto_user.dart';
import 'package:agenda_compartilhada/domain/user.dart';

class Notification {
  dynamic? id;
  late String type;
  late String title;
  late String content;
  late User user;

  Notification({required DTONotification dto}) {
    type = dto.type;
    title = dto.title;
    content = dto.content;
    user = User(dto: dto.dtoUser);
    validateFields();
  }

  void validateFields() {
    validateType();
    validateTitle();
    validateContent();
  }

  void validateType() {
    const allowedTypes = ['info', 'alert', 'update'];
    if (!allowedTypes.contains(type)) {
      throw Exception(
          "O tipo da notificação deve ser um dos seguintes: info, alert, update.");
    }
  }

  void validateTitle() {
    if (title.length > 255) {
      throw Exception(
          "O tamanho do título não pode ser maior que 255 caracteres.");
    }
  }

  void validateContent() {
    if (content.length > 2000) {
      throw Exception(
          "O tamanho do conteúdo não pode ser maior que 2000 caracteres.");
    }
  }
}
