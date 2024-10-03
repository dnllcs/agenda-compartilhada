import 'package:agenda_compartilhada/domain/message.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  group('Message validation', () {
    test('Type validation error ', () {
      expect(() => Message(type: 'invalid', body: 'Test message', read: false), throwsException);
    });

    test('Body validation error ', () {
      expect(() => Message(type: 'info', body: 'a' * 501, read: false), throwsException);
    });

    test('Valid Message creation info', () {
      expect(() => Message(type: 'info', body: 'Test message', read: false), returnsNormally);
    });

    test('Valid Message creation warning', () {
      expect(() => Message(type: 'warning', body: 'Test message', read: false), returnsNormally);
    });

    test('Valid Message creation error', () {
      expect(() => Message(type: 'error', body: 'Test message', read: false), returnsNormally);
    });
  });
}