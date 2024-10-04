import 'package:agenda_compartilhada/domain/event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Event validation', () {
    test('Location validation error ', () {
      expect(
          () => Event(
              location: 'a' * 256,
              description: 'Description',
              date: DateTime.now().add(const Duration(days: 1)),
              visibility: 'public',
              idUser: 1),
          throwsException);
    });

    test('Date validation error ', () {});
    expect(
        () => Event(
            location: 'a' * 256,
            description: 'Description',
            date: DateTime.now().subtract(const Duration(days: 1)),
            visibility: 'public',
            idUser: 1),
        throwsException);

    test('Valid Event creation', () {
      expect(
          () => Event(
              location: 'a' * 256,
              description: 'Description',
              date: DateTime.now().add(const Duration(days: 1)),
              visibility: 'public',
              idUser: 1),
          returnsNormally);
    });
  });
}
