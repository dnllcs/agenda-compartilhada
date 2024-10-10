import 'package:agenda_compartilhada/rotas.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        TextButton(
            onPressed: () => Navigator.pushNamed(context, Rotas.details),
            child: const Text('Details')),
        TextButton(
            onPressed: () => Navigator.pushNamed(context, Rotas.form),
            child: const Text('Form'))
      ],
    ));
  }
}
