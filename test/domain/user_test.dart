import 'package:agenda_compartilhada/domain/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User validation', () {
    test('Name validation error', () {
      expect(() => User('a' * 256, 'valid@example.com', 'validPass123'), throwsException);
    });

    test('Email validation', () {
      expect(() => User('Valid Name', 'a' * 101 + '@example.com', 'validPass123'), throwsException);
    });

    test('Email validation error', () {
      expect(() => User('Valid Name', 'invalid-email', 'validPass123'), throwsException);
    });

    test('Password validation', () {
      expect(() => User('Valid Name', 'valid@example.com', 'a' * 51), throwsException);
    });

    test('Valid User creation', () {
      expect(() => User('Valid Name', 'valid@example.com', 'validPass123'), returnsNormally);
    });
  });
}