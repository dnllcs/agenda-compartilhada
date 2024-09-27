import 'package:agenda_compartilhada/rotas.dart';
import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text('List')),
      ],
    ));
  }
}
