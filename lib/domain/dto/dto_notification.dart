class DTONotification {
  dynamic id;
  final String type;
  final String title;
  final String content;

  DTONotification({
    this.id,
    required this.type,
    required this.title,
    required this.content,
  });
}
