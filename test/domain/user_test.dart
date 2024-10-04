import 'package:agenda_compartilhada/domain/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User validation', () {
    test('Name validation error', () {
      expect(
          () => User(
              name: 'a' * 256,
              email: 'valid@example.com',
              password: 'validPass123'),
          throwsException);
    });

    test('Email validation', () {
      expect(
          () => User(
              name: 'valido',
              email: 'valid@example.com' * 256,
              password: 'validPass123'),
          throwsException);
    });

    test('Password validation', () {
      expect(
          () => User(
              name: 'valido',
              email: 'valid@example.com',
              password: 'validPass123' * 256),
          throwsException);
    });

    test('Valid User creation', () {
      expect(
          () => User(
              name: 'valido',
              email: 'valid@example.com',
              password: 'validPass123'),
          returnsNormally);
    });
  });
}
