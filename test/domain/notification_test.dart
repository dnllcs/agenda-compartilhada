import 'package:agenda_compartilhada/domain/notification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Notification validation', () {
    test('Type validation error', () {
      expect(() => Notification('invalid', 'Valid Title', 'Valid content'), throwsException);
    });

    test('Title validation error', () {
      expect(() => Notification('info', 'a' * 256, 'Valid content'), throwsException);
    });

    test('Content validation error', () {
      expect(() => Notification('alert', 'Valid Title', 'a' * 2001), throwsException);
    });

    test('Valid Notification creatio', () {
      expect(() => Notification('info', 'Valid Title', 'Valid content'), returnsNormally);
    });

    test('Valid Notification creation', () {
      expect(() => Notification('alert', 'Valid Title', 'Valid content'), returnsNormally);
    });

    test('Valid Notification creation', () {
      expect(() => Notification('update', 'Valid Title', 'Valid content'), returnsNormally);
    });
  });
}
