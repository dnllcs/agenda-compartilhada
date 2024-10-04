class Event {
  dynamic? id;
  String location;
  String? description;
  DateTime date;
  DateTime createdAt = DateTime.now();
  String visibility;
  int idUser;

  Event(
      {required this.location,
      this.description,
      required this.date,
      required this.visibility,
      required this.idUser}) {
    validateDate();
  }

  void validateFields() {
    validateLocation();
    validateDate();
  }

  void validateLocation() {
    if (location.length > 255) {
      throw Exception(
          "O tamanho da localização não pode ser maior que 255 caracteres.");
    }
  }

  void validateDate() {
    if (date.isBefore(DateTime.now())) {
      throw Exception("A data do evento não pode ser anterior à data atual.");
    }
  }
}
