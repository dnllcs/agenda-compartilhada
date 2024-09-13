import 'package:agenda_compartilhada/domain/dto/dto_user.dart';

class User {
  dynamic? id;
  String name;
  String email;
  String password;
  String? status;

  User(this.name, this.email, this.password) {
    this.status = 'A';
    validateFields();
  }

  validateFields() {
    validateName();
    validateEmail();
    validatePassword();
  }

  validateName() {
    if (name.length > 255)
      throw Exception("O tamanho do name não pode ser maior que 255");
  }

  validateEmail() {
    var emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (email.length > 100) {
      throw Exception("O tamanho do email não pode ser maior que 100");
    }
    if (!emailRegExp.hasMatch(email)) {
      throw Exception("Email formatado incorretamente");
    }
  }

  validatePassword() {
    if (password.length > 50) {
      throw Exception("O tamanho da password não pode ser maior que 50");
    }
  }
}
