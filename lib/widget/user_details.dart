import 'package:agenda_compartilhada/rotas.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        TextButton(
            onPressed: () => Navigator.pushNamed(context, Rotas.details),
            child: Text('Details')),
        TextButton(
            onPressed: () => Navigator.pushNamed(context, Rotas.form),
            child: Text('Form'))
      ],
    ));
  }
}
