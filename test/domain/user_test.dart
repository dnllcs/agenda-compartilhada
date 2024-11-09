import 'package:agenda_compartilhada/domain/dto/dto_user.dart';
import 'package:agenda_compartilhada/domain/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User validation', () {
    test('Name validation error', () {
      expect(
          () => User(
              dto: DTOUser(
                  name: 'nome' * 100,
                  email: 'valid@example.com',
                  password: 'validPass123')),
          throwsException);
    });

    test('Email validation', () {
      expect(
          () => User(
              dto: DTOUser(
                  name: 'nome' * 100,
                  email: 'erradoexample.com',
                  password: 'validPass123')),
          throwsException);
    });

    test('Password validation', () {
      expect(
          () => User(
              dto: DTOUser(
                  name: 'nome',
                  email: 'valid@example.com',
                  password: 'validPass123' * 100)),
          throwsException);
    });

    test('Valid User creation', () {
      expect(
          () => User(
              dto: DTOUser(
                  name: 'nome',
                  email: 'valid@example.com',
                  password: 'validPass123' * 100)),
          returnsNormally);
    });
  });
}
