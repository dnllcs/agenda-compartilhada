import 'package:agenda_compartilhada/domain/event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Event validation', () {
    test('Location validation error ', () {
      expect(() => Event('a' * 256, 'Description', DateTime.now().add(const Duration(days: 1)), 'public'), throwsException);
    });

    test('Date validation error ', () {
      expect(() => Event('Location', 'Description', DateTime.now().subtract(const Duration(days: 1)), 'public'), throwsException);
    });

    test('Valid Event creation', () {
      expect(() => Event('Location', 'Description', DateTime.now().add(const Duration(days: 1)), 'public'), returnsNormally);
    });
  });
}