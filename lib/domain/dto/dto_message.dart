class DTOMessage {
  dynamic id;
  final String type;
  final String body;
  final bool read;

  DTOMessage({
    this.id,
    required this.type,
    required this.body,
    required this.read,
  });
}
