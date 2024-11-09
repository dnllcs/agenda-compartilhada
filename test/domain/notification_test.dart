import 'package:agenda_compartilhada/domain/dto/dto_user.dart';
import 'package:agenda_compartilhada/domain/dto/dto_notification.dart';
import 'package:agenda_compartilhada/domain/notification.dart';
import 'package:agenda_compartilhada/domain/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Notification validation', () {
    test('Type validation error', () {
      expect(
          () => Notification(
              dto: DTONotification(
                  type: 'tipo errado',
                  title: 'title',
                  content: 'content',
                  dtoUser: DTOUser(
                      name: 'nome',
                      email: 'email@email.com',
                      password: 'password'))),
          throwsException);
    });
  });

  test('Title validation error', () {
    expect(
        () => Notification(
            dto: DTONotification(
                type: 'tipo errado',
                title: 'title' * 100,
                content: 'content',
                dtoUser: DTOUser(
                    name: 'nome',
                    email: 'email@email.com',
                    password: 'password'))),
        throwsException);
  });

  test('Content validation error', () {
    expect(
        () => Notification(
            dto: DTONotification(
                type: 'tipo errado',
                title: 'title',
                content: 'content' * 100,
                dtoUser: DTOUser(
                    name: 'nome',
                    email: 'email@email.com',
                    password: 'password'))),
        throwsException);
  });

  test('Valid Notification creation', () {
    expect(
        () => Notification(
            dto: DTONotification(
                type: 'info',
                title: 'title',
                content: 'content',
                dtoUser: DTOUser(
                    name: 'nome',
                    email: 'email@email.com',
                    password: 'password'))),
        returnsNormally);
  });
}
