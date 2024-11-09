import 'package:agenda_compartilhada/domain/dto/dto_user.dart';

class DTONotification {
  dynamic id;
  final String type;
  final String title;
  final String content;
  final DTOUser dtoUser;

  DTONotification(
      {this.id,
      required this.type,
      required this.title,
      required this.content,
      required this.dtoUser});
}
