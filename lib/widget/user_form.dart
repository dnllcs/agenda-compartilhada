import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('List')),
      ],
    ));
  }
}
