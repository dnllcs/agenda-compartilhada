import 'package:agenda_compartilhada/domain/notification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Notification validation', () {
    test('Type validation error', () {
      expect(
          () => Notification(
              type: 'invalid',
              title: 'Valid Title',
              content: 'Valid content',
              idUser: 1),
          throwsException);
    });

    test('Title validation error', () {
      expect(
          () => Notification(
              type: 'invalid',
              title: 'Valid Title' * 100,
              content: 'Valid content',
              idUser: 1),
          throwsException);
    });

    test('Content validation error', () {
      expect(
          () => Notification(
              type: 'invalid',
              title: 'Valid Title',
              content: 'Valid content' * 100,
              idUser: 1),
          throwsException);
    });

    test('Valid Notification creatio', () {
      expect(
          () => Notification(
              type: 'invalid',
              title: 'Valid Title',
              content: 'Valid content',
              idUser: 1),
          returnsNormally);
    });
  });
}
