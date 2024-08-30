import 'package:agenda_compartilhada/domain/user.dart';

class Message {
  late dynamic? id;
  late String type;
  late String body;
  late bool read;

  Message({required this.type, required this.body, required this.read});
}
