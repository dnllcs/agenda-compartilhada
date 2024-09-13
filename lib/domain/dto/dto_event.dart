class DTOEvent {
  dynamic id;
  final String location;
  final String? description;
  final DateTime date;
  final DateTime createdAt;
  final String visibility;

  DTOEvent({
    this.id,
    required this.location,
    this.description,
    required this.date,
    required this.createdAt,
    required this.visibility,
  });
}
