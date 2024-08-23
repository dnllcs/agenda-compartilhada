import 'package:agenda_compartilhada/domain/dto/dto_user.dart';

class User {
  late dynamic? id;
  late String name;
  late String email;
  late String password;
  late String status;
  late DtoUser dtoUser;

  User({required this.dtoUser});
}
