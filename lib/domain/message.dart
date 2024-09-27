import 'package:agenda_compartilhada/domain/user.dart';

class Message {
  dynamic? id;
  String type;
  String body;
  bool read;

  Message({required this.type, required this.body, required this.read}) {
    validateFields();
  }

  void validateFields() {
    validateType();
    validateBody();
  }

  void validateType() {
    const allowedTypes = ['info', 'warning', 'error'];
    if (!allowedTypes.contains(type)) {
      throw Exception(
          "O tipo da mensagem deve ser um dos seguintes: info, warning, error.");
    }
  }

  void validateBody() {
    if (body.length > 500) {
      throw Exception(
          "O tamanho do corpo da mensagem não pode ser maior que 500 caracteres.");
    }
  }
}
