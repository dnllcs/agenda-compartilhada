class Notification {
  dynamic? id;
  String type;
  String title;
  String content;

  Notification(this.type, this.title, this.content) {
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
